//
//  Factory.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "Factory.h"

@implementation Factory

/**
 左边的按钮
 */
+ (UIButton *)addLeftbottonToVC:(UIViewController *)vc{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70*m6Scale, 70*m6Scale)];
    [button setImage:[UIImage imageNamed:@"Back-Arrow"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    vc.navigationItem.leftBarButtonItem = leftBarButton;
    return button;
}

@end
