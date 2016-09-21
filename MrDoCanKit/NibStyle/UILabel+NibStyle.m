//
//  UILabel+NibStyle.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/17.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UILabel+NibStyle.h"

@implementation UILabel (NibStyle)

@dynamic nibTextColor;
@dynamic nibAdjusts;
@dynamic nibColor;

- (void)setNibTextColor:(NSString *)nibTextColor
{
    self.textColor = [UIColor colorWithHexString:nibTextColor];;
}

- (void)setNibColor:(NSString *)nibColor
{
    [self setNibTextColor:nibColor];
}

- (void)setNibAdjusts:(NSNumber *)nibAdjusts
{
    self.adjustsFontSizeToFitWidth = nibAdjusts.intValue;
}


//example : color,c0;font,f0
- (void)setFontType:(NSString *)fontType
{
    NSArray * types = [fontType componentsSeparatedByString:@";"];
    
    NSString * colorStr = types[0];
    NSString * fontStr = types[1];
    
    NSArray * colorArray = [colorStr componentsSeparatedByString:@","];
    
    NSArray * fontArray = [fontStr componentsSeparatedByString:@","];
    
    NSDictionary * dicts = [AppTheme styleClass];
    
    NSDictionary * colorDict = dicts[colorArray[0]];
    NSDictionary * fontDict = dicts[fontArray[0]];
    
    self.textColor = colorDict[colorArray[1]];
    self.font = fontDict[fontArray[1]];
}

@end
