//
//  FingerprintVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/22.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "FingerprintVC.h"

@interface FingerprintVC ()

@end

@implementation FingerprintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"指纹密码"];
    self.view.backgroundColor = BackGroundColor;
    [self fingerChanged];//指纹密码
}

/**
 指纹密码
 */
- (void)fingerChanged{
    LAContext *clip = [[LAContext alloc] init];
    clip.localizedFallbackTitle = @"使用手势密码";
    NSError *error = nil;
    NSString *hihihihi = @"使用指纹密码";
//    if (self.changeTag == 1) {
//        hihihihi = @"验证指纹密码";
//    }else{
//        hihihihi = @"使用指纹密码";
//    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //TouchID是否存在
    if ([clip canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //TouchID开始运作
        [clip evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:hihihihi reply:^(BOOL succes, NSError *error)
         {
             
             if (succes) {
                 //验证通过
                 NSLog(@"验证通过");
                 NSString *fingerStr;
                 fingerStr = @"YES";
                 //储存指纹密码
                 [user setObject:fingerStr forKey:@"fingerSwitch"];
                 [user synchronize];
                 //将删除本地手势密码记录
                 [user removeObjectForKey:@"gestureLock"];
                 [user synchronize];
                 
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"指纹密码设置成功" preferredStyle:UIAlertControllerStyleAlert];
                 
                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     
                 }]];
                 
                 [self presentViewController:alert animated:YES completion:nil];
             }else{
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"指纹密码验证失败" preferredStyle:UIAlertControllerStyleAlert];
                 
                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                     
                 }]];
             }
         }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备尚不支持TouchID或您尚未开启设备的TouchID，请前往系统设置开启并设置TouchID" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        //没有开启TouchID设备自行解决
    }
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
