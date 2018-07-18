//
//  PKOBodyPartSelectionTableViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 14/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOBodyPartSelectionTableViewController.h"
#import "PKOClothingConstants.h"
#import "PKOClothingCategorySelectionTableViewController.h"
#import "PKOClothingItem+PKOClothingCategoryContainers.h"

static NSString *const PKOClothingCategorySelectionSegueIdentifier = @"ClothingCategorySelectionSegueIdentifier";
static NSString *const PKOClothingCategoryContainerTableViewCellIdentifier = @"PKOClothingCategoryContainerTableViewCell";


@interface PKOBodyPartSelectionTableViewController ()

@property (copy, nonatomic) NSArray *clothingCategoryContainerLabels;

@end


@implementation PKOBodyPartSelectionTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.clearsSelectionOnViewWillAppear = NO;
    
	self.clothingCategoryContainerLabels = [PKOClothingItem clothingCategoryContainerKeys];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOClothingCategorySelectionSegueIdentifier]) {
		
		PKOClothingCategorySelectionTableViewController *clothingCategorySelectionController = segue.destinationViewController;
		clothingCategorySelectionController.clothingItem = self.clothingItem;
		clothingCategorySelectionController.processedClothingImage = self.processedClothingImage;
		clothingCategorySelectionController.addingNewClothingItem = self.addingNewClothingItem;
		
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
		NSString *selectedClothingCategoryContainer = self.clothingCategoryContainerLabels[indexPath.row];
		NSArray *clothingCategories = [[PKOClothingItem clothingCategoryContainers] objectForKey:selectedClothingCategoryContainer];
		
		clothingCategorySelectionController.clothingCategories = clothingCategories;
	}
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSUInteger count = [PKOClothingItem clothingCategoryContainers].count;
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PKOClothingCategoryContainerTableViewCellIdentifier forIndexPath:indexPath];
	
    cell.textLabel.text = self.clothingCategoryContainerLabels[indexPath.row];
	
	if (indexPath.row == self.selectedClothingCategoryContainerIndex) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selectedClothingCategoryContainerIndex inSection:0];
	UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:oldIndexPath];
	oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
	
	self.selectedClothingCategoryContainerIndex = indexPath.row;
	
	UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
	currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

@end









