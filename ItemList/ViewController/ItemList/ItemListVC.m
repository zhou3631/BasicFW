//
//  ItemListVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/12.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ItemListVC.h"
#import "TestVC.h"
#import "FatherVC.h"


@interface ItemListVC ()
@property (nonatomic, strong) UISegmentedControl *segment;//分段选择器
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TestVC *testVC;
@property (nonatomic, strong) FatherVC *fatherVC;


@end

@implementation ItemListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    //添加子控制器
    [self addChildVC];
    //导航条上的选择条
    [self settingSegment];
    
}

/**
 添加自控制器
 */
- (void)addChildVC{
    //默认
    _testVC = [TestVC new];
    _testVC.title = @"默认";
    //类型1
    
    //类型2
    
    //类型3
    
    //数组
    NSArray *subViewControllers = @[_testVC, _testVC, _testVC,_testVC];
    _fatherVC = [[FatherVC alloc]initWithSubViewControllers:subViewControllers];
    _fatherVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:_fatherVC.view];
    [self addChildViewController:_fatherVC];
    
}

/**
 导航条上的选择条
 */
- (void)settingSegment{
    //标题
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"全部", @"预约", @"锁投"]];
    _segment.backgroundColor = SegmentColor;
    self.navigationItem.titleView = _segment;
    //宽度设置
    _segment.width = 360*m6Scale;
    
    //默认选择
    _segment.selectedSegmentIndex = 0;
    //点击事件
    [_segment addTarget:self action:@selector(segmentBtnClick:) forControlEvents:UIControlEventValueChanged];
    _segment.tintColor = UIColorFromRGB(0xffffff);
    
}
/**
 *选择条的点击事件
 */
- (void)segmentBtnClick:(UISegmentedControl *)sender{
    
    //改变点击模块的颜色
    _segment.tintColor = UIColorFromRGB(0xffffff);
    self.scrollView.contentOffset = CGPointMake(_segment.selectedSegmentIndex * self.view.width, 0);
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
