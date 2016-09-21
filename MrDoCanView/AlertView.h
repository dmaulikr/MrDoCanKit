//
//  AlertView.h
//  MrDoCanView
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertView;

#pragma mark - 控件的类型
typedef enum {
	AlertViewTypeNode = 0,
	AlertViewTypeMonospaced = 1
} AlertViewType;

@protocol AlertContentView <NSObject>
@property (nonatomic, weak) AlertView * container;
@property (nonatomic, copy) void (^whenSeleced)(NSString *signal, BOOL isSendMessage);
@property (nonatomic, copy) void (^whenRegistered)(id data);
@property (nonatomic, copy) void (^whenHide)(BOOL hide);
@end

@interface AlertView : UIView

- (instancetype)initWithContent:(UIView<AlertContentView> *)content type:(AlertViewType)type;

- (void)show;
- (void)showIn:(UIView *)container;

- (void)hide;
- (void)hideWithCompetion:(void (^)(BOOL finished))completion;

- (void)showSharedView;
- (void)showModifyViewIn:(UIView *)container;

- (void)setViewYWithNumber:(NSInteger)number;

@end