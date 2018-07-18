//
//  PKOUserStore.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 15/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOUserStore.h"
#import "PKOUser.h"

@interface PKOUserStore ()

@property (strong, nonatomic) NSMutableArray *privateAllUsers;

@end


@implementation PKOUserStore

#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		NSString *path = [self archivePath];
//		NSString *path = [[NSBundle mainBundle] pathForResource:@"users_full" ofType:@"archive"];
		_privateAllUsers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
		
		// If the array hadn't been saved previously, create a new empty one
		if (!_privateAllUsers) {
			_privateAllUsers = [[NSMutableArray alloc] init];
		}
	}
	return self;
}

#pragma mark - Users handling

- (NSArray *)allUsers
{
	return [self.privateAllUsers copy];
}

- (PKOUser *)createUserWithName:(NSString *)userName withGenderType:(PKOGenderType)genderType
{
	PKOUser *newUser = [[PKOUser alloc] initWithUserName:userName withGenderType:genderType];
	
	[self.privateAllUsers addObject:newUser];
	
	return newUser;
}

#pragma mark - Archiving

- (BOOL)saveUsers
{
	NSString *path = [self archivePath];
//	NSString *path = @"/Users/palli/Downloads/users_full.archive";
	return [NSKeyedArchiver archiveRootObject:self.privateAllUsers toFile:path];
}

- (NSString *)archivePath
{
	// Make sure that the first argument is NSDocumentDirectory
	// and not NSDocumentationDirectory
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// Get the one document directory from that list
	NSString *documentDirectory = [documentDirectories firstObject];
	
	return [documentDirectory stringByAppendingPathComponent:@"users.archive"];
}

@end













