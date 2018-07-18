//
//  PKOCSVHandler.m
//  ClothesProbabilities
//
//  Created by Pavol Kominak on 14/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOCSVHandler.h"
#import "PKOClothingConstants.h"

//static NSInteger const PKONumberForNotNumberField = -1;
static NSInteger const PKONumberForNotNumberField = PKOClothingCategoryNone;

@interface PKOCSVHandler ()

@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSMutableArray *currentRow;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation PKOCSVHandler

#pragma mark - Loading & Saving from CSV

- (NSArray *)loadFromCSV:(NSURL *)csvURL
{
	if (![[NSFileManager defaultManager] fileExistsAtPath:csvURL.path]) {
		return [NSArray array];
	}
	
	CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVURL:csvURL];
	parser.delegate = self;
	parser.recognizesBackslashesAsEscapes = YES;
	parser.sanitizesFields = YES;
	
	[parser parse];
	
	return [NSArray arrayWithArray:self.rows];
}

- (void)saveRows:(NSArray *)rows toCSV:(NSURL *)csvURL
{
	CHCSVWriter *writer = [[CHCSVWriter alloc] initForWritingToCSVFile:csvURL.path];
	for (NSArray *row in rows) {
		[writer writeLineOfFields:row];
	}
}

#pragma mark - CHCSVParserDelegate

- (void)parserDidBeginDocument:(CHCSVParser *)parser
{
	self.rows = [[NSMutableArray alloc] init];
	self.numberFormatter = [[NSNumberFormatter alloc] init];
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
	self.currentRow = [[NSMutableArray alloc] init];
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
	NSNumber *number = [self.numberFormatter numberFromString:field];
	if (!number) {
		number = @(PKONumberForNotNumberField);
	}
	[self.currentRow addObject:number];
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber
{
	[self.rows addObject:self.currentRow];
	self.currentRow = nil;
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
	self.rows = nil;
	NSLog(@"CHCSVParser ERROR: %@", [error localizedDescription]);
}

@end


















