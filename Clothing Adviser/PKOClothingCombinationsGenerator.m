//
//  PKOClothingCombinationsGenerator.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 17/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombinationsGenerator.h"
#import "PKOUser.h"
#import "PKOClothingCombination.h"
#import "PKOClothingCombinationStore.h"
#import "PKOClothingProbabilities.h"


static NSUInteger const PKOGeneratedCombinationsFinalCount = 10;
static NSUInteger const PKOGeneratedCombinationsProbabilityCount = 15;
static NSUInteger const PKOGeneratingCombinationsMaxIterations = 2000;
static double const PKOGeneratingCombinationsInitialTemperature = 100;
static double const PKOGeneratingCombinationsCoolingRate = 0.97;
static double const PKOGeneratingCombinationsProbabilityRatingThreshold = 0.72;


@interface PKOClothingCombinationsGenerator ()

@property (strong, nonatomic) PKOUser *user;
@property (assign, nonatomic) PKODressCode dressCode;
@property (copy, nonatomic) NSSet *alreadyGeneratedClothingCombinations;
@property (strong, nonatomic) PKOClothingProbabilities *probabilities;

@end


@implementation PKOClothingCombinationsGenerator

#pragma mark - Lifecycle

- (instancetype)initWithUser:(PKOUser *)user withDressCode:(PKODressCode)dressCode
{
	self = [super init];
	if (self)
	{
		_user = user;
		_dressCode = dressCode;
	}
	
	return self;
}

#pragma mark - Generating combinations

- (NSArray *)generateCombinations
{
	[self setupAlreadyGeneratedClothingCombinations];
	self.probabilities = [[PKOClothingProbabilities alloc] initWithUser:self.user
														  withDressCode:self.dressCode];
	
	NSDate *start;
	NSTimeInterval elapsed;
	NSArray *combinations;
	
	//simulated annealing
//	NSLog(@"START simulated annealing");
//	start = [NSDate date];
//	combinations = [self generateCombinationsWithSimulatedAnnealing];
//	elapsed = fabs([start timeIntervalSinceNow]);
//	NSLog(@"END: %f", elapsed);
	
	//simple hillclimbing
//	NSLog(@"START hill climbing");
//	start = [NSDate date];
//	combinations = [self generateCombinationsWithHillClimbing];
//	elapsed = fabs([start timeIntervalSinceNow]);
//	NSLog(@"END: %f", elapsed);

	//**** BEST **** random hillclimbing
	NSLog(@"START random hill climbing");
	start = [NSDate date];
	combinations = [self generateCombinationsWithRandomHillClimbing];
	elapsed = fabs([start timeIntervalSinceNow]);
	NSLog(@"END: %f", elapsed);
	
	//random combinations with threshold
//	float threshold = 0.7;
//	NSLog(@"START random with threshold: %f", threshold);
//	start = [NSDate date];
//	combinations = [self generateRandomCombinationsWithThreshold:threshold];
//	elapsed = fabs([start timeIntervalSinceNow]);
//	NSLog(@"END: %f", elapsed);
	
	return combinations;
}

#pragma mark - Simulated annealing / quenching

- (NSArray *)generateCombinationsWithSimulatedAnnealing
{
	NSMutableArray *combinations = [[NSMutableArray alloc] init];
	
	PKOClothingCombination *currentCombination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:self.user.clothingItemStore
																											 withGender:self.user.genderType
																										  withDressCode:self.dressCode];
	PKOClothingCombination *newCombination;
	double currentRating = [currentCombination computeOverallRating:self.probabilities];
	double newRating = 0.0;
	srand48(time(0));
	
	double temp = PKOGeneratingCombinationsInitialTemperature;
	for (NSUInteger i = 0; i < PKOGeneratingCombinationsMaxIterations; ++i)
	{
		newCombination = [currentCombination randomVariation];
		newRating = [newCombination computeOverallRating:self.probabilities];
		

		if (newRating > currentRating) {
			//take better without questions
			currentCombination = newCombination;
			currentRating = newRating;
			[combinations addObject:currentCombination];
			NSLog(@"bestRating: %f, i: %lu", currentRating, (unsigned long)i);
		} else if ([self shouldAcceptWorseSolution:currentRating newRating:newRating temperature:temp]) {
			//worse but we are lucky, get out of here
			newCombination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:self.user.clothingItemStore
																							 withGender:self.user.genderType
																						  withDressCode:self.dressCode];
			newRating = [currentCombination computeOverallRating:self.probabilities];
			if (newRating > currentRating) {
				//new random is suprisingly good
				[combinations addObject:newCombination];
				NSLog(@"taking new random, rating: %f", newRating);
			}
			//take new starting point
			currentCombination = newCombination;
			currentRating = newRating;
			NSLog(@"jump, i: %lu", (unsigned long)i);
		}
		temp *= PKOGeneratingCombinationsCoolingRate;
	}
	
	return [combinations copy];
}

