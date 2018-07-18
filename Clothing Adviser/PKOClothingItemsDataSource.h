//
//  PKOClothingItemsDataSource.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 08/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKOClothingItemStore;
@class PKOClothingItem;

@interface PKOClothingItemsDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore cellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier NS_DESIGNATED_INITIALIZER;

- (PKOClothingItem *)clothingItemAtIndexPath:(NSIndexPath *)indexPath;

@end
