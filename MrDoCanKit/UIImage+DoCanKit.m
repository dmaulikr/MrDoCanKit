//
//  UIImage+DoCanKit.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/17.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UIImage+DoCanKit.h"

@implementation UIImage (DoCanKit)

#pragma mark -

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark -

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -

- (UIImage *)fixedLibraryImageToSize:(CGSize)size
{
    UIImage * newImage = self;
    
    if ( newImage.size.height > size.height && newImage.size.width > size.width )
    {
        CGFloat width = newImage.size.width * size.height / newImage.size.height;
        CGFloat height = size.height;
        
        newImage = [newImage scaleToSize:CGSizeMake( floorf(width), height)];
        
        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.6 );
        
        if ( imageData )
        {
            return [UIImage imageWithData:imageData];
        }
        else
        {
            return newImage;
        }
    }
    else
    {
        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.6 );
        
        if ( imageData )
        {
            return [UIImage imageWithData:imageData];
        }
        else
        {
            return newImage;
        }
    }
}

- (void)fixedCameraImageToSize:(CGSize)size then:(void (^)(NSData *))then
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) , ^{
        UIImage * image = [[self fixOrientation] fixedCameraImageToSize:size];
        NSData * data = UIImageJPEGRepresentation(image, 1.0);
        dispatch_async(dispatch_get_main_queue(), ^{
            then(data);
        });
    });
}

- (UIImage *)fixedCameraImageToSize:(CGSize)size
{
    UIImage * newImage = self;
    
    if ( newImage.size.width > newImage.size.height )
    {
        newImage = [newImage scaleToSize:CGSizeMake( newImage.size.width * size.height / newImage.size.height, size.height )];
    }
    else
    {
        newImage = [newImage scaleToSize:CGSizeMake( size.width, newImage.size.height * size.width / newImage.size.width )];
    }
    
    NSData * imageData = UIImageJPEGRepresentation( newImage, 0.6 );
    
    if ( imageData )
    {
        return [UIImage imageWithData:imageData];
    }
    else
    {
        return newImage;
    }
    
    return newImage;
}

#pragma mark -

- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
