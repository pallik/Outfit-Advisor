//
//  UIImage+PKOClothingImage.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PKOClothingImage)

+ (UIImage *)pko_imageFromLayer:(CALayer *)layer;
- (UIImage *)pko_roundedImageWithRadius:(CGFloat)radius withBorderWidth:(CGFloat)borderWidth;
- (UIImage *)pko_roundedImageWithBlackToTransparentBackground;
- (NSArray *)pko_extractDominantColorsWithBlackBackground;
- (UIImage *)pko_imageBlackToTransparentBackground;


@end
