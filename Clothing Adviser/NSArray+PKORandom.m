//
//  NSArray+PKORandom.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "NSArray+PKORandom.h"

@implementation NSArray (PKORandom)

- (id)pko_randomObject
{
	if (self.count == 0) {
		return nil;
	}
	
	return self[arc4random_uniform((uint32_t)self.count)];
}

- (NSArray *)pko_shuffle
{
	NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
	NSUInteger count = mutableArray.count;
	
	if (count > 1) {
		for (NSUInteger i = count - 1; i > 0; --i) {
			[mutableArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((uint32_t)(i+1))];
		}
	}
	
	return [mutableArray copy];
}

@end
