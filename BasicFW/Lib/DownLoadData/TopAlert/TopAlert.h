//
//  TopAlert.h
//  YFNetWorkIng
//
//  Created by xxlc on 2018/1/8.
//  Copyright © 2018年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TopAlertType){
    TopAlertTypeSuccess = 1,//成功
    TopAlertTypeError = 0,//失败
    TopAlertTypeMessage = 2//提示信息
};

@interface TopAlert : UIView
//提示框背景颜色
@property (nonatomic,weak) UIColor *alertBgColor;
//提示框显示时间
@property (nonatomic,assign) CGFloat alertShowTime;
//文字颜色
@property (nonatomic,strong) UIColor *textColor;

- (void)show;

- (void)alertWithType:(TopAlertType)type title:(NSString *)title;
@end
