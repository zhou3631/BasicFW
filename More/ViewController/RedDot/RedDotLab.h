//
//  RedDotLab.h
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/24.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedDotLab : UILabel
//有内容的红点
- (void)makeBrdgeViewWithText:(NSString *)text textColor:(UIColor *)textColor   backColor:(UIColor *)backGColor textFont:(UIFont *)font tframe:(CGRect )frame;
//只有颜色
- (void)makeBrdgeViewWithCor:(CGFloat )corner CornerColor:(UIColor *)cornerColor;

@end
