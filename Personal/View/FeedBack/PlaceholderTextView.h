//
//  PlaceholderTextView.h
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/31.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UILabel *PlaceholderLabel;


@end
