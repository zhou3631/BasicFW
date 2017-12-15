//
//  GuidePageVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/15.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "GuidePageVC.h"

@interface GuidePageVC ()
@property (nonatomic, strong) UIPageControl *pageControl;//小白点
@property (nonatomic, strong) UIScrollView *scrollView;//广告栏
@property (nonatomic, assign) int counts;//几张引导页


@end

@implementation GuidePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _counts = GuideCount;//引导页张数
    
    
}
/**
 引导页图片
 */
- (void)guideImage{
    
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
