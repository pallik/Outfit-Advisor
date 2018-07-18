//
//  PKOImagePicker.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 09/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PKOImagePickerActionSheet : NSObject <UIActionSheetDelegate>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> *)viewController NS_DESIGNATED_INITIALIZER;

- (void)showImagePickerActionSheetWithTitle:(NSString *)title;

@end
