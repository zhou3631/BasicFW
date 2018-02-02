//
//  PlaceholderTextView.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/31.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left = 5,top = 2,hegiht = 60*m6Scale;
    
    self.placeholderColor = [UIColor lightGrayColor];
    self.PlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top,kScreenWidth, hegiht)];
    self.PlaceholderLabel.textColor = self.placeholderColor;
    [self addSubview:self.PlaceholderLabel];
    self.PlaceholderLabel.text = self.placeholder;
    
}

/**
 水印字体大小
 */
- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    self.PlaceholderLabel.font = self.placeholderFont?self.placeholderFont:[UIFont systemFontOfSize:26
                                                                            *m6Scale];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden = YES;
    }
    else
        self.PlaceholderLabel.text = placeholder;
    _placeholder = placeholder;
}

- (void)DidChange:(NSNotification*)noti
{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden = YES;
    }
    
    if (self.text.length > 0) {
        self.PlaceholderLabel.hidden = YES;
    }
    else{
        self.PlaceholderLabel.hidden = NO;
    }
}

@end
