//
//  PKOGeneratingClothingCombinationsViewController.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 17/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOGeneratingClothingCombinationsViewController.h"
#import "PKOClothingCombinationCollectionViewController.h"

#import "PKOUser.h"
#import "PKOClothingCombinationsGenerator.h"
#import "PKOClothingCombinationStore.h"
#import "PKODebugging.h"


static NSString *const PKOCancelGeneratingClothingCombinationsSegueIdentifier = @"CancelGeneratingClothingCombinationsSegueIdentifier";
static NSString *const PKOSaveNewClothingCombinationSegueIdentifier = @"SaveNewClothingCombinationSegueIdentifier";


@interface PKOGeneratingClothingCombinationsViewController () <UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBarButtonItem;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *clothingCombinations;
@property (assign, nonatomic) NSUInteger startingIndex;

@end


@implementation PKOGeneratingClothingCombinationsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIPageControl *pageControl = [UIPageControl appearance];
	pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
	pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
	
	[self.toolbar setBackgroundImage:[[UIImage alloc] init]
				  forToolbarPosition:UIToolbarPositionAny
						  barMetrics:UIBarMetricsDefault];
	
	self.startingIndex = 0;
	
	[self generateCombinations];
}

#pragma mark - Generating combinations

- (void)generateCombinations
{
	[self startAsynchronousProcess];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		
		PKOClothingCombinationsGenerator *generator = [[PKOClothingCombinationsGenerator alloc] initWithUser:self.user
																							   withDressCode:self.dressCode];
		self.clothingCombinations = [[generator generateCombinations] mutableCopy];
		
		if (!self.isViewLoaded || !self.view.window) {
			NSLog(@"Generating combinations: !self.isViewLoaded || !self.view.window");
			return;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self stopAsynchronousProcess];
			if (self.clothingCombinations.count) {
				[self setupPageViewController];
				[self enableButtons];
			}
		});
	});
}

#pragma mark - Asynchronous process

- (void)startAsynchronousProcess
{
	[self.activityIndicator startAnimating];
}

- (void)stopAsynchronousProcess
{
	[self.activityIndicator stopAnimating];
}

#pragma mark - Setup buttons

- (void)enableButtons
{
	self.saveBarButtonItem.enabled = YES;
	self.deleteBarButtonItem.enabled = YES;
}

#pragma mark - Setup UIPageViewController

- (void)setupPageViewController
{
	if (self.clothingCombinations.count == 0) {
		return;
	}
	NSString *pageViewControllerIdentifier = NSStringFromClass([UIPageViewController class]);
	self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:pageViewControllerIdentifier];
	self.pageViewController.dataSource = self;
	
	UINavigationController *startingViewController = [self viewControllerAtIndex:self.startingIndex];
	NSArray *viewControllers = @[startingViewController];
	
	[self.pageViewController setViewControllers:viewControllers
									  direction:UIPageViewControllerNavigationDirectionForward
									   animated:NO
									 completion:nil];
	
	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];
	[self.view bringSubviewToFront:self.toolbar];
	[self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	PKOClothingCombinationCollectionViewController *clothingCombinationViewController = [((UINavigationController *)viewController).viewControllers firstObject];
	NSUInteger index = clothingCombinationViewController.pageIndex;
	if (index == 0 || index == NSNotFound) {
		return nil;
	}
	
	index--;
	return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	PKOClothingCombinationCollectionViewController *clothingCombinationViewController = [((UINavigationController *)viewController).viewControllers firstObject];
	NSUInteger index = clothingCombinationViewController.pageIndex;
	index++;
	if (index >= self.clothingCombinations.count) {
		return nil;
	}
	return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
	return self.clothingCombinations.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
	return self.startingIndex;
}

#pragma mark - Content view controller at index

- (UINavigationController *)viewControllerAtIndex:(NSUInteger)index
{
	if (self.clothingCombinations.count == 0 || index >= self.clothingCombinations.count) {
		return nil;
	}
	
	NSString *contentViewControllerIdentifier = NSStringFromClass([PKOClothingCombinationCollectionViewController class]);
	PKOClothingCombinationCollectionViewController *clothingCombinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:contentViewControllerIdentifier];
	
	clothingCombinationViewController.clothingCombination = self.clothingCombinations[index];
	clothingCombinationViewController.pageIndex = index;
	clothingCombinationViewController.user = self.user;
	
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:clothingCombinationViewController];
	return navigationController;
}

#pragma mark - IBAction

- (IBAction)refuseClothingCombination:(id)sender
{
	UINavigationController *navController = [self.pageViewController.viewControllers firstObject];
	PKOClothingCombinationCollectionViewController *clothingCombinationController = [navController.viewControllers firstObject];
	PKOClothingCombination *clothingCombination = clothingCombinationController.clothingCombination;
	
	[self.clothingCombinations removeObject:clothingCombination];
	[self.user.clothingCombinationStore addRefusedClothingCombination:clothingCombination];
	
	if (self.clothingCombinations.count == 0) {
		[self performSegueWithIdentifier:PKOCancelGeneratingClothingCombinationsSegueIdentifier sender:self];
		return;
	}

	NSUInteger oldIndex = clothingCombinationController.pageIndex;
	BOOL isRemovingLastPage = oldIndex == self.clothingCombinations.count;
	self.startingIndex = isRemovingLastPage ? oldIndex - 1 : oldIndex;
	
	UIPageViewControllerNavigationDirection direction = isRemovingLastPage ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
	
	UINavigationController *newCurrentController = [self viewControllerAtIndex:self.startingIndex];
	NSArray *viewControllers = @[newCurrentController];
	[self.pageViewController setViewControllers:viewControllers
									  direction:direction
									   animated:YES
									 completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:PKOSaveNewClothingCombinationSegueIdentifier]) {
		
		UINavigationController *navController = [self.pageViewController.viewControllers firstObject];
		PKOClothingCombinationCollectionViewController *clothingCombinationController = [navController.viewControllers firstObject];
		
		self.selectedClothingCombination = clothingCombinationController.clothingCombination;
	}
}

@end











