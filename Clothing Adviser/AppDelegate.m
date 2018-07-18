//
//  AppDelegate.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 23/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "AppDelegate.h"

#import "PKOClothingItemsViewController.h"
#import "PKOClothingCombinationsCollectionViewController.h"
#import "PKOUserStore.h"
#import "PKOUser.h"

#import "PKOClothingItem.h"
#import "UIImage+PKOClothingImage.h"
#import "UIColor+PKODefaultTint.h"
#import "PKOClothingItemStore.h"
#import "PKOClothingCombinationStore.h"
#import "PKOClothingCombination.h"


@interface AppDelegate ()

@property (strong, nonatomic) PKOUserStore *userStore;

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setupDefaultAppearance];
	
	if (!self.userStore) {
		self.userStore = [[PKOUserStore alloc] init];
	}
	
	//TODO: get real user, load or create new
	PKOUser *firstUser = [self.userStore allUsers].firstObject;
	if (!firstUser) {
		firstUser = [self.userStore createUserWithName:@"Palli" withGenderType:PKOGenderTypeMale];
	}

	//add some test clothing combinations
//	if ([firstUser.clothingCombinationStore clothingCombinations].count == 0) {
//		[self setFewClothingCombinationsForUser:firstUser];
//	}
	
	UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
	
	UINavigationController *clothingCombinationsNavigationController = [tabBarController viewControllers].firstObject;
	PKOClothingCombinationsCollectionViewController *clothingCombinationsViewController = [clothingCombinationsNavigationController viewControllers].firstObject;
	clothingCombinationsViewController.user = firstUser;
	
	UINavigationController *clothingItemsNavigationController = [tabBarController viewControllers].lastObject;
	PKOClothingItemsViewController *clothingItemsViewController = [clothingItemsNavigationController viewControllers].firstObject;
	clothingItemsViewController.user = firstUser;
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		BOOL success = [self.userStore saveUsers];
		if (success) {
			NSLog(@"Saved all users");
		} else {
			NSLog(@"Could not save any of the PKOUsers");
		}
//	});
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	NSLog(@"App did receive memory warning");
}

#pragma mark - Default Appearance

- (void)setupDefaultAppearance
{
	self.window.tintColor = [UIColor customDefaultTintColor];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[UIApplication sharedApplication].statusBarHidden = NO;
	
	UINavigationBar *navigationBar = [UINavigationBar appearance];
	navigationBar.tintColor = [UIColor whiteColor];
	navigationBar.barTintColor = [UIColor customDefaultTintColor];
	navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

#pragma mark - Testing data

- (void)setFewClothingCombinationsForUser:(PKOUser *)user
{
	for (NSUInteger i = 0; i < 10;  ++i) {
		PKOClothingCombination *randomCombination = [PKOClothingCombination randomClothingCombinationWithClothingItemStore:user.clothingItemStore
																												withGender:user.genderType
																											 withDressCode:PKODressCodeCasual];
		[user.clothingCombinationStore addClothingCombination:randomCombination];
	}
}


@end








