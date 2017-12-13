//
//  MBProgressHUD+YFHud.m
//  XianJinDai
//
//  Created by xxlc on 2017/10/19.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "MBProgressHUD+YFHud.h"

@implementation MBProgressHUD (YFHud)
+ (void)YF_showAlert:(NSString *)text{
    // 防止在非主线程中调用此方法,会报错
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 弹出新的提示之前,先把旧的隐藏掉
        UIView *view = [UIApplication sharedApplication].delegate.window;
        [MBProgressHUD hideHUDForView:view animated:YES];
        MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        progressHUD.mode = MBProgressHUDModeText;
        progressHUD.label.text = text;
        //progressHUD.color = BAKit_Color_Orange;
        
        [progressHUD hideAnimated:YES afterDelay:1.5];
    });
}
@end
