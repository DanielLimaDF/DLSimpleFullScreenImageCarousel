//
//  ViewController.h
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"
#import "DLSimpleFullScreenImageCarouselViewController.h"

@interface ViewController : UIViewController{
    
}

@property (nonatomic, retain) NSMutableArray *imageList;

-(IBAction)showMeThePictures;

@end

