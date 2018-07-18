//
//  PKOColorsContainerView.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 13/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PKOColorsContainerViewDelegate <NSObject>

- (void)didSelectViewWithColor:(UIColor *)color;

@end


@interface PKOColorsContainerView : UIView

@property (weak, nonatomic) id<PKOColorsContainerViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *colors;

- (void)setupColorsContainerViewInteractive:(BOOL)interactive;
- (void)changeSelectedColorToColor:(UIColor *)newColor;
- (void)addNewColorView;
- (void)deleteSelectedColorView;

@end
