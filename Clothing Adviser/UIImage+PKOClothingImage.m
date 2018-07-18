//
//  UIImage+PKOClothingImage.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "UIImage+PKOClothingImage.h"
#import "CCColorCube.h"

static CGFloat const PKOClothingImageRadius = 20.0;
static CGFloat const PKOClothingImageBorderWidth = 2.0;

@implementation UIImage (PKOClothingImage)

+ (UIImage *)pko_imageFromLayer:(CALayer *)layer
{
	UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0.0);
	
	[layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return outputImage;
}

#pragma mark - Rounded images

- (UIImage *)pko_roundedImageWithRadius:(CGFloat)radius withBorderWidth:(CGFloat)borderWidth
{
	CGRect rect = CGRectZero;
	rect.size = self.size;
	
	CALayer *imageLayer = [CALayer layer];
	imageLayer.frame = rect;
	imageLayer.contents = (__bridge id)(self.CGImage);
	imageLayer.masksToBounds = YES;
	imageLayer.cornerRadius = radius;
	imageLayer.borderWidth = borderWidth;
	imageLayer.borderColor = [UIColor darkGrayColor].CGColor;
	
	UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
	
	[imageLayer renderInContext:UIGraphicsGetCurrentContext()];
	
	UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return roundedImage;
}

- (UIImage *)pko_roundedImageWithBlackToTransparentBackground
{
	UIImage *imageWithTransparentBackground = [self pko_imageBlackToTransparentBackground];
	UIImage *roundedImage = [imageWithTransparentBackground pko_roundedImageWithRadius:PKOClothingImageRadius
																	   withBorderWidth:PKOClothingImageBorderWidth];
	
	return roundedImage;
}

#pragma mark - Extracting dominant colors

- (NSArray *)pko_extractDominantColorsWithBlackBackground
{
	CCColorCube *colorCube = [[CCColorCube alloc] init];
	return [colorCube extractDominantColorsWithBlackBackgroundFromImage:self];
}

#pragma mark - Removing black background

//- (unsigned char *)rawPixelWithPixelCount:(unsigned int*)pixelCount
- (UIImage *)pko_imageBlackToTransparentBackground
{
	// Get cg image and its size
	CGImageRef cgImage = self.CGImage;
	NSUInteger width = CGImageGetWidth(cgImage);
	NSUInteger height = CGImageGetHeight(cgImage);
	
	// Create the color space
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	// Allocate storage for the pixel data
//	unsigned char *rawData = (unsigned char *)malloc(height * width * 4);
	unsigned char *rawData = (unsigned char *)calloc(height * width * 4, sizeof(unsigned char));
	
	// If allocation failed, return NULL
	if (!rawData) return NULL;
	
	// Set some metrics
	NSUInteger bytesPerPixel = 4;
	NSUInteger bytesPerRow = bytesPerPixel * width;
//	NSUInteger bytesPerRow = CGImageGetBytesPerRow(cgImage);
//	NSUInteger bitsPerComponent = 8;
	NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	
	// Create context using the storage
	CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	// Release the color space
//	CGColorSpaceRelease(colorSpace);
	
	// Draw the image into the storage
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
	
	// We are done with the context
//	CGContextRelease(context);
	
	// Write pixel count to passed pointer
//	*pixelCount = (int)width * (int)height;
	
	// Return pixel data (needs to be freed)
//	return rawData;
	
	
	//////////////////// modifying data - removing black background for transparent //////////////
	
	unsigned int pixelCount = (int)width * (int)height;
	unsigned char r,g,b;
	unsigned char threshold = 5;
	
	for (unsigned int i = 0; i < pixelCount; ++i) {
		r = rawData[i*4+0];
		g = rawData[i*4+1];
		b = rawData[i*4+2];

		if (r <= threshold && g <= threshold && b <= threshold) {
			rawData[i*4 + 0] = 0;
			rawData[i*4 + 1] = 0;
			rawData[i*4 + 2] = 0;
			rawData[i*4 + 3] = 0;
		}
	}
	

//	context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	cgImage = CGBitmapContextCreateImage(context);
	UIImage *imageWithTransparentBackground = [UIImage imageWithCGImage:cgImage];
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(cgImage);
	free(rawData);
	
	return imageWithTransparentBackground;
}

@end







