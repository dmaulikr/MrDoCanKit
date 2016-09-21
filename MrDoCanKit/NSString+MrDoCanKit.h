//
//  NSString+MrDoCanKit.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/29.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MrDoCanKit)

+ (NSString *)JSONStringWithArray:(NSArray<JSONModel *> *)array;

- (NSString *)stringWithNum:(NSString *)string;

- (NSArray *)matchedPoundStringRange;

- (NSAttributedString *)matchedPoundStringWithFont:(float)font textColor:(UIColor *)color;

- (float)heightWithWidth:(float)width font:(float)font;

- (float)widthWithheight:(float)height font:(float)font;

- (NSInteger)multipleNameLength;

@end
