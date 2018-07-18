//
//  PKOCSVHandler.h
//  ClothesProbabilities
//
//  Created by Pavol Kominak on 14/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface PKOCSVHandler : NSObject <CHCSVParserDelegate>

- (NSArray *)loadFromCSV:(NSURL *)csvURL;
- (void)saveRows:(NSArray *)rows toCSV:(NSURL *)csvURL;

@end
