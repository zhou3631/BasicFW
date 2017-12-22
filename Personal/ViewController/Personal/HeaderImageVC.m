//
//  HeaderImageVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/21.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "HeaderImageVC.h"
#import "UpdateApp.h"

@interface HeaderImageVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) NSString *cachesStr;//缓存
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;//菊花
@property (nonatomic, strong) UIImage *userIconImage;//选中的头像图片


@end

@implementation HeaderImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    
    
}
#pragma mark -菊花旋转
- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

/**
 👮‍♀️图片
 */
- (void)headerImage{
    [self buttonAction];
}
/**
 头像处理
 */
- (void)buttonAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (isCamera) {
            
            pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerVC.delegate = self;
            pickerVC.allowsEditing = YES;
            [self presentViewController:pickerVC animated:YES completion:nil];
        }
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从本地相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.delegate = self;
        pickerVC.allowsEditing = YES;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //将照片存入沙盒
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSData *iconData;
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        
        self.userIconImage = image;
        iconData = UIImageJPEGRepresentation(image, 0.8);
        
        [user setObject:iconData forKey:@"userIcon"];
        
    }else {
        
        self.userIconImage = info[UIImagePickerControllerOriginalImage];
        iconData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.8);
        [user setObject:iconData forKey:@"userIcon"];
    }
    
    [user synchronize];
    
    // 向后台发送请求
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //    [manager.requestSerializer setValue:[user objectForKey:@"token"] forHTTPHeaderField:@"x-access-token"];
//    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[user objectForKey:@"userToken"]] forHTTPHeaderField:@"x-user-token"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    NSString *str = [NSString stringWithFormat:@"%@%@",Localhost,@"/mobile/headPortraitPictureFile"];
//    NSDictionary *param = @{@"userId":[defaults objectForKey:@"userId"]};
//
//    [manager POST:str parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:iconData name:@"file" fileName:@"icon.png" mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
    
}
//--------------------------------------------------------------
/**
 更新app
 */
- (void)updateApp{
    
    [self.indicatorView startAnimating];
    /*
    //=================根据appid检测====================1160680698 1104867082
    [UpdateApp hs_updateWithAPPID:@"1160680698" withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        if (isUpdate) {
            [self showAlertViewTitle:@"APPID检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
        }else{
            NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
        }
        [self.indicatorView stopAnimating];
        
    }];
     */
    /*
    //=================根据BundleId检测====================
    [UpdateApp hs_updateWithAPPID:nil withBundleId:@"com.yunfucloud.HCJF" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        if (isUpdate) {
            [self showAlertViewTitle:@"BundleId检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
        }else{
            NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
        }
        
        [self.indicatorView stopAnimating];
    }];
     */
    //=================自动检测====================
    [UpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        if (isUpdate) {
            [self showAlertViewTitle:@"自动检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
        }else{
            NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
        }
        
        [self.indicatorView stopAnimating];
    }];
    
}

/**
 共用提示框
 */
- (void)showAlertViewTitle:(NSString *)title subTitle:(NSString *)subTitle openUrl:(NSString *)openUrl{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            // Fallback on earlier versions
        }
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}
//--------------------------------------------------------------------
/**
 清缓存
 */
- (void)CleanCaches{
    NSLog(@"cachesStr----%@",_cachesStr);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"现有缓存:%@",self.cachesStr] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self clearCatch];//清理缓存
        NSInteger fileSize = [self getCatchSize];
        self.cachesStr = [NSString stringWithFormat:@"%.2fMB",fileSize / 1024.0 / 1024.0];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 拿到缓存文件夹
 */
- (NSInteger)getCatchSize
{
    NSInteger fileSize = 0;
    
    //拿到缓存文件夹
    NSString *catchPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //拿到缓存文件夹下的所有文件的属性
    NSArray *fileEnumerator = [[NSFileManager defaultManager] subpathsAtPath:catchPath];
    //所有的文件的名称
    for (NSString *fileName in fileEnumerator) {
        //所有文件的路径
        NSString *filePath = [catchPath stringByAppendingPathComponent:fileName];
        //所有文件的大小
        NSDictionary *attDic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //   计算大小
        fileSize += [attDic fileSize];
    }
    return fileSize;
}
/**
 清除
 */
- (void)clearCatch
{
    //拿到缓存文件夹
    NSString *catchPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //清除
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:catchPath];
    
    for ( NSString *p  in files) {
        
        NSError *error;
        
        NSString *path = [catchPath stringByAppendingPathComponent:p];
        
        if ([[ NSFileManager defaultManager ]  fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ]  removeItemAtPath :path  error :&error];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSInteger fileSize = [self getCatchSize];
    self.cachesStr = [NSString stringWithFormat:@"%.2fMB",fileSize / 1024.0 / 1024.0];
    if (_typeTag == 0) {
        [self headerImage];//头像选择
    }else if (_typeTag == 1){
        [self updateApp];//版本更新
    }else{
        [self CleanCaches];//清缓存
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
