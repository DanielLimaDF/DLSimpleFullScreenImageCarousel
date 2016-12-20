//
//  DLSimpleFullScreenImageCarouselViewController.m
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "DLSimpleFullScreenImageCarouselViewController.h"

@interface DLSimpleFullScreenImageCarouselViewController ()

@end

@implementation DLSimpleFullScreenImageCarouselViewController
@synthesize imageList;
@synthesize pageController;
@synthesize viewControllerList;
@synthesize initialImageView;
@synthesize initialViewArray;
@synthesize pageControl;
@synthesize customController;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    currentIndex = 0;
    nextIndex = 1;
    
    viewControllerList = [[NSMutableArray alloc]init];
    
    initialViewArray = [[NSMutableArray alloc]init];
    
    initialImageView =  [[ImageViewController alloc]init];
    
    Image *initialImage = [imageList objectAtIndex:0];
    
    initialImageView.image = initialImage.image;
    
    [initialViewArray addObject:initialImageView];
    
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageController.dataSource = self;
    pageController.delegate = self;
    
    [[pageController view] setFrame:[[self view] bounds]];
    
    //create view controller list
    for (int i = 0; i < [imageList count]; i++){
        
        ImageViewController *imgViewController = [[ImageViewController alloc]init];
        [imgViewController setViewIndex:i];
        
        Image *currentImage = [imageList objectAtIndex:i];
        imgViewController.image = currentImage.image;
        
        [viewControllerList addObject:imgViewController];
        
        
    }
    
    [pageController setViewControllers:initialViewArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    
    pageControl = [self getPageControl];
    
    [pageControl setHidden:YES];
    
    pageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
    
    [self.view bringSubviewToFront:customController];
    
    [customController setNumberOfPages:[viewControllerList count]];
    [customController setCurrentPage:0];
    
}




- (UIPageControl*)getPageControl {
    for (UIView* view in pageController.view.subviews) {
        if ([view isKindOfClass:[UIPageControl class]]) {
            //set new pageControl position
            view.frame = CGRectMake( 100, 200, 100, 100);
            //NSLog(@"PageControl found");
            return (id)view;
        }
    }
    return nil;
}




- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger previousView = currentIndex - 1;
    
    if(previousView < 0){
        return nil;
    }
    
    ImageViewController *newView = [viewControllerList objectAtIndex:previousView];
    
    return newView;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger nextView = currentIndex + 1;
    
    if(nextView == ([viewControllerList count])){
        return nil;
    }
    
    ImageViewController *newView = [viewControllerList objectAtIndex:nextView];
    
    return newView;
    
}


- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    
    ImageViewController* viewSeguinte = [pendingViewControllers firstObject];
    nextIndex = [viewSeguinte getViewIndex];
    
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if(completed){
        
        if(nextIndex >= 0 && nextIndex < ([viewControllerList count])){
            currentIndex = nextIndex;
            [customController setCurrentPage:currentIndex];
        }
    
    }
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [viewControllerList count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return currentIndex;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePageByUser:(id)sender{
    
    UIPageControl *currentControl = sender;
    
    //NSLog(@"Lets go to page: %ld",(long)currentControl.currentPage);
    
    initialViewArray = [[NSMutableArray alloc]init];
    
    [initialViewArray addObject:[viewControllerList objectAtIndex:currentControl.currentPage]];
    
    nextIndex = currentControl.currentPage;
    
    if(nextIndex > currentIndex){
        [pageController setViewControllers:initialViewArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }else{
        [pageController setViewControllers:initialViewArray direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    
    [pageControl setCurrentPage:currentControl.currentPage];
    
    currentIndex = currentControl.currentPage;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
