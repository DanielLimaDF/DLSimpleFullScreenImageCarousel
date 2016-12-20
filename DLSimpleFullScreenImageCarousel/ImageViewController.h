//
//  ImageViewController.h
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController{
    NSInteger index;
    UIViewContentMode contentMode;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *imageView;

-(void)setViewIndex:(NSInteger)value;
-(NSInteger)getViewIndex;
-(void)setContentMode:(UIViewContentMode)sentMode;
-(UIViewContentMode)getContentMode;
-(void)updateFame;

@end
