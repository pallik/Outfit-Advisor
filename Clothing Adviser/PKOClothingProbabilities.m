//
//  PKOClothesProbabilities.m
//  ClothesProbabilities
//
//  Created by Pavol Kominak on 13/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingProbabilities.h"
#import "PKOUser.h"
#import "PKOCSVHandler.h"
#import "PKOClothingCombination.h"
#import "PKOClothingItem.h"

static NSString *const PKOProbabilityFileURLExtension = @"csv";
static NSUInteger const PKOMarginalProbabilityWeight = 1;
static NSUInteger const PKOJointProbabilityWeight = 5;

@interface PKOClothingProbabilities ()

@property (strong, nonatomic) PKOUser *user;
@property (nonatomic) PKODressCode dressCode;
@property (strong, nonatomic) NSMutableArray *probablityTable;

@property (strong, nonatomic) PKOCSVHandler *csvHandler;

@end


@implementation PKOClothingProbabilities

#pragma mark - Lifecycle

- (instancetype)initWithUser:(PKOUser *)user withDressCode:(PKODressCode)dressCode
{
	if (self = [super init]) {
		_user = user;
		_dressCode = dressCode;
		_probablityTable = [[NSMutableArray alloc] init];
		_csvHandler = [[PKOCSVHandler alloc] init];
		
		[self loadProbabilityTable];
	}
	
	return self;
}

#pragma mark - Probability table handling

- (void)loadProbabilityTable
{
	NSURL *csvURL = [self URLForLoadingProbabilityTable];

	self.probablityTable = [NSMutableArray arrayWithArray:[self.csvHandler loadFromCSV:csvURL]];
//	NSLog(@"%@", self.probablityTable);
}

- (void)saveChanges
{
	NSURL *csvURL = [self URLForSavingProbabilityTable];
	[self.csvHandler saveRows:self.probablityTable toCSV:csvURL];
}

- (void)addNewClothingCombination:(PKOClothingCombination *)clothingCombination
{
	NSMutableArray *newRow = [[NSMutableArray alloc] initWithCapacity:PKOBodyPartSize()];
	for (NSUInteger i = 0; i < PKOBodyPartSize(); ++i) {
		[newRow addObject:@(PKOClothingCategoryNone)];
	}
	
	NSArray *clothingItems = [clothingCombination clothingItems].allObjects;
	for (PKOClothingItem *item in clothingItems) {
		newRow[item.bodyPart] = @(item.clothingCategory);
	}
	
	[self.probablityTable addObject:newRow];
}

#pragma mark - Computing probabilites

- (float)probabilityForClothingCombination:(PKOClothingCombination *)clothingCombination
{
	float totalProbability = 0.0,
		marignalAverageProbability = 0.0,
		jointProbability = 0.0;
	
	NSArray *clothingItems = [clothingCombination clothingItems].allObjects;

	NSUInteger allBodyPartsCount = PKOBodyPartSize();
	NSUInteger marginalProbabilityCounts[allBodyPartsCount];
	// array for storing clothing categories in all body parts
	PKOClothingCategory clothingCategoriesInAllBodyParts[allBodyPartsCount]; //USED FOR PKOClothingCategoryNone
	
	// fill marginal probability counts with zeros
	// fill all body parts with PKOClothingCategoryNone
	for (NSUInteger i = 0; i < allBodyPartsCount; ++i) {
		marginalProbabilityCounts[i] = 0;
		clothingCategoriesInAllBodyParts[i] = PKOClothingCategoryNone;
	}
	
	// fill body parts with items worn, other body parts are PKOClothingCategoryNone
	for (PKOClothingItem *item in clothingItems) {
		clothingCategoriesInAllBodyParts[item.bodyPart] = item.clothingCategory;
	}
	

	BOOL areAllItemsInRow = YES;
	NSUInteger jointProbabilityCount = 0;
	
	for (NSArray *row in self.probablityTable) {
		areAllItemsInRow = YES;

		// Computing only with items worn
//		for (PKOClothingItem *item in clothingItems) {
//			if (((NSNumber *)row[item.bodyPart]).integerValue == item.clothingCategory) {
//				marginalProbabilityCounts[item.bodyPart]++;
//			} else {
//				areAllItemsInRow = NO;
//			}
//		}
	
		// Computing with PKOClothingCategoryNone
		for (NSUInteger i = 0; i < allBodyPartsCount; ++i) {
			if (((NSNumber *)row[i]).integerValue == clothingCategoriesInAllBodyParts[i]) {
				marginalProbabilityCounts[i]++;
			} else {
				areAllItemsInRow = NO;
			}
		}
	
		if (areAllItemsInRow) {
			jointProbabilityCount++;
		}
	}
	
	NSUInteger totalRowsCount = self.probablityTable.count;
	
	for (NSUInteger i = 0; i < allBodyPartsCount; ++i) {
//		NSLog(@"marginalProbabilityCounts[%lu] = %lu", (unsigned long)i, (unsigned long)marginalProbabilityCounts[i]);
		marignalAverageProbability += marginalProbabilityCounts[i];
	}
	marignalAverageProbability /= (float)allBodyPartsCount; // WITH PKOClothingCategoryNone
//	marignalAverageProbability /= (float)clothingItems.count; // ONLY ITEMS WORN
	marignalAverageProbability /= totalRowsCount;
//	NSLog(@"marignalAverageProbability = %f", marignalAverageProbability);
	
	jointProbability = (float)jointProbabilityCount / totalRowsCount;
//	NSLog(@"jointProbabilityCount = %lu", (unsigned long)jointProbabilityCount);
//	NSLog(@"jointProbability = %f", jointProbability);
	
//	NSLog(@"totalRows: %lu", (unsigned long)self.probablityTable.count);
	
	
	totalProbability = PKOMarginalProbabilityWeight * marignalAverageProbability + PKOJointProbabilityWeight * jointProbability;
	return totalProbability;
}

#pragma mark - URL handling

- (NSURL *)URLForSavingProbabilityTable
{
	NSString *defaultCsvFilename = [self csvFilenameWithGenderType:self.user.genderType withDressCode:self.dressCode];
	NSString *userCsvFilename = [NSString stringWithFormat:@"%@.%@", self.user.userID, defaultCsvFilename];
	
	NSURL *documentDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	
	NSURL *userCsvURLwithoutExtension = [documentDirectoryURL URLByAppendingPathComponent:userCsvFilename];
	NSURL *userCsvURL = [userCsvURLwithoutExtension URLByAppendingPathExtension:PKOProbabilityFileURLExtension];
	
	return userCsvURL;
}

- (NSURL *)URLForLoadingProbabilityTable
{
	NSURL *userCsvURL = [self URLForSavingProbabilityTable];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:userCsvURL.path]) {
		return userCsvURL;
	} else {
		NSString *defaultCsvFilename = [self csvFilenameWithGenderType:self.user.genderType withDressCode:self.dressCode];
		NSURL *defaultCsvURL = [[NSBundle mainBundle] URLForResource:defaultCsvFilename withExtension:PKOProbabilityFileURLExtension];
		return defaultCsvURL;
	}
}

- (NSString *)csvFilenameWithGenderType:(PKOGenderType)genderType withDressCode:(PKODressCode)dressCode
{
	NSString *genderTypeString = NSStringFromPKOGenderType(genderType);
	NSString *dressCodeString = NSStringFromPKODressCode(dressCode);
	
	return [NSString stringWithFormat:@"%@_%@", genderTypeString, dressCodeString];
}

@end


















