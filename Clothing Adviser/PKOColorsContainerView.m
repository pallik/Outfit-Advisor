//
//  PKOColorsContainerView.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 13/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOColorsContainerView.h"
#import "PKOColorView.h"

@interface PKOColorsContainerView ()

@property (strong, nonatomic) PKOColorView *selectedColorView;

@end


@implementation PKOColorsContainerView

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self)
	{
		self.layer.cornerRadius = 10.0;
		self.layer.borderWidth = 2.0;
		self.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.clipsToBounds = YES;
	}
	return self;
}

#pragma mark - Setting up colors container view

- (void)setupColorsContainerViewInteractive:(BOOL)interactive
{
	if (interactive) {
		self.clipsToBounds = NO;
		self.layer.borderWidth = 0.0;
	}
	
	//remove all subviews
	self.selectedColorView = nil;
	[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	NSUInteger numberOfColors = self.colors.count;
	
	if (!numberOfColors) {
		return;
	}
	
	CGFloat colorViewWidth = CGRectGetWidth(self.frame) / numberOfColors;
	CGFloat colorViewHeight = CGRectGetHeight(self.frame);
	CGRect colorViewFrame = CGRectMake(0, 0, colorViewWidth, colorViewHeight);
	
	for (NSUInteger i = 0; i < numberOfColors; ++i) {
		UIColor *color = self.colors[i];
		
		colorViewFrame.origin.x = colorViewWidth * i;
		PKOColorView *colorView = [[PKOColorView alloc] initWithFrame:colorViewFrame];
		colorView.backgroundColor = color;
		
		if (interactive) {
			[self addTapGestureToView:colorView];
		}
		
		[self addSubview:colorView];
	}
	
	PKOColorView *lastColorView = self.subviews.lastObject;
	if (interactive && lastColorView) {
		[self handleSelectingColorView:lastColorView];
	}
}

- (void)addTapGestureToView:(PKOColorView *)colorView
{
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																				action:@selector(handleSelectingColorViewsWithTapRecognizer:)];
	[colorView addGestureRecognizer:tapRecognizer];
}

#pragma mark - UITapGestureRecognizer

- (void)handleSelectingColorViewsWithTapRecognizer:(UITapGestureRecognizer *)recognizer
{
	PKOColorView *tappedView = (PKOColorView *)recognizer.view;
	[self handleSelectingColorView:tappedView];
}

- (void)handleSelectingColorView:(PKOColorView *)newSelectedColorView
{
	if ([newSelectedColorView isEqual:self.selectedColorView]) {
		return;
	}
	
	[self.selectedColorView deselectView];

	self.selectedColorView = newSelectedColorView;
	[self.selectedColorView selectView];
	
	[self.delegate didSelectViewWithColor:newSelectedColorView.backgroundColor];
}

#pragma mark - Changing selected color

- (void)changeSelectedColorToColor:(UIColor *)newColor
{
	if (!self.selectedColorView) {
		return;
	}
	
	UIColor *oldColor = self.selectedColorView.backgroundColor;
	NSUInteger oldColorIndex = [self.colors indexOfObject:oldColor];
	if (oldColorIndex == NSNotFound) {
		return;
	}
	
	self.selectedColorView.backgroundColor = newColor;
	[self.colors replaceObjectAtIndex:oldColorIndex withObject:newColor];
}

#pragma mark - Adding & Deleting color views

- (void)addNewColorView
{
	UIColor *newEmptyColor = [UIColor grayColor];
	[self.colors addObject:newEmptyColor];
	
	[self setupColorsContainerViewInteractive:YES];
}

- (void)deleteSelectedColorView
{
	if (!self.selectedColorView) {
		return;
	}
	
	UIColor *color = self.selectedColorView.backgroundColor;
	[self.colors removeObject:color];
	
	[self setupColorsContainerViewInteractive:YES];
}

@end









