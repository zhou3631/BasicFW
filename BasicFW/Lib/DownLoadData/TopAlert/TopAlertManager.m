//
//  TopAlertManager.m
//  YFNetWorkIng
//
//  Created by xxlc on 2018/1/8.
//  Copyright © 2018年 yunfu. All rights reserved.
//

#import "TopAlertManager.h"

static TopAlert *alert = nil;
@implementation TopAlertManager

+ (void)showAlertWithType:(TopAlertType)type title:(NSString *)title{
    if (alert) {
        [alert removeFromSuperview];
    }
    alert = [[TopAlert alloc]init];
    [alert alertWithType:type title:title];
    
    switch (type) {
        case TopAlertTypeSuccess:
            alert.alertBgColor = [UIColor yellowColor];
            alert.textColor = [UIColor blackColor];
            break;
        case TopAlertTypeError:
            alert.alertBgColor = [UIColor orangeColor];
            alert.textColor = [UIColor whiteColor];
            break;
        case TopAlertTypeMessage:
            alert.alertBgColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.5];
            alert.textColor = [UIColor whiteColor];
            break;
            
    }
    [alert show];
}

@end
