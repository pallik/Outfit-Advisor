//
//  PKOBackgroundRemovingViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 10/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOBackgroundRemovingViewController.h"
#import "PKOColorsDetectionViewController.h"
#import "PKOClothingItem.h"
#import "PKOBackgroundRemoving.h"
#import "UIImage+ResizeMagick.h"
#import "UIImage+PKOClothingImage.h"

//static CGFloat const PKOBackgroundRemovingDefaultSigma = 1.0;
static CGFloat const PKOBackgroundRemovingDefaultSigma = 0.5;
//static CGFloat const PKOBackgroundRemovingDefaultKconstant = 500;
static CGFloat const PKOBackgroundRemovingDefaultKconstant = 300;
//static CGFloat const PKOBackgroundRemovingDefaultMinSize = 100;
static CGFloat const PKOBackgroundRemovingDefaultMinSize = 20;
//static NSUInteger const PKOClothingImageSmallerDimension = 600;
static NSString *const PKOColorsDetectionSegueIdentifier = @"ColorsDetectionSegueIdentifier";

@interface PKOBackgroundRemovingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIStepper *kConstantStepper;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@property (strong, nonatomic) UIImage *processedClothingImage;
@property (assign, nonatomic) CGFloat sigma;
@property (assign, nonatomic) CGFloat kConstant;

@end


@implementation PKOBackgroundRemovingViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//	self.sigma = self.stepper.value / 2.0;
	self.sigma = PKOBackgroundRemovingDefaultSigma;
//	self.stepper.value = self.sigma * 2.0;
	
	self.kConstant = PKOBackgroundRemovingDefaultKconstant;
	self.kConstantStepper.value = self.kConstant;

	if (self.clothingImage) {
		self.imageView.image = self.clothingImage;
		
		[self removeBackgroundFromImage];
	}
}

#pragma mark - Accesors

- (void)setClothingImage:(UIImage *)clothingImage
{
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat smallerScreenDimension = MIN(screenSize.width, screenSize.height);
	
	CGFloat smallerImageDimension = MIN(clothingImage.size.width, clothingImage.size.height);
	if (smallerImageDimension > smallerScreenDimension) {
		
		//check for rotation
		if (clothingImage.size.height > clothingImage.size.width) {
			//is portrait, resize width by PKOClothingImageSmallerDimension
			_clothingImage = [clothingImage resizedImageByWidth:smallerScreenDimension];
			return;
		} else {
			//is landscape or square, resize height by PKOClothingImageSmallerDimension
			_clothingImage = [clothingImage resizedImageByHeight:smallerScreenDimension];
			return;
		}
	}
	
	_clothingImage = clothingImage;
}

#pragma mark - IBAction

- (IBAction)kConstantStepperValueDidChange:(id)sender
{
	UIStepper *stepper = (UIStepper *)sender;
	self.kConstant = stepper.value;
	
	[self removeBackgroundFromImage];
}

#pragma mark - Background removing

- (void)removeBackgroundFromImage
{
	if (!self.clothingImage) {
		return;
	}

	[self startAsynchronousProcess];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

		self.processedClothingImage = removeBackgroundFromImage(self.clothingImage, self.sigma, self.kConstant, PKOBackgroundRemovingDefaultMinSize, nil);
		
		if (!self.isViewLoaded || !self.view.window) {
			NSLog(@"Background removing: Trying to set image but view is not loaded");
			return;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			self.imageView.image = self.processedClothingImage;
			[self stopAsynchronousProcess];
		});
	});
	
}

#pragma mark - Asynchronous process

- (void)startAsynchronousProcess
{
	[self.activityIndicator startAnimating];
	self.kConstantStepper.enabled = NO;
	self.doneBarButtonItem.enabled = NO;

	[UIView animateWithDuration:0.3 animations:^{
		self.imageView.alpha = 0.6;
	}];
}

- (void)stopAsynchronousProcess
{
	[self.activityIndicator stopAnimating];
	
	[UIView animateWithDuration:0.3 animations:^{
		self.imageView.alpha = 1.0;
	} completion:^(BOOL finished){
//		[self.activityIndicator stopAnimating];
		self.kConstantStepper.enabled = YES;
		self.doneBarButtonItem.enabled = YES;
	}];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	//	NSLog(@"prepare for segue: %@ destination: %@", segue.identifier, segue.destinationViewController);
	
	if ([segue.identifier isEqualToString:PKOColorsDetectionSegueIdentifier]) {
		
		PKOColorsDetectionViewController *colorsDetectionController = segue.destinationViewController;
		colorsDetectionController.clothingItem = self.clothingItem;
		colorsDetectionController.processedClothingImage = self.processedClothingImage;
		
		//set final processed image as item's thumnbail
		[self.clothingItem setThumbnailFromImage:self.processedClothingImage];
	}
}

@end











