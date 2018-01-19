//
//  YFNetManager.m
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "YFNetManager.h"

@implementation YFNetManager

/**
 POST请求
 
 @param url url地址
 @param parameters 请求参数
 @param block 回调
 */
+ (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
    callBack:(RequestCallBack)block{
    
    NSString *urlStr = [YFNetManager getUrlStringWith:parameters];
    NSLog(@"%@?%@",url,urlStr);
    
    [[AFAppDotNetAPIClient sharedClient]POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {//成功回调
            
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {//失败回调
            block(nil,error);
        }
    }];
}

/**
 GET请求
 
 @param url url地址
 @param parameters 请求参数
 @param block 回调
 */
+ (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
   callBack:(RequestCallBack)block{
    
    NSString *urlStr = [YFNetManager getUrlStringWith:parameters];
    NSLog(@"%@?%@",url,urlStr);
    
    [[AFAppDotNetAPIClient sharedClient]GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",responseObject);
        if (block) {//成功回调

            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {//失败回调
            block(nil,error);
        }
    }];
}

/**
 上传图片
 
 @param url url地址
 @param parameters 请求参数
 @param imageData 图片信息
 @param name 图片的key
 @param mineType 类型
 @param block 回调
 */
+ (void)upLoadImage:(NSString *)url
         parameters:(NSDictionary *)parameters
          imageData:(NSArray * )imageData
               name:(NSString *)name
           mimeType:(NSString *)mineType
           callBack:(RequestCallBack)block{
    [[AFAppDotNetAPIClient sharedClient]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<imageData.count; i++) {
            NSData *image = UIImageJPEGRepresentation([imageData objectAtIndex:i], 0.5);
            //以时间作为图片名字
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *dataStr = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dataStr];
            [formData appendPartWithFileData:image name:name fileName:fileName mimeType:mineType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}
#pragma mark ====拼接参数
/**
 拼接参数

 @param paras 参数字典
 @return 字符串
 */
+ (NSString *)getUrlStringWith:(NSDictionary *)paras{
    
    NSMutableString *log = [[NSMutableString alloc]init];
    
    [paras  enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *key_value = [NSString stringWithFormat:@"%@=%@",key,obj];
        [log appendFormat:@"%@&",key_value];
    }];
    
    return log;
}

/**
 监听网络

 @param networkStatus 获取网络状态
 */
+ (void)noticeNetworkStatusBlock:(NetWorkStatusBlock)networkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                networkStatus ? networkStatus(NetWorkStatusUnknown):nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                networkStatus ? networkStatus(NetWorkStatusNotReachable):nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                networkStatus ? networkStatus(NetWorkStatusReachableViaWWAN):nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                networkStatus ? networkStatus(NetWorkStatusReachableViaWiFi):nil;
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}
@end
