//
//  ApiManager.h
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFNetManager.h"
static NSString *ProvinceCode = @"/api/4/version/ios/2.3.0";//

typedef void (^CallBack)(id obj, NSError *error);

@interface ApiManager : NSObject

//get请求
+ (void)getProvinceInfo:(CallBack)block;
//post请求
+ (void)postProvinceInfo:(CallBack)block muDic:(NSMutableDictionary *)mudic;


@end
