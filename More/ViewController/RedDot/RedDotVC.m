//
//  RedDotVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/25.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "RedDotVC.h"
#import "UIView+RedDot.h"


@interface RedDotVC ()
@property (nonatomic, strong) UIButton *buttonView;


@end

@implementation RedDotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"小红点"];
    [self createView];
}

/**
 布局
 */
- (void)createView{
    _buttonView=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonView setFrame:CGRectMake(40, 180, 50, 40)];
//    _buttonView.backgroundColor = [UIColor lightGrayColor];
    [_buttonView setImage:[UIImage imageNamed:@"artical_detail_icon_comment_disabled"] forState:UIControlStateNormal];
    //有内容的小红点
//    [_buttonView  makeBadgeText:@"99" textColor:[UIColor whiteColor] backColor:[UIColor redColor] Font:[UIFont systemFontOfSize:9]];
    //没有内容的小红点
    [_buttonView makeRedBadge:3.0 color:[UIColor redColor]];
    
    [_buttonView addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonView];
}
- (void)button:(UIButton *)sender{
    [_buttonView removeBadgeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
