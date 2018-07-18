//
//  PKOGeneratingClothingCombinationsViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 17/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKOClothingConstants.h"

@class PKOUser;
@class PKOClothingCombination;

@interface PKOGeneratingClothingCombinationsViewController : UIViewController

@property (assign, nonatomic) PKODressCode dressCode;
@property (strong, nonatomic) PKOUser *user;
@property (strong, nonatomic) PKOClothingCombination *selectedClothingCombination;

@end
