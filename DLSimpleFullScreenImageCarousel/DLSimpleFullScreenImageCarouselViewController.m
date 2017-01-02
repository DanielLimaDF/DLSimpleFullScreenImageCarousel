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
@synthesize loadingView;
@synthesize loadingIndicator;
@synthesize loadingLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [customController setHidden:YES];
    
    viewControllerList = [[NSMutableArray alloc]init];
    
    //create view controller list
    for (int i = 0; i < [imageList count]; i++){
        
        ImageViewController *imgViewController = [[ImageViewController alloc]init];
        [imgViewController setViewIndex:i];
        
        Image *currentImage = [imageList objectAtIndex:i];
        
        [imgViewController setContentMode:currentImage.getContentMode];
        
        imgViewController.DLImage = currentImage;
        imgViewController.image = currentImage.image;
        currentImage.delegate = self;
        
        [viewControllerList addObject:imgViewController];
        
    }
    
    
    if([self checkImagesDownload]){
        [self startPageController];
    }else{
        [self displayLoadingView];
    }
    
    
}

-(void)startPageController{
    
    [self hideLoadingView];
    
    
    //Reset viewcontroller list to avoid delay in image exibition
    viewControllerList = [[NSMutableArray alloc]init];
    
    //create view controller list
    for (int i = 0; i < [imageList count]; i++){
        
        ImageViewController *imgViewController = [[ImageViewController alloc]init];
        [imgViewController setViewIndex:i];
        
        Image *currentImage = [imageList objectAtIndex:i];
        
        [imgViewController setContentMode:currentImage.getContentMode];
        
        imgViewController.DLImage = currentImage;
        imgViewController.image = currentImage.image;
        currentImage.delegate = self;
        
        [viewControllerList addObject:imgViewController];
        
    }
    
    
    currentIndex = 0;
    nextIndex = 1;
    
    initialViewArray = [[NSMutableArray alloc]init];
    
    initialImageView =  [[ImageViewController alloc]init];
    
    Image *initialImage = [imageList objectAtIndex:0];
    
    [initialImageView setContentMode:initialImage.getContentMode];
    initialImageView.image = initialImage.image;
    
    
    [initialViewArray addObject:initialImageView];
    
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageController.dataSource = self;
    pageController.delegate = self;
    
    [[pageController view] setFrame:[[self view] bounds]];
    
    
    
    [pageController setViewControllers:initialViewArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    pageControl = [self getPageControl];
    
    [pageControl setHidden:YES];
    
    pageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
    
    [customController setHidden:NO];
    
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


-(void)displayLoadingView{
    
    //Loading View
    [loadingView setHidden:NO];
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 90, self.view.frame.size.height/2 - 25, 180, 50)];
    [loadingView setBackgroundColor:[UIColor whiteColor]];
    [loadingView setAlpha:0.8];
    [loadingView.layer setCornerRadius:10];
    
    //Activity indicator
    loadingIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setFrame:CGRectMake(0, 0, 50, 50)];
    [loadingIndicator startAnimating];
    
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    [loadingLabel setTextColor:[UIColor grayColor]];
    [loadingLabel setText:@"Loading Photos"];
    
    [loadingView addSubview:loadingIndicator];
    [loadingView addSubview:loadingLabel];
    [self.view addSubview:loadingView];
    
}

-(void)hideLoadingView{
    [loadingView setHidden:YES];
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

-(BOOL)checkImagesDownload{
    
    NSInteger totalItens = [imageList count];
    NSInteger downloadedItens = 0;
    
    for (int i = 0; i < [imageList count]; i++){
        
        Image *ImageToCheck = [imageList objectAtIndex:i];
        
        if([ImageToCheck haveFinishedDownloading]){
            downloadedItens++;
        }
        
    }
    
    
    if(totalItens == downloadedItens){
        return YES;
    }else{
        return NO;
    }
    
}

//Delegate
- (void)ImageFinishedLoading{
    if([self checkImagesDownload]){
        
        [self startPageController];
        
    }
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
