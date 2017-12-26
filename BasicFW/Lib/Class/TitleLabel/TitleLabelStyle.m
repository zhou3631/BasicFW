//
//  TitleLabelStyle.m
//  xiao2chedai
//
//  Created by xxlc on 16/4/25.
//  Copyright © 2016年 yunfu. All rights reserved.
//

#import "TitleLabelStyle.h"

@implementation TitleLabelStyle
//统一字体颜色
- (void)titleLabel:(NSString *)str color:(UIColor *)color
{
    //自定义标题视图
    self.font = [UIFont boldSystemFontOfSize:36 * m6Scale];//醒目的；雄浑的；突出的，使用后会加粗字体
    self.textColor = color;
    self.textAlignment = NSTextAlignmentCenter;
    self.text = str;
}
//添加标题文字
+ (void)addtitleViewToVC:(UIViewController *)vc withTitle:(NSString *)title
{
    TitleLabelStyle *titleLabel = [[TitleLabelStyle alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    [titleLabel titleLabel:title color:[UIColor whiteColor]];
    vc.navigationItem.titleView = titleLabel;
}
//自定义颜色
+ (void)addtitleViewToVC:(UIViewController *)vc withTitle:(NSString *)title andTextColor:(UIColor *)color{
    TitleLabelStyle *titleLabel = [[TitleLabelStyle alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    //自定义标题视图
    [titleLabel titleLabel:title color:color];
    vc.navigationItem.titleView = titleLabel;
}



@end
