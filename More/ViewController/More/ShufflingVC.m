//
//  ShufflingVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/5.
//  Copyright © 2018年 zyy. All rights reserved.
//  参考GitHub：https://github.com/kingsic/SGAdvertScrollView

#import "ShufflingVC.h"

@interface ShufflingVC ()<SGAdvertScrollViewDelegate>
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;



@end

@implementation ShufflingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"轮播"];
    [self createView];
}

/**
 创建布局
 */
- (void)createView{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _firstView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_firstView];
    //公告
    SGAdvertScrollView *advertScrollView = [[SGAdvertScrollView alloc] init];
    advertScrollView.backgroundColor = BackGroundColor;
    advertScrollView.frame = CGRectMake(0, 50, kScreenWidth, 100*m6Scale);
    advertScrollView.titles = @[@"京东、天猫等 app 首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理", @"建议在 github 上下载"];
    advertScrollView.titleColor = [UIColor redColor];
    advertScrollView.delegate = self;
    advertScrollView.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:advertScrollView];
    
//    // 例二
//    _advertScrollView.signImages = @[@"hot", @"", @"activity"];
//    _advertScrollView.titles = @[@"京东、天猫等 app 首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理", @"建议在 github 上下载"];
//
//
//    // center
//    _advertScrollViewCenter.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//    _advertScrollViewCenter.scrollTimeInterval = 5;
//    _advertScrollViewCenter.titles = @[@"京东、天猫等 app 首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理", @"建议在 github 上下载"];
//    _advertScrollViewCenter.titleFont = [UIFont systemFontOfSize:14];
//    _advertScrollViewCenter.delegate = self;
//
//
//    // 例四
//    NSArray *topTitleArr = @[@"聚惠女王节，香米更低价满150减10", @"HTC新品首发，预约送大礼包", @"“挑食”进口生鲜，满199减20"];
//    NSArray *signImageArr = @[@"hot", @"", @"activity"];
//    NSArray *bottomTitleArr = @[@"满150减10+满79减5", @"12期免息＋免费试用", @"领券满199减20+进口直达"];
//    _advertScrollView2.advertScrollViewStyle = SGAdvertScrollViewStyleMore;
//    _advertScrollView2.topTitles = topTitleArr;
//    _advertScrollView2.bottomSignImages = signImageArr;
//    _advertScrollView2.bottomTitles = bottomTitleArr;
//    _advertScrollView2.bottomTitleColor = [UIColor redColor];
//
//
//    // bottom
//    _advertScrollViewBottom.advertScrollViewStyle = SGAdvertScrollViewStyleMore;
//    _advertScrollViewBottom.topSignImages = @[@"dot", @"dot", @"dot"];
//    _advertScrollViewBottom.topTitles = @[@"聚惠女王节，香米更低价满150减10", @"HTC新品首发，预约送大礼包", @"“挑食”进口生鲜，满199减20"];
//    _advertScrollViewBottom.bottomSignImages = @[@"dot", @"dot", @"dot"];
//    _advertScrollViewBottom.bottomTitles = @[@"满150减10+满79减5", @"12期免息＋免费试用", @"领券满199减20+进口直达"];
    
    
}
/// 代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
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