- (BOOL)shouldAcceptWorseSolution:(double)currentRating newRating:(double)newRating temperature:(double)temperature
{
	double deltaRating = fabsf(currentRating - newRating);
	double acceptanceProbability = expf(-deltaRating / temperature);
	
//	NSLog(@"currentRating: %f, newRating: %f, prob: %f", currentRating, newRating, acceptanceProbability);
	
	double random = drand48();
	BOOL shouldAccept = acceptanceProbability > random;
	
	return shouldAccept;
}

#pragma mark - Hill climbing

- (NSArray *)generateCombinationsWithHillClimbing
{
	NSMutableArray *combinations = [[NSMutableArray alloc] init];
	
	PKOClothingCombination *combination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:self.user.clothingItemStore
																									  withGender:self.user.genderType
																								   withDressCode:self.dressCode];
	
	float rating = 0.0, bestRating = 0.0;
	for (NSUInteger i = 0; i < PKOGeneratingCombinationsMaxIterations; ++i)
	{
		combination = [combination randomVariation];
		rating = [combination computeOverallRating:self.probabilities];
//		rating = [combination computeOnlyProbabilityRating:self.probabilities];
//		rating = [combination computeOnlyColorRatingWithShuffleColors:NO];
		
		if (rating > bestRating) {
			bestRating = rating;
			[combinations addObject:combination];
//			NSLog(@"bestRating: %f, i: %lu", bestRating, (unsigned long)i);
		}
	}
	
	NSArray *descendingResultCombinations = [self sortGeneratedCombinations:combinations bestFirst:YES];
	return descendingResultCombinations;
}

#pragma mark - Random hill climbing - Simulated Quenching

- (NSArray *)generateCombinationsWithRandomHillClimbing
{
	NSMutableSet *combinations = [[NSMutableSet alloc] init];
	PKOClothingCombination *combination;
	NSUInteger ratioBetweenLoops = 20;
	NSUInteger randomStartIterations = PKOGeneratingCombinationsMaxIterations / ratioBetweenLoops;
	NSUInteger hillClimbingIterations = ratioBetweenLoops;
	
	//generating probability (style) combinations
	float rating = 0.0;
	for (NSUInteger i = 0; i < randomStartIterations; ++i)
	{
		combination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:self.user.clothingItemStore
																				  withGender:self.user.genderType
																			   withDressCode:self.dressCode];

		for (NSUInteger j = 0; j < hillClimbingIterations; ++j)
		{
			rating = [combination computeOnlyProbabilityRating:self.probabilities];
			if (rating > PKOGeneratingCombinationsProbabilityRatingThreshold) {
				BOOL isAlreadyGenerated = [self isAlreadyGeneratedClothingCombination:combination];
				if (!isAlreadyGenerated) {
					[combinations addObject:combination];
				}
			}
			combination = [combination randomVariation];
		}
	}

	NSArray *sortedProbabilitiesCombinations = [self sortGeneratedCombinations:combinations.allObjects bestFirst:YES];
	sortedProbabilitiesCombinations = [self sliceGeneratedCombinations:sortedProbabilitiesCombinations toLength:PKOGeneratedCombinationsProbabilityCount];

	//compute color ratings for best probabilitiesCombination
	for (PKOClothingCombination *combination in sortedProbabilitiesCombinations) {
		[combination computeOnlyColorRatingWithShuffleColors:YES];
	}
	NSArray *sortedColorCombinations = [self sortGeneratedCombinations:sortedProbabilitiesCombinations bestFirst:YES];
	sortedColorCombinations = [self sliceGeneratedCombinations:sortedColorCombinations toLength:PKOGeneratedCombinationsFinalCount];
	
	return sortedColorCombinations;
}

