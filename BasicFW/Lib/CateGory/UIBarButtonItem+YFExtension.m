//
//  UIBarButtonItem+YFExtension.m
//  XianJinDai
//
//  Created by xxlc on 2017/10/17.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "UIBarButtonItem+YFExtension.h"

@implementation UIBarButtonItem (YFExtension)

+ (UIBarButtonItem *)BarButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)sel{
    UIButton *textBtn = [[UIButton alloc] init];
    [textBtn setTitle:title forState:UIControlStateNormal];
    [textBtn setTitleColor:color forState:0];
    textBtn.titleLabel.font = [UIFont systemFontOfSize:K_TitleBigFont*m6Scale];
    CGSize btnSize = [title sizeWithAttributes:@{NSFontAttributeName : textBtn.titleLabel.font}];
    textBtn.bounds = CGRectMake(0, 0, btnSize.width, btnSize.height);
    [textBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:textBtn];
    return btnItem;
}
+ (UIBarButtonItem *)BarButtonItemWithImage:(NSString *)image highlightedImg:(NSString *)highlightImg target:(id)target action:(SEL)sel isLeft:(BOOL)isLeft{
    UIButton *imgBtn = [[UIButton alloc] init];
    UIImage *img = [UIImage imageNamed:image];
    UIImage *selImg = highlightImg.length ? [UIImage imageNamed:highlightImg] : nil;
    imgBtn.frame = CGRectMake(0, 0, 44, 44);
    if (isLeft) {
        imgBtn.contentEdgeInsets =UIEdgeInsetsMake(0, -20,0, 0);
        imgBtn.imageEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
    }
    else{
        imgBtn.contentEdgeInsets =UIEdgeInsetsMake(0, 0,0, -20);
        imgBtn.imageEdgeInsets =UIEdgeInsetsMake(0, 0,0, -15);
    }
    [imgBtn setImage:img forState:UIControlStateNormal];
    [imgBtn setImage:img forState:UIControlStateHighlighted];
    [imgBtn setImage:selImg forState:UIControlStateSelected];
    [imgBtn setTitle:@"  " forState:0];
    [imgBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    return btnItem;
}
@end
