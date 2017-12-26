//
//  ActivityCenterVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ActivityCenterVC.h"

@interface ActivityCenterVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation ActivityCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:_urlName];
    //左边按钮
    UIButton *leftButton = [Factory addLeftbottonToVC:self];//左边的按钮
    [leftButton addTarget:self action:@selector(onClickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.webView];
    [self scroll];//去除黑线
    [self loadWebView];//加载链接
    
}
/**
 *  返回
 */
- (void)onClickLeftItem
{
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];//进入webview的子页面后的返回上一级
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -webView
- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
        _webView.backgroundColor = BackGroundColor;
//        _webView.opaque = NO;//如果选择默认为yes，对应的uivew的alpha属性不为1时，就会有不可预料的情况出现
        _webView.delegate = self;
        
    }
    return _webView;
}

//取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
- (void)scroll
{
    for (UIView *_aView in [_webView subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;//上下滚动出边界时的黑色的图片
                }
            }
        }
    }
}

/**
 适应屏幕
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = _webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    _webView.scrollView.minimumZoomScale = rw;
    _webView.scrollView.maximumZoomScale = rw;
    _webView.scrollView.zoomScale = rw;
}
/**
 根据返回的URL或者scheme来判断
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [[request URL] absoluteString];
    NSLog(@"%@",url);
//    //根据返回的URL或者scheme来判断
//    if ([url containsString:@"personal"]){
//        //[self.navigationController popViewControllerAnimated:YES];
//    }else if ([url containsString:@"index"]){
//
//        [self.navigationController popToRootViewControllerAnimated:NO];
//
//        //在风险评估页面中，如果用户点击前去投资按钮，则需要跳转到首页中去
//        NSNotification *notification = [[NSNotification alloc] initWithName:@"GoToHome" object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
//
//        //[self.navigationController popToRootViewControllerAnimated:NO];
//    }
    
    return YES;
}
//请求webView
- (void)loadWebView
{
    
//    if (state == 0) {
//
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:TitleMes message:@"操作无法完成，请检查网络设置！" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
//    } else {
//
//        NSURL *url;
//
//        if (self.tag == 0) {
//
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/news/getNewsById/%@",Localhost,_newsId]];
//        }else if(_tag == 1){
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/ssDetail?taskId=%@&userId=%@",Localhost,_taskId,[defaults objectForKey:@"userId"]]];
//        }else if (_tag == 2){
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/html/socialSecurityAgreement.html",Localhost]];//社保协议
//        }else if (_tag == 3){
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/html/fundAgreement.html",Localhost]];//公积金协议
//        }else{
//            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/afDetail?taskId=%@&resultId=%@",Localhost,_taskId,_resultId]];
//        }
//        NSLog(@"%@",url);
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        if (data == nil) {
//            //(121,196)
//            _backgroundImage = [[UIView alloc]initWithFrame:CGRectMake((_webView.frame.size.width -130)/2, (_webView.frame.size.height -130)/2, 130, 130)];
//            _backgroundImage.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"无数据"]];
//            [self.webView addSubview:_backgroundImage];
//        }else {
//
//            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
//            [self.webView loadRequest:request];
//        }
//    }
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
