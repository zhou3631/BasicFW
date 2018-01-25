//
//  UITabBarItem+RedDot.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/25.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "UITabBarItem+RedDot.h"
#import <objc/runtime.h>
#import "RedDotLab.h"

const  static NSString *tabBar_BadgeLableString = @"tabBar_BadgeLableString";

@implementation UITabBarItem (RedDot)

- (void)makeBadgeTextNum:(NSInteger )textNum textColor:(UIColor *)tColor backColor:(UIColor *)backColor Font:(UIFont*)tfont{
    if (textNum>99) {
        
    }
}
- (void)makeRedBadge:(CGFloat)corner color:(UIColor *)cornerColor{
    
    UIView *TabBar_item_=[self valueForKey:@"_view"];
    UIView *UITabBarSwappableImageView=[self findSwappableImageViewByInView:TabBar_item_];
    if ([self badgeLable] == nil) {//如果没有绑定就重新创建,然后绑定
        RedDotLab *badgeLable = [[RedDotLab alloc] init];
        objc_setAssociatedObject(self, &tabBar_BadgeLableString, badgeLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [UITabBarSwappableImageView addSubview:badgeLable];
    }
    [[self badgeLable]setFrame:CGRectMake(UITabBarSwappableImageView.frame.size.width-corner, -corner, corner*2.0, corner*2.0)];
    [[self  badgeLable] makeBrdgeViewWithCor:corner CornerColor:cornerColor];
    
}

- (void)removeBadgeView{
    [[self badgeLable] removeFromSuperview];
}

- (RedDotLab *)badgeLable{
    
    RedDotLab *badgeLable = objc_getAssociatedObject(self, &tabBar_BadgeLableString);
    return badgeLable;
}

- (UIView *)findSwappableImageViewByInView:(UIView *)inView{
    for (UIView *subView in inView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            return subView;
        }
    }
    return nil;
}

@end
