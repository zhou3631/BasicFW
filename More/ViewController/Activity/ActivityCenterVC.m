//
//  ActivityCenterVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//来源github:https://github.com/wubin123

#import "ActivityCenterVC.h"

@interface ActivityCenterVC ()<UIWebViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *supportLabel;
@property (nonatomic, assign) NSUInteger loadCount;


@end

@implementation ActivityCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;//防止延展到导航和控制器下面
    self.supportLabel.hidden = NO;
    self.progressView.hidden = NO;
    [self.view insertSubview:self.webView belowSubview:_progressView];
    [self loadWebView];
    [self configBackItem];//返回按钮
    
}

#pragma mark -webView
- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
        _webView.backgroundColor = [UIColor clearColor];
//        _webView.opaque = NO;//如果选择默认为yes，对应的uivew的alpha属性不为1时，就会有不可预料的情况出现
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        /*! 适应屏幕 */
        _webView.scalesPageToFit = YES;
        /*! 解决iOS9.2以上黑边问题 */
       _webView.opaque = NO;
        /*! 关闭多点触控 */
        _webView.multipleTouchEnabled = YES;
        /*! 加载网页中的电话号码，单击可以拨打 */
        _webView.dataDetectorTypes = YES;
        
    }
    return _webView;
}

/**
 适应屏幕
 */
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    CGSize contentSize = _webView.scrollView.contentSize;
//    CGSize viewSize = self.view.bounds.size;
//
//    float rw = viewSize.width / contentSize.width;
//    _webView.scrollView.minimumZoomScale = rw;
//    _webView.scrollView.maximumZoomScale = rw;
//    _webView.scrollView.zoomScale = rw;
//}
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
//    }
    //设置请求头
    //        NSMutableURLRequest *mutableRequest = [request mutableCopy];
    //        NSDictionary *requestHeaders = request.allHTTPHeaderFields;
    //        if (requestHeaders[@"token"]) {
    //            return YES;
    //        } else {
    ////            [mutableRequest setValue:[[NSUserDefaults standardUserDefaults]objectForKey:Token] forHTTPHeaderField:@"token"];
    ////            request = [mutableRequest copy];
    ////            [webView loadRequest:request];
    //            return NO;
    //        }
    
    return YES;
}
//请求webView
- (void)loadWebView
{
    
    
    NSString *encodeStr=[_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodeStr]];
    
    if (![self.token isEqualToString:@""] && ![self.token isKindOfClass:[NSNull class]] && self.token != nil) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        //        [mutableRequest setHTTPMethod:@"POST"];
        //        NSString *body = [NSString stringWithFormat: @"token=%@",[[NSUserDefaults standardUserDefaults]objectForKey:Token]];
        //        [mutableRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [mutableRequest setValue:self.token forHTTPHeaderField:@"token"];
        request = [mutableRequest copy];
    }
    [self.webView loadRequest:request];
//
//    NSURL *url;
//    url = [NSURL URLWithString:@"www.baidu.com"];
//
//    NSLog(@"%@",url);
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    if (data == nil) {//为空时添加暂无数据图片
//
//    }else {
    
//        //和H5交互
//        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//        context[@"scan"] = ^() {
//
//            NSArray *args = [JSContext currentArguments];
//            for (JSValue *jsVal in args) {
//                NSLog(@"%@", jsVal.toString);
//                if ([jsVal.toString containsString:@"index"]){
//
//                    //与h5做交互  要把UI提示放在主线程  否则会crash
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.navigationController popToRootViewControllerAnimated:NO];
//
//                        //在风险评估页面中，如果用户点击前去投资按钮，则需要跳转到首页中去
//                        //                       [self.navigationController popViewControllerAnimated:NO];
//                        NSNotification *notification = [[NSNotification alloc] initWithName:@"GoToHome" object:nil userInfo:nil];
//                        [[NSNotificationCenter defaultCenter] postNotification:notification];
//                    });
//                }
//            }
//        };
        
        //添加请求头
        //            NSString *body = [NSString stringWithFormat: @"userId=%@&bizType=%@", [defaults objectForKey:@"userId"],@"06"];
        //            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
        //            [request setHTTPMethod: @"POST"];
        //            [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
        //            [self.webView loadRequest: request];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
//        [self.webView loadRequest:request];
//    }
}
#pragma mark - ***** 导航栏的反回按钮
- (void)configBackItem{
    UIImage *backImage = [UIImage imageNamed:@"navigation_back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = colseItem;
}

/**
 二级返回
 */
- (void)backBtnAction:(UIButton *)sender{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        if (self.navigationItem.leftBarButtonItems.count == 1) {
            [self configCloseItem];
        }
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ***** 导航栏的关闭按钮
- (void)configCloseItem{
    UIButton *colseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [colseBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(colseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [colseBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:colseBtn];
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItem,colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
}

#pragma mark 关闭按钮点击
- (void)colseBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ***** UIWebViewDelegate
#pragma mark 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount
{
    _loadCount = loadCount;
    if (loadCount == 0)
    {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }
    else
    {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95)
        {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadCount ++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadCount --;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSURL *url = [NSURL URLWithString:currentURL];
    self.supportLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供\n%@提供技术支持",url.host,Support];
    // 获取内容高度
//    CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    
    NSLog(@"html 的高度：%@", currentURL);
    
    //    CGFloat htmlHeight;
    //    // 防止死循环
    //    if (height != htmlHeight)
    //    {
    //
    //        htmlHeight = height;
    //
    //        if (height > 0)
    //        {
    //            // 更新布局
    //            CGFloat paddingEdge = 10;
    //            [webView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //
    //                make.left.equalTo(self.view).with.offset(paddingEdge);
    //                make.right.mas_equalTo(-paddingEdge);
    //                make.top.equalTo(self.view).with.offset(paddingEdge);
    //                make.bottom.mas_equalTo(-paddingEdge);
    //
    //            }];
    //
    //            // 刷新cell高度
    ////            _viewModel.cellHeight = _viewModel.otherHeight + _viewModel.htmlHeight;
    ////            [_viewModel.refreshSubject sendNext:nil];
    //        }
    //        NSLog(@"html 的高度：%f", htmlHeight);
    //    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadCount --;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //下拉隐藏网页提供方
    scrollView.contentOffset.y >= 0 ? (_supportLabel.hidden = YES) : (_supportLabel.hidden = NO);
}

//禁止webivew放大缩小
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

#pragma mark - 懒加载  Lazy Load
- (UIProgressView *)progressView{
    if (_progressView == nil) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        progressView.tintColor = RGBA(80, 140, 237, 1);
        progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}

- (UILabel *)supportLabel{
    if (_supportLabel == nil) {
        _supportLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 2 * 50, 50)];
        //网页来源提示居中
        CGPoint center = _supportLabel.center;
        center.x = self.view.frame.size.width / 2;
        _supportLabel.center = center;
        
        _supportLabel.font = [UIFont systemFontOfSize:12];
        _supportLabel.textAlignment = NSTextAlignmentCenter;
        _supportLabel.textColor = [UIColor lightGrayColor];
        _supportLabel.numberOfLines = 0;
        [self.view sendSubviewToBack:_supportLabel];
        [self.view addSubview:_supportLabel];
    }
    return _supportLabel;
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
