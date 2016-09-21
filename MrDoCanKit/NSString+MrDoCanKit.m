
//
//  NSString+MrDoCanKit.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/29.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "NSString+MrDoCanKit.h"

@implementation NSString (MrDoCanKit)

+ (NSString *)JSONStringWithArray:(NSArray<JSONModel *> *)array
{
    NSString *jsonString = @"[";
    for (int i = 0; i < array.count ; i++ )
    {
        id obj = array[i];
        if ( [obj isKindOfClass:[JSONModel class]] )
        {
            if ( i != array.count - 1 )
            {
                jsonString = [NSString stringWithFormat:@"%@%@,", jsonString, [((JSONModel *)obj) toJSONString]];
            }
            else
            {
                jsonString = [NSString stringWithFormat:@"%@%@]", jsonString, [((JSONModel *)obj) toJSONString]];
            }
        }
        else
        {
            return nil;
        }
    }
    return jsonString;
}

- (NSString *)stringWithNum:(NSString *)string
{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithInt:string.intValue];
    NSString *str = [formatter stringFromNumber:num];
    return str;
}

- (NSAttributedString *)matchedPoundStringWithFont:(float)font textColor:(UIColor *)color
{
    NSMutableAttributedString * attriString = [[NSMutableAttributedString alloc] initWithString:self];
    
    [[self matchedPoundStringRange] enumerateObjectsUsingBlock:^(NSTextCheckingResult * obj, NSUInteger idx, BOOL *stop) {
        [attriString addAttributes:@{
                                     NSFontAttributeName:[UIFont systemFontOfSize:font],
                                     NSForegroundColorAttributeName:color
                                     }
                             range:obj.range];
    }];
    
    return attriString;
}

- (NSArray *)matchedPoundStringRange
{
    NSError *error;
    
    NSString * regulaStr = @"#[^#]+#";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
}

- (float)heightWithWidth:(float)width font:(float)font
{
    // 计算文本的大小
    CGSize sizeToFit = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}        // 文字的属性
                                          context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height;
}

- (float)widthWithheight:(float)height font:(float)font
{
    // 计算文本的大小
    CGSize sizeToFit = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) // 用于计算文本绘制时占据的矩形块
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}        // 文字的属性
                                          context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.width;
}

- (NSInteger)multipleNameLength
{
    NSInteger count = 0;
    
    NSRegularExpression *  iExpression;
    NSString * pattern = @"[^\u4e00-\u9fa5]+";
    iExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    NSRange paragaphRange = NSMakeRange(0, self.length);
    
    NSArray * matches = [iExpression matchesInString:self options:0 range:paragaphRange];
    if ( matches )
    {
        for (int i = 0; i < matches.count;i++)
        {
            NSTextCheckingResult *result = matches[i];
            count += result.range.length;
        }
    }
    
    NSRegularExpression * iExpression2;
    NSString * pattern2 = @"[\u4e00-\u9fa5]+";
    iExpression2 = [NSRegularExpression regularExpressionWithPattern:pattern2 options:0 error:NULL];
    
    NSArray * matches2 = [iExpression2 matchesInString:self options:0 range:paragaphRange];
    if ( matches2 )
    {
        for (int i = 0; i < matches2.count;i++)
        {
            NSTextCheckingResult *result = matches2[i];
            count += result.range.length;
        }
    }
    return count;
}


@end
