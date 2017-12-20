//
//  AppDelegate.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/8.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "GuidePageVC.h"


@interface AppDelegate ()<XHLaunchAdDelegate>
@property (nonatomic, strong) MainTabBarController *mainTabVC;//主控制器

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //添加主控制器
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _mainTabVC = [[MainTabBarController alloc]init];
    self.window.backgroundColor = BackGroundColor;
    [self.window makeKeyAndVisible];
//    判断是否第一次进入app
    if ([defaults objectForKey:@"firstLogin"]) {
        self.window.rootViewController = _mainTabVC;
    }else {
        GuidePageVC *guideVC = [[GuidePageVC alloc] init];
        self.window.rootViewController = guideVC;
    }
    //广告页
    [self Lanuch];
    
    return YES;
}
/**
 *  引导页到主页
 */
- (void)qieHuan {
    self.window.rootViewController = _mainTabVC;
    UserDefaults(@"YES", @"firstLogin");
}
//广告页包含正常图片和gif
- (void)Lanuch{
    //1.使用默认配置初始化
//    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
//    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
//    //配置广告数据
//    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
//    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = @"guide1";
//    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//    imageAdconfiguration.openModel = @"http://www.it7090.com";
//    //显示图片开屏广告
//    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    /*------------------------------------------------------**/
    //2.自定义配置初始化
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-150);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"guide1@2x.png";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //网络图片缓存机制(只对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
//    [XHLaunchAd setWaitDataDuration:3];//请求广告URL前,必须设置,否则会先进入window的RootVC
    
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = ...
    //服务器请求的弹屏图片
//    [DownLoadData postActivityScreen:^(id obj, NSError *error) {
//        if(error){
//
//        }else{
//            NSString *picturePath = [NSString stringWithFormat:@"%@", obj[@"picturePath"]];
//            if (picturePath == nil || [picturePath isEqualToString:@""]) {
//
//
//            }else {
//                [defaults setObject:obj[@"pictureName"] forKey:@"pictureName"];
//                [defaults setObject:obj[@"pictureUrl"] forKey:@"pictureUrl"];
//                //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//                imageAdconfiguration.imageNameOrURLString = obj[@"picturePath"];
//                //广告点击打开链接
//                imageAdconfiguration.openURLString = obj[@"pictureUrl"];
//                //显示图片开屏广告
//                [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//            }
//        }
//    }];
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
/**
 点击广告图事件
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    NSLog(@"点击了");
}
/**
 广告加载完事件
 */
- (void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    NSLog(@"完成了。。。");
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
