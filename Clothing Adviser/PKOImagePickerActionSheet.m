//
//  PKOImagePicker.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 09/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOImagePickerActionSheet.h"

static NSString *const PKOActionSheetCameraButtonTitle = @"Camera";
static NSString *const PKOActionSheetPhotoLibraryButtonTitle = @"Photo library";
static NSString *const PKOActionSheetCancelButtonTitle = @"Cancel";

@interface PKOImagePickerActionSheet ()

@property (weak, nonatomic) UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> *viewController;

@end


@implementation PKOImagePickerActionSheet

#pragma mark - Lifecycle

- (instancetype)initWithViewController:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> *)viewController
{
	if (self = [super init])
	{
		_viewController = viewController;
	}
	
	return self;
}

#pragma mark - Showing UIActionSheet

- (void)showImagePickerActionSheetWithTitle:(NSString *)title
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
															 delegate:self
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[actionSheet addButtonWithTitle:PKOActionSheetCameraButtonTitle];
	}
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[actionSheet addButtonWithTitle:PKOActionSheetPhotoLibraryButtonTitle];
	}
	[actionSheet addButtonWithTitle:PKOActionSheetCancelButtonTitle];
	actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
	
	[actionSheet showInView:self.viewController.view];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.cancelButtonIndex) {
		return;
	}
	
	NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	UIImagePickerControllerSourceType sourceType;
	
	if ([buttonTitle isEqualToString:PKOActionSheetCameraButtonTitle]) {
		sourceType = UIImagePickerControllerSourceTypeCamera;
	} else if ([buttonTitle isEqualToString:PKOActionSheetPhotoLibraryButtonTitle]) {
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	} else {
		return;
	}
	
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
		return;
	}
	
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self.viewController;
	imagePicker.allowsEditing = YES;
	
	[self.viewController presentViewController:imagePicker animated:YES completion:nil];
}

@end








