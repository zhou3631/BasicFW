//
//  GesturesVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/17.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "GesturesVC.h"
#import "LockView.h"


@interface GesturesVC ()

@end

@implementation GesturesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"手势密码"];
    //左边按钮
    UIButton *leftButton = [Factory addLeftbottonToVC:self];//左边的按钮
    [leftButton addTarget:self action:@selector(onClickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [self createView];//布局
    
    
}
/**
 *  返回
 */
- (void)onClickLeftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 创建布局
 */
- (void)createView{
    LockView *lockView = [[LockView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    lockView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lockView];
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
