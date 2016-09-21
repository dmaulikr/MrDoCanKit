//
//  UIImage+DoCanKit.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/17.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DoCanKit)

- (UIImage *)scaleToSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)fixedLibraryImageToSize:(CGSize)size;
- (UIImage *)fixedCameraImageToSize:(CGSize)size;

- (void)fixedCameraImageToSize:(CGSize)size then:(void (^)(NSData *))then;

- (UIImage *)fixOrientation;

@end
