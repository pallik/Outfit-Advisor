//
//  PKOClothingImageStore.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 26/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingImageStore.h"
#import <UIKit/UIKit.h>

@interface PKOClothingImageStore ()

@property (strong, nonatomic) NSMutableDictionary *clothingImagesDictionary;

@end


@implementation PKOClothingImageStore

#pragma mark - Lifecycle

- (instancetype)init
{
	if (self = [super init]) {
		_clothingImagesDictionary = [[NSMutableDictionary alloc] init];
		
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc addObserver:self
			   selector:@selector(clearCache:)
				   name:UIApplicationDidReceiveMemoryWarningNotification
				 object:nil];
	}
	
	return self;
}

- (void)dealloc
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		_clothingImagesDictionary = [coder decodeObjectForKey:@"clothingImagesDictionary"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.clothingImagesDictionary forKey:@"clothingImagesDictionary"];
}

#pragma mark - Clearing Cache

- (void)clearCache:(NSNotification *)note
{
//	NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
	[self.clothingImagesDictionary removeAllObjects];
}

#pragma mark - Image handling

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
	//TODO: maybe delete image file already assigned to this key
	self.clothingImagesDictionary[key] = image;
	
	NSString *imagePath = [self imagePathForKey:key];
	NSData *imageData = UIImagePNGRepresentation(image);
	
	[imageData writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
	UIImage *image = self.clothingImagesDictionary[key];
	
	if (!image) {
		NSString *imagePath = [self imagePathForKey:key];
		
		// Create UIImage object from file
		image = [UIImage imageWithContentsOfFile:imagePath];
		
		// If we found an image on the file system, place it into the cache
		if (image) {
			self.clothingImagesDictionary[key] = image;
		} else {
			NSLog(@"Error: unable to find %@", imagePath);
		}
	}
	return image;
}

- (void)deleteImageForKey:(NSString *)key
{
	if (!key) {
		return;
	}
	[self.clothingImagesDictionary removeObjectForKey:key];

	NSString *imagePath = [self imagePathForKey:key];
	NSError *error;
	[[NSFileManager defaultManager] removeItemAtPath:imagePath
											   error:&error];
	if (error) {
		NSLog(@"Error deleting image: %@", error.localizedDescription);
	}
}

#pragma mark - Image path for key

- (NSString *)imagePathForKey:(NSString *)key
{
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [documentDirectories firstObject];
	
	return [documentDirectory stringByAppendingPathComponent:key];
}

@end





















