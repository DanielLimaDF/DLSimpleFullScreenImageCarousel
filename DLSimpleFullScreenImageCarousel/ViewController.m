//
//  ViewController.m
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageList;

- (void)viewDidLoad {
    
    imageList = [[NSMutableArray alloc]init];
    
    Image *img1 = [[Image alloc] init];
    Image *img2 = [[Image alloc] init];
    Image *img3 = [[Image alloc] init];
    Image *img4 = [[Image alloc] init];
    Image *img5 = [[Image alloc] init];
    Image *img6 = [[Image alloc] init];
    
    [img1 setLocalImage:@"1.jpg"];
    [img2 setLocalImage:@"2.jpg"];
    [img3 setLocalImage:@"3.jpg"];
    [img4 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/4.jpg"];
    [img5 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/5.jpg"];
    [img6 setUrlImage:@"http://dlsimplefullscreenimagecarousel.42noticias.com/6.jpg"];
    
    //Set content mode
    //[img2 setContentMode:UIViewContentModeScaleAspectFit]; //optional
    
    [imageList addObject:img1];
    [imageList addObject:img2];
    [imageList addObject:img3];
    [imageList addObject:img4];
    [imageList addObject:img5];
    [imageList addObject:img6];
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)showMeThePictures{
    
    [self performSegueWithIdentifier:@"goImageGo" sender:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([[segue identifier] isEqualToString:@"goImageGo"]) {
         
         DLSimpleFullScreenImageCarouselViewController *carouselView = [segue destinationViewController];
         carouselView.imageList = imageList;
         
     }
     
 }



@end
