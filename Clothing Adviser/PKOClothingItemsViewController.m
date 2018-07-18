//
//  PKOClothingItemsViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 08/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItemsViewController.h"
#import "PKOClothingItemsDataSource.h"

#import "PKOUser.h"
#import "PKOClothingItem.h"
#import "PKOClothingItemStore.h"

#import "PKOBackgroundRemovingViewController.h"
#import "PKOClothingCategorySelectionTableViewController.h"
#import "PKOClothingItemViewController.h"
#import "PKOImagePickerActionSheet.h"

#import "PKOClothingItemCollectionViewCell.h"
#import "PKOClothingItemsHeaderView.h"

static NSString *const PKOBackgroundRemovingSegueIdentifier = @"BackgroundRemovingSegueIdenfifier";
static NSString *const PKOCancelBackgroundRemovingSegueIdentifier = @"CancelBackgroundRemovingSegueIdentifier";
static NSString *const PKOClothingItemSegueIdentifier = @"ClothingItemSegueIdentifier";

@interface PKOClothingItemsViewController () <UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PKOClothingItemsDataSource *clothingItemsDataSource;
@property (strong, nonatomic) PKOImagePickerActionSheet *imagePickerActionSheet;
@property (strong, nonatomic) UIImage *pickedImage;

@end


@implementation PKOClothingItemsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.collectionView reloadData];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - Setup UICollectionView

- (void)setupCollectionView
{
	NSString *cellIdentifier = NSStringFromClass([PKOClothingItemCollectionViewCell class]);
	NSString *headerIdentifier = NSStringFromClass([PKOClothingItemsHeaderView class]);
	
	self.clothingItemsDataSource = [[PKOClothingItemsDataSource alloc] initWithClothingItemStore:self.user.clothingItemStore
																				 cellIdentifier:cellIdentifier
																			   headerIdentifier:headerIdentifier];
	self.collectionView.dataSource = self.clothingItemsDataSource;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize size = CGSizeMake(PKOThumbnailSizeWidth, PKOThumbnailSizeHeight);
	
	return size;
}

#pragma mark - IBAction

- (IBAction)addNewClothingItem:(id)sender
{
	if (!self.imagePickerActionSheet) {
		self.imagePickerActionSheet = [[PKOImagePickerActionSheet alloc] initWithViewController:self];
	}
	
	[self.imagePickerActionSheet showImagePickerActionSheetWithTitle:@"Add new clothes from:"];
}


#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	self.pickedImage = info[UIImagePickerControllerEditedImage];
//	self.pickedImage = info[UIImagePickerControllerOriginalImage];
	
	[self dismissViewControllerAnimated:YES completion:^{
		[self performSegueWithIdentifier:PKOBackgroundRemovingSegueIdentifier sender:nil];
	}];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOBackgroundRemovingSegueIdentifier]) {
		
		UINavigationController *navigationController = segue.destinationViewController;
		PKOBackgroundRemovingViewController *backgroundRemovingController = navigationController.viewControllers.firstObject;
		
		backgroundRemovingController.clothingImage = self.pickedImage;
		
		PKOClothingItem *newClothingItem = [[PKOClothingItem alloc] init];
		newClothingItem.genderType = self.user.genderType;
		backgroundRemovingController.clothingItem = newClothingItem;
		
	} else if ([segue.identifier isEqualToString:PKOClothingItemSegueIdentifier]) {
		
		PKOClothingItemCollectionViewCell *cell = sender;
		NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
		PKOClothingItem *selectedClothingItem = [self.clothingItemsDataSource clothingItemAtIndexPath:indexPath];
		
		PKOClothingItemViewController *clothingItemController = segue.destinationViewController;
		clothingItemController.clothingItem = selectedClothingItem;
		clothingItemController.user = self.user;
	}
}

- (IBAction)cancelToClothingItemsViewController:(UIStoryboardSegue *)segue {
}

- (IBAction)saveNewClothingItemUnwindToClothingItemsViewController:(UIStoryboardSegue *)segue
{
	PKOClothingCategorySelectionTableViewController *clothingCategorySelectionController = segue.sourceViewController;
	
	PKOClothingItem *newClothingItem = clothingCategorySelectionController.clothingItem;
	UIImage *processedClothingImage = clothingCategorySelectionController.processedClothingImage;
	[self.user saveNewClothingItem:newClothingItem withProcessedImage:processedClothingImage];
	
	[self.collectionView reloadData];
};

- (IBAction)deleteClothingItemUnwindToClothingItemsViewController:(UIStoryboardSegue *)segue
{
	PKOClothingItemViewController *clothingItemController = segue.sourceViewController;
	PKOClothingItem *clothingItemToDelete = clothingItemController.clothingItem;
	
	[self.user deleteClothingItem:clothingItemToDelete];
	
	[self.collectionView reloadData];
}

@end













