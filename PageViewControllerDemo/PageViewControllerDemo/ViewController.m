//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import "LPPageViewController.h"
#import "PageVCContentController.h"

@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,strong)NSArray * childVCTitles;//子控制器
@property(nonatomic,strong)LPPageViewController * pageViewController;
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.childVCTitles = @[@"第一个控制器",@"第二个控制器",@"第三个控制器"];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LPPageViewController"];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    PageVCContentController * viewController = [self getViewControllerWithIndex:0];
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    self.title = self.childVCTitles.firstObject;
    self.currentIndex = 0;
}

- (PageVCContentController *)getViewControllerWithIndex:(NSInteger )index
{
    
    if ( index >= [self.childVCTitles count]) {
        return nil;
    }
    PageVCContentController * vc = [[PageVCContentController alloc] init];
    switch (index) {
        case 0:
            vc.view.backgroundColor = [UIColor redColor];
            break;
        case 1:
            vc.view.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            vc.view.backgroundColor = [UIColor orangeColor];
            break;
        default:
            vc.view.backgroundColor = [UIColor whiteColor];
            break;
    }
    vc.titleText = self.childVCTitles[index];
    return vc;
}

#pragma mark -- pageViewControllerDelegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
  
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSInteger index = [self indexOfViewController:pageViewController.viewControllers.firstObject];
    self.currentIndex = index;
    if (completed) {
        self.title = self.childVCTitles[self.currentIndex];
    }
    
}

// Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
// Delegate may set new view controllers or update double-sided state within this method's implementation as well.
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    return UIPageViewControllerSpineLocationMin;
}

- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController
{
    
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController
{
    
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark --  pageVC dataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == 0||index == NSNotFound) {
        return nil;
    }
    index --;
    return [self getViewControllerWithIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index ++;
    return [self getViewControllerWithIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController // The number of items reflected in the page indicator.
{
    
    return self.childVCTitles.count;
}


- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    
    return 0;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    PageVCContentController * pageVC = (PageVCContentController *)viewController;
    NSLog(@"%ld ------ %@", [self.childVCTitles indexOfObject:pageVC.titleText],pageVC.titleText);
    return [self.childVCTitles indexOfObject:pageVC.titleText];
    
}


@end
