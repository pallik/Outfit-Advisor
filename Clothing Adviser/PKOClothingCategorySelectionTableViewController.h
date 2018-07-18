//
//  PKOClothingCategorySelectionTableViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingItem;

@interface PKOClothingCategorySelectionTableViewController : UITableViewController

@property (strong, nonatomic) PKOClothingItem *clothingItem;
@property (strong, nonatomic) UIImage *processedClothingImage;
@property (copy, nonatomic) NSArray *clothingCategories;
@property (assign, nonatomic) BOOL addingNewClothingItem;
@property (assign, nonatomic) NSUInteger selectedClothingCategoryIndex;

@end
