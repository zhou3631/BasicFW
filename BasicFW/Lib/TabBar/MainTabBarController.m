//
//  MainTabBarController.m
//  XianJinDai
//
//  Created by xxlc on 2017/10/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeVC.h"
#import "ItemListVC.h"
#import "PersonalVC.h"
#import "MoreVC.h"


@interface MainTabBarController ()
@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation MainTabBarController

- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVC];
    self.delegate = self;
    
}
/**
 添加控制器
 */
- (void)addAllChildVC{
    //首页
    HomeVC *home = [[HomeVC alloc]init];
    [self addViewController:home title:@"借款" image:@"loanItem" selectImage:@"loanItem_select"];
    //列表
    ItemListVC *itemList = [[ItemListVC alloc]init];
    [self addViewController:itemList title:@"账单" image:@"billItem" selectImage:@"billItem_select"];
    //我的
    PersonalVC *personal = [[PersonalVC alloc]init];
    [self addViewController:personal title:@"我的" image:@"personalItem" selectImage:@"personalItem_select"];
    //更多
    MoreVC *more = [[MoreVC alloc]init];
    [self addViewController:more title:@"更多" image:@"personalItem" selectImage:@"personalItem_select"];
    
}
/**
 vc

 @param viewcontroller viewcontroller
 @param title 名称
 @param imageName 图片
 @param selectImageName 点击图片
 */
- (void)addViewController:(UIViewController *)viewcontroller title:(NSString *)title image:(NSString *)imageName selectImage:(NSString *)selectImageName {
    //tabbar的文字颜色，大小
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24*m6Scale],NSForegroundColorAttributeName:GrayColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:K_TitleColor,NSFontAttributeName:[UIFont systemFontOfSize:24*m6Scale]} forState:UIControlStateSelected];
    viewcontroller.title = title;
//    viewcontroller.tabBarItem.badgeValue = @"99";//控制栏的红点
    viewcontroller.tabBarItem.image = [UIImage imageNamed:imageName];
    viewcontroller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
//    [self.itemArray addObject:viewcontroller];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:viewcontroller];
    [self addChildViewController:nav];

}
/**
 是否登录
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    //
//    UINavigationController* nav = (UINavigationController*)viewController;
//    BOOL needlogin = [nav.topViewController isKindOfClass:[PersonalCenterVC class]];
    //账单
//    BOOL billLogin = [nav.topViewController isKindOfClass:[MoreVC class]];
//    if (billLogin) {
//        if ([defaults objectForKey:@"userId"]) {
//            return YES;
//        }else{
//            //
////            LoginVC* login_vc = [[LoginVC alloc] init];
////            UINavigationController* nav_login = [[UINavigationController alloc] initWithRootViewController:login_vc];
////            [tabBarController presentViewController:nav_login animated:YES completion:^{}];
//            return NO;
//        }
//    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
