//
//  UIView+ViewController.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/9.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
//查找当前视图所在的视图控制器
- (UIViewController *)ViewController {
    
    UIResponder *next = self.nextResponder;
    while (YES) {
        if ([next.nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next.nextResponder;
        } else if (next.nextResponder == nil) {
            return nil;
        }
        next = next.nextResponder;
    }
}

@end
