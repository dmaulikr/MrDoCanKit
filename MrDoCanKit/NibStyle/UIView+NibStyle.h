//
//  UIView+NibStyle.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/10/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibStyle)

@property (strong, nonatomic) NSString *backgroundColorToSpacious;

@property (nonatomic) id nibBorderColor;
@property (nonatomic) NSNumber * nibBorderWidth;
@property (nonatomic) NSNumber * nibCornerRadius;
@property (nonatomic) NSString * nibBackgroundColorToAppTheme;

@end
