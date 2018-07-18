//
//  PKOClothingCombinationCollectionViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 19/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombinationCollectionViewController.h"
#import "PKOClothingCombinationsDataSource.h"

#import "PKOClothingItemCollectionViewCell.h"

#import "PKOClothingItem.h"
#import "PKOUser.h"
#import "PKOClothingCombination.h"
#import "PKOClothingImageStore.h"


static NSString *const PKODeleteClothingCombinationSegueIdentifier = @"DeleteClothingCombinationSegueIdentifier";
static NSUInteger const PKOClothingItemImageSizeConstant = 2;


@interface PKOClothingCombinationCollectionViewController () <UICollectionViewDelegateFlowLayout, UIActionSheetDelegate>

@property (strong, nonatomic) PKOClothingCombinationsDataSource *clothingCombinationsDataSource;

@end


@implementation PKOClothingCombinationCollectionViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self setupCollectionView];
}

#pragma mark - Setup UICollectionView

- (void)setupCollectionView
{
	PKOClothingCombinationCollectionViewController * __weak weakSelf = self;
	
	void (^configureCell)(PKOClothingItemCollectionViewCell *, PKOClothingItem *) = ^(PKOClothingItemCollectionViewCell* cell, PKOClothingItem *clothingItem) {
		cell.backgroundColor = [UIColor clearColor];
		cell.imageView.image = [weakSelf.user.clothingImageStore imageForKey:clothingItem.clothingItemKey];
	};
	
	self.clothingCombinationsDataSource = [[PKOClothingCombinationsDataSource alloc] init];
	self.clothingCombinationsDataSource.configureCellBlock = configureCell;
	self.clothingCombinationsDataSource.clothingCombinations = @[self.clothingCombination];
	
	self.collectionView.dataSource = self.clothingCombinationsDataSource;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize size = CGSizeMake(PKOThumbnailSizeWidth * PKOClothingItemImageSizeConstant,
							 PKOThumbnailSizeHeight * PKOClothingItemImageSizeConstant);
	
	return size;
}

#pragma mark - IBAction

- (IBAction)deleteClothingCombination:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:@"Delete"
													otherButtonTitles:nil];
	[actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.destructiveButtonIndex) {
		[self performSegueWithIdentifier:PKODeleteClothingCombinationSegueIdentifier sender:nil];
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/


@end
