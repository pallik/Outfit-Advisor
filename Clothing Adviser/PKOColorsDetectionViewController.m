//
//  PKOColorsDetectionViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 11/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOColorsDetectionViewController.h"
#import "PKOColorsContainerView.h"
#import "PKOBodyPartSelectionTableViewController.h"
#import "PKOClothingItem.h"

#import "UIImage+PKOClothingImage.h"
#import "UISlider+PKOGradientBackground.h"
#import "UIView+ColorOfPoint.h"

static NSString *const PKOBodyPartSelectionSegueIdentifier = @"BodyPartSelectionSegueIdentifier";

@interface PKOColorsDetectionViewController () <PKOColorsContainerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet PKOColorsContainerView *colorsContainerView;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UIButton *deleteColorButton;

@property (copy, nonatomic) NSArray *colors;
@property (assign, nonatomic) CGFloat currentHue;

@end

@implementation PKOColorsDetectionViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.colorsContainerView.delegate = self;
	
	if (self.processedClothingImage) {
		[self detectColors];
		self.colorsContainerView.colors = [self.colors mutableCopy];
		self.imageView.image = self.processedClothingImage;
//		self.imageView.image = [self.processedClothingImage pko_roundedImageWithBlackToTransparentBackground];
		
		[self setupImageViewAsEyeDropper];
		
		if (self.colors.count <= 1) {
			self.deleteColorButton.enabled = NO;
		}
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self.colorsContainerView setupColorsContainerViewInteractive:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOBodyPartSelectionSegueIdentifier]) {
		
		PKOBodyPartSelectionTableViewController *bodyPartSelectionController = segue.destinationViewController;
		bodyPartSelectionController.processedClothingImage = [self.processedClothingImage pko_roundedImageWithBlackToTransparentBackground];
		bodyPartSelectionController.addingNewClothingItem = YES;
		
		//set final detected/edited colors
		self.clothingItem.dominantColors = [self.colorsContainerView.colors copy];
		bodyPartSelectionController.clothingItem = self.clothingItem;
	}
}


#pragma mark - Colors detection

- (void)detectColors
{
	if (!self.processedClothingImage) {
		return;
	}
	
	self.colors = [self.processedClothingImage pko_extractDominantColorsWithBlackBackground];
}

#pragma mark - PKOColorsContainerViewDelegate

- (void)didSelectViewWithColor:(UIColor *)color
{
	[self adjustSlidersWithColor:color];
}

#pragma mark - UISlider handling

- (IBAction)saturationSliderValueDidChange:(id)sender
{
	[self slidersValuesDidChange];
	
	//changing saturation also changes self.brightnessSlider gradient
	[self.brightnessSlider pko_setGradientBackgroundForBrightnessWithColor:[self currentColor]];
}

- (IBAction)brightnessSliderValueDidChange:(id)sender
{
	[self slidersValuesDidChange];
}

- (void)slidersValuesDidChange
{
	UIColor *newColor = [self currentColor];
	[self.colorsContainerView changeSelectedColorToColor:newColor];
}

- (void)adjustSlidersWithColor:(UIColor *)color
{
	CGFloat hue, saturation, brightness, alpha;
	[color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	self.currentHue = hue;
	self.saturationSlider.value = saturation;
	self.brightnessSlider.value = brightness;
	
	[self.saturationSlider pko_setGradientBackgroundForSaturationWithColor:color];
	[self.brightnessSlider pko_setGradientBackgroundForBrightnessWithColor:color];
}

#pragma mark - Adding & Deleting colors

- (IBAction)addNewColor:(id)sender
{
	[self.colorsContainerView addNewColorView];
	self.deleteColorButton.enabled = YES;
}

- (IBAction)deleteSelectedColor:(id)sender
{
	[self.colorsContainerView deleteSelectedColorView];
	if (self.colorsContainerView.colors.count <= 1) {
		self.deleteColorButton.enabled = NO;
	}
}

//possibly refactor this feature to UIView
#pragma mark - Eyedropper image view

- (void)setupImageViewAsEyeDropper
{
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
																					action:@selector(didTouchWithRecognizer:)];
	panRecognizer.minimumNumberOfTouches = 1;
	panRecognizer.maximumNumberOfTouches = 1;
	[self.imageView addGestureRecognizer:panRecognizer];
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																					action:@selector(didTouchWithRecognizer:)];
	[self.imageView addGestureRecognizer:tapRecognizer];
	
	self.imageView.userInteractionEnabled = YES;
}

- (void)didTouchWithRecognizer:(UIGestureRecognizer *)recognizer
{
	CGPoint point = [recognizer locationInView:recognizer.view];

	UIColor *colorAtPoint = [recognizer.view colorAtPoint:point];
	[self.colorsContainerView changeSelectedColorToColor:colorAtPoint];
	
	[self adjustSlidersWithColor:colorAtPoint];
}

#pragma mark - Current color

- (UIColor *)currentColor
{
	return [UIColor colorWithHue:self.currentHue
					  saturation:self.saturationSlider.value
					  brightness:self.brightnessSlider.value
						   alpha:1.0];
}


@end













