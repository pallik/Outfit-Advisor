//
//  NSArray+PKORandom.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PKORandom)

- (id)pko_randomObject;
- (NSArray *)pko_shuffle;

@end
