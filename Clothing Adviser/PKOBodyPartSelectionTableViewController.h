//
//  PKOBodyPartSelectionTableViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 14/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingItem;

@interface PKOBodyPartSelectionTableViewController : UITableViewController

@property (strong, nonatomic) PKOClothingItem *clothingItem;
@property (strong, nonatomic) UIImage *processedClothingImage;
@property (assign, nonatomic) BOOL addingNewClothingItem;
@property (assign, nonatomic) NSUInteger selectedClothingCategoryContainerIndex;

@end
