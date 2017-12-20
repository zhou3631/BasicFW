//
//  GuidePageVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/15.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "GuidePageVC.h"

@interface GuidePageVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;//小白点
@property (nonatomic, strong) UIScrollView *scrollView;//广告栏
@property (nonatomic, assign) int counts;//几张引导页


@end

@implementation GuidePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _counts = GuideCount;//引导页张数
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self guideImage];//引导页图片
    
    
}
/**
 引导页图片
 */
- (void)guideImage{
    NSArray *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
    for (int i = 0; i < _counts; i++) {
        UIImageView *pageImage = [[UIImageView alloc]init];
        CGFloat imageW = self.scrollView.frame.size.width;
        CGFloat imageH = self.scrollView.frame.size.height;
        CGFloat imageY = 0;
        pageImage.userInteractionEnabled = YES;
        //添加图片
        pageImage.image = [UIImage imageNamed:imageArray[i]];
        CGFloat imageX = i * imageW;
        pageImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        CGFloat contentW = _counts * imageW;
        self.scrollView.contentSize = CGSizeMake(contentW, 0);
        [self.scrollView addSubview:pageImage];
        if (i == _counts - 1) {//最后一张点击跳转
            UITapGestureRecognizer * singleRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];//手势
            singleRecognizer.numberOfTapsRequired = 1;
            [pageImage addGestureRecognizer:singleRecognizer];
        }
    }
}
#pragma mark -scrollview的懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
#pragma mark -pageControl的懒加载----需要自定义的话可以打开
//-(UIPageControl *)pageControl
//{
//    if (!_pageControl) {
//        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.frame.size.height-50, 100,20)];
//        _pageControl.currentPage = 0;
//        _pageControl.numberOfPages = _counts;
//        _pageControl.enabled = NO;
//        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        [_pageControl addTarget:self action:@selector(nextImage:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _pageControl;
//}
/**
 *  下一页
 */
- (void)nextImage:(UIPageControl *)sender
{
    self.pageControl.currentPage = (self.pageControl.currentPage + 1) % self.counts;
    CGFloat x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
/**
 *  滚动视图并最终停下
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}
/**
 *  引导页跳主页
 */
- (void)click:(UIGestureRecognizer *)tap
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app qieHuan];
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
