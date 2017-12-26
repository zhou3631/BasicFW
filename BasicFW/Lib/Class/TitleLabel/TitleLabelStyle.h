//
//  TitleLabelStyle.h
//  xiao2chedai
//
//  Created by xxlc on 16/4/25.
//  Copyright © 2016年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleLabelStyle : UILabel

/**
 统一字体颜色
 */
- (void)titleLabel:(NSString *)str color:(UIColor *)color;
/**
 自定义字体颜色
 */
+ (void)addtitleViewToVC:(UIViewController *)vc withTitle:(NSString *)title andTextColor:(UIColor *)color;
/**
 添加标题
 */
+ (void)addtitleViewToVC:(UIViewController *)vc withTitle:(NSString *)title;

@end
