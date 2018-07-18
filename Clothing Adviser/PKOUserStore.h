//
//  PKOUserStore.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOUser;

@interface PKOUserStore : NSObject

- (NSArray *)allUsers;
- (PKOUser *)createUserWithName:(NSString *)userName withGenderType:(PKOGenderType)genderType;
//- (void)removeUser:(PKOUser *)user;
- (BOOL)saveUsers;

@end
