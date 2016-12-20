//
//  Image.m
//  DLSimpleFullScreenImageCarousel
//
//  Created by Daniel Lima on 20/12/16.
//  Copyright © 2016 Daniel Lima. All rights reserved.
//

#import "Image.h"

@implementation Image
@synthesize image;

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

-(id)init {
    return self;
}

-(void)setLocalImage:(NSString*)imageFileName{
    
    image =[UIImage imageNamed:imageFileName];
    
}


-(void)setUrlImage:(NSString*)imageUrl{
    
    NSArray *imageParts = [imageUrl componentsSeparatedByString:@"/"];
    NSString *fileName = [imageParts lastObject];
    
    NSArray *pathsUsr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheUsuario = [pathsUsr objectAtIndex:0];
    NSString* arquivoLocal = [cacheUsuario stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:arquivoLocal];
    
    if(fileExists){
        
        image = [self loadImage:fileName];
        
    }else{
        
        dispatch_async(kBgQueue, ^{
            NSData *imgData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            if (imgData2) {
                UIImage *image2 = [UIImage imageWithData:imgData2];
                if (image2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        image = image2;
                        [self saveImage:image2 withName:fileName];
                        
                    });
                }
            }
        });
        
    }
    
    
}



- (UIImage*)loadImage:(NSString *)arquivo{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *libraryCacheDirectory = [paths objectAtIndex:0];
    NSString* path = [libraryCacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat: @"%@",arquivo]];
    UIImage* loadedImage = [UIImage imageWithContentsOfFile:path];
    return loadedImage;
}

-(void)saveImage:(UIImage *)img withName:(NSString*)fileName{
    
    if (img != nil){
        
            NSArray *pathsAtual = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *libraryCacheDirectory = [pathsAtual objectAtIndex:0];
            NSString *path = [libraryCacheDirectory stringByAppendingPathComponent:fileName];
            NSData *imageData = UIImagePNGRepresentation(img);
            [imageData writeToFile:path atomically:YES];
        
    }
}



@end