#pragma mark - Random generating with threshold

- (NSArray *)generateRandomCombinationsWithThreshold:(float)threshold
{
	NSMutableSet *combinations = [[NSMutableSet alloc] init];
	NSUInteger iterations = PKOGeneratingCombinationsMaxIterations;
	
	PKOClothingCombination *combination;
	float rating = 0.0, bestRating = 0.0;
	for (NSUInteger i = 0; i < iterations; ++i)
	{
		combination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:self.user.clothingItemStore
																				  withGender:self.user.genderType
																			   withDressCode:self.dressCode];
		rating = [combination computeOverallRating:self.probabilities];
//		rating = [combination computeOnlyProbabilityRating:self.probabilities];
//		rating = [combination computeOnlyColorRatingWithShuffleColors:NO];
		
		BOOL isAlreadyGenerated = [self isAlreadyGeneratedClothingCombination:combination];
		if (rating > threshold && !isAlreadyGenerated) {
			if (rating > bestRating) {
				bestRating = rating;
//				NSLog(@"bestRating: %f", bestRating);
			}
			[combinations addObject:combination];
//			NSLog(@"rating: %f, i: %lu", rating, (unsigned long)i);
		}
	}
	
	NSArray *descendingResultCombinations = [self sortGeneratedCombinations:combinations.allObjects bestFirst:YES];
	descendingResultCombinations = [self sliceGeneratedCombinations:descendingResultCombinations toLength:PKOGeneratedCombinationsFinalCount];
	return descendingResultCombinations;
}

#pragma mark - Setting already generated combinations

- (void)setupAlreadyGeneratedClothingCombinations
{
	NSArray *generatedCombinationsForDressCode = [self.user.clothingCombinationStore clothingCombinationsWithDressCode:self.dressCode];
	NSSet *refusedCombinations = [self.user.clothingCombinationStore refusedClothingCombinations];

	NSMutableArray *alreadyGeneratedCombinations = [[NSMutableArray alloc] initWithArray:generatedCombinationsForDressCode];
	[alreadyGeneratedCombinations addObjectsFromArray:refusedCombinations.allObjects];
	
	self.alreadyGeneratedClothingCombinations = [NSSet setWithArray:alreadyGeneratedCombinations];
}

#pragma mark - Checking already generated combinations

- (BOOL)isAlreadyGeneratedClothingCombination:(PKOClothingCombination *)combination
{
	BOOL isAlreadyGenerated = [self.alreadyGeneratedClothingCombinations containsObject:combination];
	return isAlreadyGenerated;
}

#pragma mark - Sorting generated combinations

- (NSArray *)sortGeneratedCombinations:(NSArray *)combinations bestFirst:(BOOL)bestFirst
{
	NSArray *sorted = [combinations sortedArrayUsingComparator:^NSComparisonResult(PKOClothingCombination *combination1, PKOClothingCombination *combination2)
	{
		if (combination1.rating > combination2.rating) {
			return bestFirst ? NSOrderedAscending : NSOrderedDescending;
		} else if (combination1.rating < combination2.rating) {
			return bestFirst ? NSOrderedDescending : NSOrderedAscending;
		}
		return NSOrderedSame;
	}];
	
	return sorted;
}

#pragma mark - Slice generated combinations

- (NSArray *)sliceGeneratedCombinations:(NSArray *)combinations toLength:(NSUInteger)length
{
	NSUInteger minLength = MIN(combinations.count, length);
	return [combinations subarrayWithRange:NSMakeRange(0, minLength)];
}

@end




















