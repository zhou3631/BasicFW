//
//  WKWebViewVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/26.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"


@interface WKWebViewVC ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate, WKScriptMessageHandler>
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
/** WKWebView */
@property (nonatomic, strong) WKWebView *wkWebView;
/** 网页提供方 */
@property (nonatomic, strong) UILabel *supportLabel;
@property (nonatomic, assign) NSUInteger loadCount;
/** H5交互 **/
@property WebViewJavascriptBridge* bridge;


@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;//防止延展到导航和控制器下面
    self.supportLabel.hidden = NO;
    self.progressView.hidden = NO;
    
    [self.view insertSubview:self.wkWebView belowSubview:self.progressView];
    [self loadWebView];//加载链接
    [self configBackItem];//返回按钮
    //右边导航按钮
    UIButton *rightBtn = [Factory addRightbottonToVC:self andrightStr:@"OC传给JS"];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
//右边导航按钮
- (void)rightBtn:(UIButton *)sender{
    NSString *scriptString = [NSString stringWithFormat:@"%@('%@')",@"setValue",@"123456789"];
    [self.wkWebView evaluateJavaScript:scriptString completionHandler:^(id _Nullable object, NSError * _Nullable error) {
        NSLog(@"obj--%@",object);
    }];
}
#pragma mark -wkWebView
- (WKWebView *)wkWebView{
    [self interactionWithH5];
    if (!_wkWebView) {
//        //屏幕适配
//        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//
//        [wkUController addUserScript:wkUScript];
//
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//
//        wkWebConfig.userContentController = wkUController;
//        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:wkWebConfig];

        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wkWebView.backgroundColor = [UIColor clearColor];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.delegate = self;
        

    }
    return _wkWebView;
}

/**
 加载链接
 */
- (void)loadWebView{
    
    //! 解决iOS9.2以上黑边问题
    _wkWebView.opaque = NO;
    /*! 关闭多点触控 */
    _wkWebView.multipleTouchEnabled = YES;
    
    //添加进度条
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    if (self.HTMLString != nil) {//本地HTML
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"WKWebViewText" withExtension:@"html"];
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:path]];
//        [_wkWebView loadHTMLString:self.HTMLString baseURL:nil];
    }else{//加载链接
        NSString *encodeStr=[_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodeStr]];

        if (![self.token isEqualToString:@""] && ![self.token isKindOfClass:[NSNull class]] && self.token != nil) {
            //添加请求头
            NSMutableURLRequest *mutableRequest = [request mutableCopy];
            [mutableRequest setValue:self.token forHTTPHeaderField:@"token"];
            request = [mutableRequest copy];
        }
        [_wkWebView loadRequest:request];
    }
}

/**
 和H5进行交互
 */
- (void)interactionWithH5{
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    //初始化偏好设置属性：preferences
    config.preferences = [WKPreferences new];
    //The minimum font size in points default is 0;
    config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    //通过JS与webView内容交互
    config.userContentController = [WKUserContentController new];
    
    //注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"senderModel"];
    
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
 返回
 */
- (void)backBtnAction:(UIButton *)sender{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
        if (self.navigationItem.leftBarButtonItems.count == 1) {
            [self configCloseItem];//二级页面的快速关闭
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 二级页面的快速关闭
 */
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
#pragma mark - 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"%f",newprogress);
        if (newprogress < 1.0) {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }else{
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }
    }
}
#pragma mark - WKNavigationDelegate 【该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。】
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"didCommitNavigation");
}
#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    self.navigationItem.title = webView.title;
    self.supportLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供\n%@提供技术支持",webView.URL.host,Support];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //获取内容高度
    //        CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    //
    //        NSLog(@"html 的高度：%f", height);
}
#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    NSLog(@"didFailProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
/*! 页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）*/
#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"重定向");
}
#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
#pragma mark 在发送请求之前，决定是否跳转，如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    if ([webView.URL.absoluteString hasPrefix:@"http://www.baidu.com"])
//    {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }
//    else
//    {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    if(webView == self.wkWebView) {
        NSURL *URL = navigationAction.request.URL;
        ///加载失败
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        [NSURLConnection sendSynchronousRequest:navigationAction.request returningResponse:&response error:&error];
        ///加载的本地URL(加载本地url的时候成功是不会出现statusCode状态)
        if (([response.URL.absoluteString rangeOfString:@"file:"].location == NSNotFound) && ([response.URL.absoluteString rangeOfString:@"about:blank"].location == NSNotFound) && response.statusCode != 200) {
            //状态码不是200就是失败  空白页面不算失败
            decisionHandler(WKNavigationActionPolicyCancel);
            return ;
        }
        
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
                //表示webview新开启一个页面
                [_wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [_wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark 针对于web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。下面只举了警告框的例子。
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"000----%@",message);
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"9999----%@",message);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message:----%@",message);
    
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
    if (!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        progressView.tintColor = RGBA(80, 140, 237, 1);
        progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}
#pragma mark -supportLabel
- (UILabel *)supportLabel{
    if (!_supportLabel) {
        _supportLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 2 * 50, 50)];
        //网页来源提示居中
        CGPoint center = _supportLabel.center;
        center.x = self.view.frame.size.width / 2;
        _supportLabel.center = center;
        _supportLabel.font = [UIFont systemFontOfSize:12];
        _supportLabel.textAlignment = NSTextAlignmentCenter;
        _supportLabel.textColor = [UIColor whiteColor];
        _supportLabel.numberOfLines = 0;
        [self.view sendSubviewToBack:self.supportLabel];
        [self.view addSubview:self.supportLabel];
    }
    return _supportLabel;
}
#pragma mark 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    // 接口的作用是打开新窗口委托
//    [self createNewWebViewWithURL:webView.URL.absoluteString config:configuration];
//    return _wkWebView2;
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
//
//- (void)createNewWebViewWithURL:(NSString *)url config:(WKWebViewConfiguration *)configuration
//{
//    _wkWebView2 = [[WKWebView alloc] initWithFrame:self.wkWebView.frame configuration:configuration];
//    [_wkWebView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//}
#pragma mark - External App Support
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    /*
     若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
     NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
     return ![validSchemes containsObject:URL.scheme];
     */
    
    return !URL;
}
#pragma mark - ***** dealloc 取消监听
- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
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
