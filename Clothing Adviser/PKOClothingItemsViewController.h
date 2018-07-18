//
//  PKOClothingItemsViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 08/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOUser;

@interface PKOClothingItemsViewController : UICollectionViewController

@property (strong, nonatomic) PKOUser *user;

@end
