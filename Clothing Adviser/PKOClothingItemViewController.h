//
//  PKOClothingItemViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOUser;
@class PKOClothingItem;

@interface PKOClothingItemViewController : UIViewController

@property (strong, nonatomic) PKOUser *user;
@property (strong, nonatomic) PKOClothingItem *clothingItem;

@end
