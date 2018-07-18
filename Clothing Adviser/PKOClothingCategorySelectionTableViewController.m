//
//  PKOClothingCategorySelectionTableViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCategorySelectionTableViewController.h"
#import "PKOClothingConstants.h"
#import "PKOClothingItem.h"

static NSString *PKOSaveNewClothingItemSegueIdentifier = @"SaveNewClothingItemSegueIdentifier";
static NSString *PKOEditClothingItemSegueIdentifier = @"EditClothingItemSegueIdentifier";
static NSString *PKOClothingCategoryTableViewCellIdentifier = @"PKOClothingCategoryTableViewCell";


@interface PKOClothingCategorySelectionTableViewController ()

@end


@implementation PKOClothingCategorySelectionTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	PKOClothingCategory clothingCategory = [(NSNumber *)self.clothingCategories[self.selectedClothingCategoryIndex] unsignedIntegerValue];
	self.clothingItem.clothingCategory = clothingCategory;
	self.clothingItem.bodyPart = PKOBodyPartFromPKOClothingCategory(clothingCategory);
	
	if ([segue.identifier isEqualToString:PKOSaveNewClothingItemSegueIdentifier]) {
		//unwind to saveNewClothingItem
	} else if ([segue.identifier isEqualToString:PKOEditClothingItemSegueIdentifier]) {
		//unwind to editClothingItem
	}
}

#pragma mark - IBAction

- (IBAction)saveClothingItem:(id)sender
{
	if (self.addingNewClothingItem) {
		[self performSegueWithIdentifier:PKOSaveNewClothingItemSegueIdentifier sender:self];
	} else {
		//is editing
		[self performSegueWithIdentifier:PKOEditClothingItemSegueIdentifier sender:self];
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clothingCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PKOClothingCategoryTableViewCellIdentifier forIndexPath:indexPath];
    
	PKOClothingCategory clothingCategory = [(NSNumber *)self.clothingCategories[indexPath.row] unsignedIntegerValue];
	cell.textLabel.text = NSStringFromPKOClothingCategory(clothingCategory);
	
	if (indexPath.row == self.selectedClothingCategoryIndex) {
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
	
	NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selectedClothingCategoryIndex inSection:0];
	UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:oldIndexPath];
	oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
	
	self.selectedClothingCategoryIndex = indexPath.row;
	
	UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
	currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

@end






