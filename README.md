# DLSimpleFullScreenImageCarousel

License: MIT

Platform: iOs

##Very simple way to show images on a full-screen carousel (Using Storyboard)

DLSimpleFullScreenImageCarousel is a Custom ViewController that shows local images or loaded from the web in a PageViewController.

####GIF Screen Record:

![GIF](https://github.com/DanielLimaDF/DLSimpleFullScreenImageCarousel/blob/master/ScreenShots/capture.gif)

## Usage

Implementing DLSimpleFullScreenImageCarousel is fairly easy, the first step is to set up your Storyboard:
![Alt][screenshot1]
[screenshot1]: https://github.com/DanielLimaDF/DLSimpleFullScreenImageCarousel/blob/master/ScreenShots/xcode.png

Simply copy the ViewController to your project and create a Segue to take to it:
![Alt][screenshot2]
[screenshot2]: https://github.com/DanielLimaDF/DLSimpleFullScreenImageCarousel/blob/master/ScreenShots/segue.png

Coding:

```obj-c

//You can, for example, create a vector of images

	imageList = [[NSMutableArray alloc]init];
    
    Image *img1 = [[Image alloc] init];
    Image *img2 = [[Image alloc] init];
    Image *img3 = [[Image alloc] init];
    Image *img4 = [[Image alloc] init];
    Image *img5 = [[Image alloc] init];
    Image *img6 = [[Image alloc] init];
    
    [img1 setLocalImage:@"youylocalimage1.jpg"];
    [img2 setLocalImage:@"youylocalimage2.jpg"];
    [img3 setLocalImage:@"youylocalimage3.jpg"];
    [img4 setUrlImage:@"http://yoururl.com/4.jpg"];
    [img5 setUrlImage:@"http://yoururl.com/5.jpg"];
    [img6 setUrlImage:@"http://yoururl.com/6.jpg"];
    
    //Set content mode
    //[img2 setContentMode:UIViewContentModeScaleAspectFit]; //optional
    
    [imageList addObject:img1];
    [imageList addObject:img2];
    [imageList addObject:img3];
    [imageList addObject:img4];
    [imageList addObject:img5];
    [imageList addObject:img6];

//To display the PageViewController perform the Segue

[self performSegueWithIdentifier:@"goImageGo" sender:self];

//And pass the vector to the destination DLSimpleFullScreenImageCarouselViewController

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([[segue identifier] isEqualToString:@"goImageGo"]) {
         
         DLSimpleFullScreenImageCarouselViewController *carouselView = [segue destinationViewController];
         
         carouselView.imageList = imageList;
         
     }
     
 }


```

I recommend that you download and run the project to better understand how it works.

## License

DLSimpleFullScreenImageCarousel is available under the MIT license. See the LICENSE file for more info.