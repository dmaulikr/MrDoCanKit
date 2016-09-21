//
//  DCHttpResponse.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCHttpResponse : NSObject

@property (strong, nonatomic) NSObject *data ;

@property (strong, nonatomic) NSString *error;

- (id)resolveData:(id)data;

@end
