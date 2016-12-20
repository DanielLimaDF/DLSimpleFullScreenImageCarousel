//
//  ImageViewController.m
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize imageView;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    [self.view addSubview:imageView];
    
    [imageView setContentMode:contentMode];
    
    [imageView setImage:image];
    
}



-(void)viewDidAppear:(BOOL)animated{
    
    [self updateFame];
    
    [super viewDidAppear:animated];
    
}

-(void)setContentMode:(UIViewContentMode)sentMode{
    contentMode = sentMode;
}

-(UIViewContentMode)getContentMode{
    return contentMode;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self updateFame];
        
    }];
}

-(void)updateFame{
     [imageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}


-(void)setViewIndex:(NSInteger)value{
    
    index = value;
    
}
-(NSInteger)getViewIndex{
    
    return index;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
