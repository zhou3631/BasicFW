//
//  RedDotLab.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/24.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "RedDotLab.h"

@interface RedDotLab (){
    CGSize m_CMinSize;             //最小大小
    NSTextAlignment m_tTextAlignment; //对齐方式
}
@property (nonatomic, strong) UIColor *m_pTextClolor;//字体颜色
@property (nonatomic, strong) UIColor *m_pBackGroundClolor;//背景颜色
@property (nonatomic, strong) UIFont  *m_pLableFont;//字体大小
@property (nonatomic, strong) UIImageView *m_pBackImageView;

@end

@implementation RedDotLab

- (instancetype)init{
    if (self = [super init]) {
        self.m_pTextClolor = [UIColor  whiteColor];
        self.m_pBackGroundClolor = [UIColor  redColor];
        self.m_pLableFont = [UIFont systemFontOfSize:10];
        m_CMinSize = CGSizeMake(10, 10);
        m_tTextAlignment = NSTextAlignmentCenter;
    }
    return self;
}
#pragma mark -内容、颜色、大小、坐标
- (void)makeBrdgeViewWithText:(NSString *)text textColor:(UIColor *)textColor   backColor:(UIColor *)backGColor textFont:(UIFont *)font tframe:(CGRect )frame{
    
    if (text.length == 0) {
        CGFloat x_margin = frame.size.width-10;
        CGFloat y_margin = frame.size.height-10;
        self.frame = CGRectMake(frame.origin.x+x_margin*0.5, frame.origin.y+y_margin*0.5, 10, 10);
    }else{
        self.frame = frame;
    }
    self.backgroundColor = backGColor;
    self.textColor = textColor;
    self.font = font;
    self.text = text;
    self.textAlignment = m_tTextAlignment;
    self.m_pTextClolor = textColor;
    self.m_pBackGroundClolor = backGColor;
    self.m_pLableFont = font;
    //创建mask层，超出的部分将不显示
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: UIRectCornerAllCorners  cornerRadii:CGSizeMake(self.frame.size.height*0.5, self.frame.size.height*0.5)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}
#pragma mark -只有颜色
- (void)makeBrdgeViewWithCor:(CGFloat )corner CornerColor:(UIColor *)cornerColor{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: UIRectCornerAllCorners  cornerRadii:CGSizeMake(corner,corner)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path =  path.CGPath;
    self.backgroundColor = cornerColor;
    self.layer.mask = maskLayer;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //根据自己的情况
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        
        return self.superview;
    }
    return [super hitTest:point withEvent:event];
}
#pragma mark sizeLableText
-(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:(NSStringDrawingUsesLineFragmentOrigin |
                                                 NSStringDrawingTruncatesLastVisibleLine)
                                     attributes:attributes
                                        context:nil].size;
    } else
    {
        textSize = [string sizeWithFont:textFont
                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:(NSStringDrawingUsesLineFragmentOrigin |
                                             NSStringDrawingTruncatesLastVisibleLine)
                                 attributes:attributes
                                    context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    
}


@end
