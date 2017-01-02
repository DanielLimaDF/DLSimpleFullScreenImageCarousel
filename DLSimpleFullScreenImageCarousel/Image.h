//
//  Image.h
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageDelegate
- (void)ImageFinishedLoading;
@end

@interface Image : NSObject{
    id <NSObject, ImageDelegate > delegate;
    UIViewContentMode contentMode;
    BOOL imageDownloadCompleted;
}

@property (nonatomic,retain) UIImage *image;
@property (retain) id <NSObject, ImageDelegate > delegate;

-(id)init;
-(void)setLocalImage:(NSString*)imageFileName;
-(void)setUrlImage:(NSString*)imageUrl;

- (UIImage*)loadImage:(NSString *)arquivo;
-(void)saveImage:(UIImage *)img withName:(NSString*)fileName;
-(void)setContentMode:(UIViewContentMode)sentMode;
-(UIViewContentMode)getContentMode;
-(BOOL)haveFinishedDownloading;

@end
