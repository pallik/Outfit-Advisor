//
//  PKODebugging.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 20/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

static inline void PKOLogRect(CGRect rect)
{
	NSLog(@"x: %f, y: %f, width: %f, height: %f", CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
}