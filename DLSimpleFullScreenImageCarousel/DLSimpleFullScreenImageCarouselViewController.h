//
//  DLSimpleFullScreenImageCarouselViewController.h
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"
#import "ImageViewController.h"

@interface DLSimpleFullScreenImageCarouselViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, ImageDelegate>{
    
    NSInteger currentIndex;
    NSInteger nextIndex;
    
}

@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic, retain) NSMutableArray *viewControllerList;
@property (nonatomic, retain) NSMutableArray *initialViewArray;
@property (nonatomic, retain) ImageViewController *initialImageView;
@property (strong, nonatomic) UIPageViewController *pageController;

@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIPageControl *customController;

@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UILabel *loadingLabel;

- (UIPageControl*)getPageControl;

-(IBAction)changePageByUser:(id)sender;
-(void)startPageController;
-(void)ImageFinishedLoading;
-(BOOL)checkImagesDownload;
-(void)displayLoadingView;
-(void)hideLoadingView;
@end
