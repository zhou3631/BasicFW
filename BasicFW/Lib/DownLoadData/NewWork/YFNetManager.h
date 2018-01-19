//
//  YFNetManager.h
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
typedef NS_ENUM(NSUInteger,NetWorkStatus){
    /*未知网络*/
    NetWorkStatusUnknown    = 0,
    /*没有网络*/
    NetWorkStatusNotReachable,
    /*3G/4G网络*/
    NetWorkStatusReachableViaWWAN,
    /*WiFi网络*/
    NetWorkStatusReachableViaWiFi
};
/**
 请求回调

 @param obj 结果
 @param error 失败
 */
typedef void (^RequestCallBack)(id obj, NSError *error);

typedef void (^NetWorkStatusBlock)(NetWorkStatus status);

@interface YFNetManager : NSObject

/**
 POST请求

 @param url url地址
 @param parameters 请求参数
 @param block 回调
 */
+ (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
    callBack:(RequestCallBack)block;

/**
 GET请求

 @param url url地址
 @param parameters 请求参数
 @param block 回调
 */
+ (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
   callBack:(RequestCallBack)block;

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
          imageData:(NSArray *)imageData
               name:(NSString *)name
           mimeType:(NSString *)mineType
           callBack:(RequestCallBack)block;

/**
 监测网络状态

 @param networkStatus 实时获取网络状态
 */
+ (void)noticeNetworkStatusBlock:(NetWorkStatusBlock)networkStatus;
@end
