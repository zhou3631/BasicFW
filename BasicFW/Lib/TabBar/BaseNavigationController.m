//
//  BaseNavigationController.m
//  XianJinDai
//
//  Created by xxlc on 2017/10/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+YFExtension.h"


@interface BaseNavigationController ()
@property (nonatomic ,assign)NSInteger isRoot;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavibationBar];
}
//拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImage:@"Back-Arrow" highlightedImg:nil target:self action:@selector(popViewController) isLeft:YES];
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //push的时候禁止手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - private
- (void)setupNavibationBar{
    [self.navigationBar setBarTintColor:White];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    // pop的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popViewControllerAnimated:animated];
}


- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    
    // pop的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}
/**
 返回
 */
- (void)popViewController{
    
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
