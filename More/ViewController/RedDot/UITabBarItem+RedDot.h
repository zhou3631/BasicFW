//
//  UITabBarItem+RedDot.h
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/25.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (RedDot)
// 需要根据文字的多少显示UI布局
- (void)makeBadgeTextNum:(NSInteger )textNum textColor:(UIColor *)tColor backColor:(UIColor *)backColor Font:(UIFont*)tfont;
// 有的只需要显示小红点-->无标题
- (void)makeRedBadge:(CGFloat)corner color:(UIColor *)cornerColor;

- (void)removeBadgeView;

@end
