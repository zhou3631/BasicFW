//
//  ApiManager.m
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager

+ (void)getProvinceInfo:(CallBack)block{
    [YFNetManager GET:ProvinceCode parameters:nil callBack:^(id obj, NSError *error) {
        if (obj) {//成功
            block(obj,nil);
        }
        else{//失败
            block(nil,obj);
        }
    }];
}
//post请求
+ (void)postProvinceInfo:(CallBack)block muDic:(NSMutableDictionary *)mudic{
    NSLog(@"mudic===%@",mudic);
    [YFNetManager POST:ProvinceCode parameters:nil callBack:^(id obj, NSError *error) {
        if (obj) {//成功
            block(obj,nil);
        }
        else{//失败
            block(nil,obj);
        }
    }];
}


@end
