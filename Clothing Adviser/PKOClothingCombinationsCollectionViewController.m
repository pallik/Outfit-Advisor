//
//  PKOClothingCombinationsCollectionViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 16/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombinationsCollectionViewController.h"
#import "PKOClothingCombinationsDataSource.h"
#import "PKOGeneratingClothingCombinationsViewController.h"
#import "PKOClothingCombinationCollectionViewController.h"

#import "PKOClothingCombinationsGenerator.h"

#import "PKOUser.h"
#import "PKOClothingItem.h"
#import "PKOClothingCombinationStore.h"

#import "PKOClothingItemCollectionViewCell.h"

static NSString *const PKOGeneratingClothingCombinationsSegueIdentifier = @"GeneratingClothingCombinationsSegueIdentifier";
static NSString *const PKOClothingCombinationSegueIdentifier = @"ClothingCombinationSegueIdentifier";

static CGFloat const PKOClothingCombinationsSeparatorViewHeight = 20.0;

@interface PKOClothingCombinationsCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) PKOClothingCombinationsDataSource *clothingCombinationsDataSource;
@property (assign, nonatomic) PKODressCode selectedDressCode;

@end

@implementation PKOClothingCombinationsCollectionViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//default dressCode
	self.selectedDressCode = PKODressCodeCasual;
	[self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self setClothingItemsForDataSource:self.clothingCombinationsDataSource];
	[self.collectionView reloadData];
}

#pragma mark - Setup UICollectionView

- (void)setupCollectionView
{
	NSString *separatorViewReusableIdentifier = NSStringFromClass([UICollectionReusableView class]);

	[self.collectionView registerClass:[UICollectionReusableView class]
			forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
				   withReuseIdentifier:separatorViewReusableIdentifier];
	
	void (^configureCell)(PKOClothingItemCollectionViewCell *, PKOClothingItem *) = ^(PKOClothingItemCollectionViewCell* cell, PKOClothingItem *clothingItem) {
		cell.backgroundColor = [UIColor clearColor];
		cell.imageView.image = clothingItem.thumbnail;
	};
	
	self.clothingCombinationsDataSource = [[PKOClothingCombinationsDataSource alloc] init];
	self.clothingCombinationsDataSource.configureCellBlock = configureCell;
	[self setClothingItemsForDataSource:self.clothingCombinationsDataSource];
	
	self.collectionView.dataSource = self.clothingCombinationsDataSource;
}

- (void)setClothingItemsForDataSource:(PKOClothingCombinationsDataSource *)dataSource
{
	dataSource.clothingCombinations = [self.user.clothingCombinationStore clothingCombinationsWithDressCode:self.selectedDressCode];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize size = CGSizeMake(PKOThumbnailSizeWidth, PKOThumbnailSizeHeight);
	
	return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
	CGSize headerViewSize = flowLayout.headerReferenceSize;
	
	if (section > 0) {
		headerViewSize.height = PKOClothingCombinationsSeparatorViewHeight;
	}
	
	return headerViewSize;
}

#pragma mark - IBAction

- (IBAction)dressCodeChanged:(id)sender
{
	UISegmentedControl *segmentedControl = sender;
	self.selectedDressCode = segmentedControl.selectedSegmentIndex;
	[self setClothingItemsForDataSource:self.clothingCombinationsDataSource];
	
	[self.collectionView reloadData];
}

#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOGeneratingClothingCombinationsSegueIdentifier]) {
		
		UINavigationController *navigationController = segue.destinationViewController;
		PKOGeneratingClothingCombinationsViewController *generatingCombinationsController = navigationController.viewControllers.firstObject;
		
		generatingCombinationsController.dressCode = self.selectedDressCode;
		generatingCombinationsController.user = self.user;
		
	} else if ([segue.identifier isEqualToString:PKOClothingCombinationSegueIdentifier]) {
		
		PKOClothingItemCollectionViewCell *cell = sender;
		NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
		PKOClothingCombination *clothingCombination = [self.clothingCombinationsDataSource clothingCombinationInSection:indexPath.section];
		
		PKOClothingCombinationCollectionViewController *combinationViewController = segue.destinationViewController;
		combinationViewController.clothingCombination = clothingCombination;
		combinationViewController.user = self.user;
	}
}

- (IBAction)cancelToClothingCombinationsViewController:(UIStoryboardSegue *)segue {
}

- (IBAction)saveNewClothingCombinationUnwindToClothingCombinationsViewController:(UIStoryboardSegue *)segue
{
	PKOGeneratingClothingCombinationsViewController *generatingCombinationsController = segue.sourceViewController;
	PKOClothingCombination *newClothingCombination = generatingCombinationsController.selectedClothingCombination;
	
	[self.user saveNewClothingCombination:newClothingCombination];
	
	[self setClothingCombinationsDataSource:self.clothingCombinationsDataSource];
	[self.collectionView reloadData];
}

- (IBAction)deleteClothingCombinationUnwindToClothingCombinationsViewController:(UIStoryboardSegue *)segue
{
	PKOClothingCombinationCollectionViewController *combinationViewController = segue.sourceViewController;
	PKOClothingCombination *clothingCombinationToDelete = combinationViewController.clothingCombination;

	[self.user.clothingCombinationStore removeClothingCombination:clothingCombinationToDelete];
	
	[self setClothingCombinationsDataSource:self.clothingCombinationsDataSource];
	[self.collectionView reloadData];
}

@end
















