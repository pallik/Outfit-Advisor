//
//  PKOClothingCombinationCollectionViewController.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 19/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingCombination;
@class PKOUser;

@interface PKOClothingCombinationCollectionViewController : UICollectionViewController

@property (assign, nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) PKOUser *user;
@property (strong, nonatomic) PKOClothingCombination *clothingCombination;

@end
