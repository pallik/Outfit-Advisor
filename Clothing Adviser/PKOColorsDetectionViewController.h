//
//  PKOColorsDetectionViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 11/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingItem;

@interface PKOColorsDetectionViewController : UIViewController

@property (strong, nonatomic) PKOClothingItem *clothingItem;
@property (strong, nonatomic) UIImage *processedClothingImage;

@end
