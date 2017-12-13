//
//  UIBarButtonItem+YFExtension.h
//  XianJinDai
//
//  Created by xxlc on 2017/10/17.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YFExtension)

/**
 快速创建纯文字UIBarButtonItem

 @param title 标题
 @param color 颜色
 @param target 目标
 @param sel 点击方法
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)BarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)sel;

/**
 快速创建纯图片UIBarButtonItem

 @param image 图片
 @param highlightImg 高亮图片
 @param target 目标
 @param sel 点击方法
 @param isLeft 区分左右
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)BarButtonItemWithImage:(NSString *)image highlightedImg :(NSString *)highlightImg target:(id)target action:(SEL)sel isLeft:(BOOL)isLeft;
@end
