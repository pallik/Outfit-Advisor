//
//  PKOBackgroundRemoving.h
//  backgroundRemoving
//
//  Created by Pavol Kominak on 15/01/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif

UIImage* removeBackgroundFromImage(UIImage *inputImage, float sigma, float k, int min_size, NSString *filename);
UIImage* resizeImageToNewSize(UIImage *originalImage, CGSize newSize);


#ifdef __cplusplus
}
#endif