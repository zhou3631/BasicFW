//
//  TopAlert.m
//  YFNetWorkIng
//
//  Created by xxlc on 2018/1/8.
//  Copyright © 2018年 yunfu. All rights reserved.
//

#import "TopAlert.h"
//电池栏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define kNavBarHeight 44.0
//导航+电池栏
#define NavgationBarHeight (kStatusBarHeight + kNavBarHeight)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface TopAlert ()

@property (nonatomic,strong) UILabel *alertLab;

@property (nonatomic,strong) UIImageView *alertImage;

@end

@implementation TopAlert

- (instancetype)init{
    if (self = [super init]) {
        //初始位置
        self.frame = CGRectMake(0, -NavgationBarHeight, ScreenWidth, NavgationBarHeight);
        self.alertShowTime = 1.5f;
        //弹性动画
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:6 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.center = CGPointMake(ScreenWidth/2, NavgationBarHeight/2);
        } completion:^(BOOL finished) {
            [self performSelector:@selector(removeAlert) withObject:nil afterDelay:self.alertShowTime];
        }];
        
        [self createAlert];
    }
    return self;
}

/**
 创建控件
 */
- (void)createAlert{
    //背景色
    self.backgroundColor = [UIColor greenColor];
    //提示图
    UIImageView *alertIMG = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+NavgationBarHeight/2-10, 20, 20)];
    [self addSubview:alertIMG];
    self.alertImage = alertIMG;
    
    //提示信息
    UILabel *alertL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(alertIMG.frame)+5, 10+NavgationBarHeight/2-20, ScreenWidth-CGRectGetMaxX(alertIMG.frame) -5 -10, 40)];
    alertL.textColor = [UIColor whiteColor];
    alertL.font = [UIFont systemFontOfSize:15];
    [self addSubview:alertL];
    self.alertLab = alertL;
    
}

/**
 显示提示框
 */
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}

/**
 移除提示框
 */
- (void)removeAlert{
    [UIView transitionWithView:self duration:0.2 options:0 animations:^{
        self.center = CGPointMake(ScreenWidth/2, -NavgationBarHeight/2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark ===外部配置
- (void)setAlertBgColor:(UIColor *)alertBgColor{
    self.backgroundColor = alertBgColor;
}
- (void)alertWithType:(TopAlertType)type title:(NSString *)title{
    self.alertLab.text = title;
    switch (type) {
        case TopAlertTypeSuccess:
            self.alertImage.image = [UIImage imageNamed:@"type_success"];
            break;
        case TopAlertTypeError:
            self.alertImage.image = [UIImage imageNamed:@"type_error"];
            break;
        case TopAlertTypeMessage:
            self.alertImage.image = [UIImage imageNamed:@"type_message"];
            break;
            
    }
}
- (void)setTextColor:(UIColor *)textColor{
    self.alertLab.textColor = textColor;
}
@end
