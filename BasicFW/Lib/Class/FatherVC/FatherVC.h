//
//  父子控制器
//  CityJinFu
//
//  Created by mic on 2017/6/8.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FatherVC : UIViewController

-(instancetype)initWithSubViewControllers:(NSArray *)subViewControllers;

@property(nonatomic,copy)UIColor *btnTextNomalColor;
@property(nonatomic,copy)UIColor *btnTextSeletedColor;
@property(nonatomic,copy)UIColor *sliderColor;
@property(nonatomic,copy)UIColor *topBarColor;
@property (nonatomic, weak) UIScrollView *contentView;

@end
