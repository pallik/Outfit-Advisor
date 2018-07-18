//
//  PKOBackgroundRemovingViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 10/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingItem;

@interface PKOBackgroundRemovingViewController : UIViewController

@property (strong, nonatomic) PKOClothingItem *clothingItem;
@property (strong, nonatomic) UIImage *clothingImage;

@end
