//
//  HomeVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/12.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;//轮播图


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-64, 0, 0, 0);
    [self.tableView addSubview:self.cycleScrollView];
    [self.view addSubview:self.tableView];
    //设置导航透明度
    [self wr_setNavBarBackgroundAlpha:0];
    
}
#pragma mark -tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //cell之间有间隔是需要打开
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}
/**
 轮播图
 */
- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        NSArray *localImages = @[@"localImg10.jpg", @"localImg10.jpg", @"localImg10.jpg", @"localImg10.jpg", @"localImg10.jpg"];
        //        NSArray *descs = @[@"韩国防部回应停止部署萨德:遵照最高统帅指导方针",
        //                           @"勒索病毒攻击再次爆发 国内校园网大面积感染",
        //                           @"Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
        //                           @"《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
        //                           @"阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, kScreenWidth, IMAGE_HEIGHT) imageNamesGroup:localImages];//本地数据
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, kScreenWidth, IMAGE_HEIGHT) delegate:self placeholderImage:@"localImg6"];//服务器数据轮播图滚动，带有占位图
        _cycleScrollView.pageDotColor = [UIColor grayColor];
        _cycleScrollView.currentPageDotColor = [UIColor orangeColor];
        //        _advView.titlesGroup = descs;
        //        _advView.titleLabelHeight = IMAGE_HEIGHT * 0.25;
        //        _advView.titleLabelTextColor = [UIColor whiteColor];
        //        _advView.titleLabelTextFont = [UIFont systemFontOfSize:18];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _cycleScrollView;
}
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
#pragma mark -cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*m6Scale;
}
#pragma mark -didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = MainViewColor;
//    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
//    vc.title = str;
//    [self.navigationController pushViewController:vc animated:YES];
}
/**
 导航滑动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
    }
    
    //限制下拉的距离
    if(offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
    
    // 改变图片框的大小 (上滑的时候不改变)
    // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < -IMAGE_HEIGHT)
    {
        self.cycleScrollView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY);
    }
}
/**
 bunner点击事件
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
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
