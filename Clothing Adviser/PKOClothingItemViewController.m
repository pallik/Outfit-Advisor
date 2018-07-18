//
//  PKOClothingItemViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItemViewController.h"
#import "PKOClothingCategorySelectionTableViewController.h"
#import "PKOBodyPartSelectionTableViewController.h"

#import "PKOClothingItem.h"
#import "PKOUser.h"

#import "PKOClothingImageStore.h"
#import "PKOClothingItem+PKOClothingCategoryContainers.h"

#import "PKOColorsContainerView.h"
#import "UIImage+PKOClothingImage.h"

static NSString *const PKODeleteClothingItemSegueIdentifier = @"DeleteClothingItemSegueIdentifier";
static NSString *const PKOClothingCategorySelectionSegueIdentifier = @"ClothingCategorySelectionSegueIdentifier";
static NSString *const PKOBodyPartSelectionSegueIdentifier = @"BodyPartSelectionSegueIdentifier";

@interface PKOClothingItemViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet PKOColorsContainerView *colorsContainerView;
@property (weak, nonatomic) IBOutlet UIButton *bodyPartButton;
@property (weak, nonatomic) IBOutlet UIButton *clothingCategoryButton;

@property (copy, nonatomic) NSString *clothingCategoryContainerKey;

@end

@implementation PKOClothingItemViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if (self.clothingItem) {
		
		UIImage *clothingImage = [self.user.clothingImageStore imageForKey:self.clothingItem.clothingItemKey];
		self.imageView.image = clothingImage;
		
		[self updateUI];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.colorsContainerView setupColorsContainerViewInteractive:NO];
}

#pragma mark - Update UI

- (void)updateUI
{
	self.colorsContainerView.colors = [self.clothingItem.dominantColors mutableCopy];
	
	self.clothingCategoryContainerKey = [PKOClothingItem clothingCategoryContainerForClothingCategory:self.clothingItem.clothingCategory];
	[self.bodyPartButton setTitle:self.clothingCategoryContainerKey forState:UIControlStateNormal];
	
	NSString *clothingCategoryString = NSStringFromPKOClothingCategory(self.clothingItem.clothingCategory);
	[self.clothingCategoryButton setTitle:clothingCategoryString forState:UIControlStateNormal];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOBodyPartSelectionSegueIdentifier]) {
		
		PKOBodyPartSelectionTableViewController *bodyPartSelectionController = segue.destinationViewController;
		bodyPartSelectionController.addingNewClothingItem = NO;
		bodyPartSelectionController.clothingItem = self.clothingItem;
		
		bodyPartSelectionController.selectedClothingCategoryContainerIndex = [[PKOClothingItem clothingCategoryContainerKeys] indexOfObject:self.clothingCategoryContainerKey];
		
	} else if ([segue.identifier isEqualToString:PKOClothingCategorySelectionSegueIdentifier]) {
		
		PKOClothingCategorySelectionTableViewController *clothingCategorySelectionController = segue.destinationViewController;
		clothingCategorySelectionController.clothingItem = self.clothingItem;
		clothingCategorySelectionController.addingNewClothingItem = NO;
		
		NSArray *clothingCategories = [[PKOClothingItem clothingCategoryContainers] objectForKey:self.clothingCategoryContainerKey];
		clothingCategorySelectionController.clothingCategories = clothingCategories;
		clothingCategorySelectionController.selectedClothingCategoryIndex = [clothingCategories indexOfObject:@(self.clothingItem.clothingCategory)];
	}
}

#pragma mark - IBAction

- (IBAction)deleteClothingItem:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:@"Delete"
													otherButtonTitles:nil];
	[actionSheet showInView:self.view];
}

- (IBAction)editClothingItemUnwindToClothingItemViewController:(UIStoryboardSegue *)segue
{
	[self updateUI];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.destructiveButtonIndex) {
		[self performSegueWithIdentifier:PKODeleteClothingItemSegueIdentifier sender:nil];
	}
}

@end





