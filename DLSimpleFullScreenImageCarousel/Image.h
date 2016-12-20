//
//  Image.h
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image : NSObject{
    UIViewContentMode contentMode;
}

@property (nonatomic,retain) UIImage *image;

-(id)init;
-(void)setLocalImage:(NSString*)imageFileName;
-(void)setUrlImage:(NSString*)imageUrl;

- (UIImage*)loadImage:(NSString *)arquivo;
-(void)saveImage:(UIImage *)img withName:(NSString*)fileName;
-(void)setContentMode:(UIViewContentMode)sentMode;
-(UIViewContentMode)getContentMode;

@end
