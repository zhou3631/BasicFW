//
//  AFAppDotNetAPIClient.m
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"

static NSString *baseUrl = @"https://news-at.zhihu.com";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient{
    
    static AFAppDotNetAPIClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedClient = [[AFAppDotNetAPIClient alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        //接收类型
        sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", nil];
        //超时时间
        sharedClient.requestSerializer.timeoutInterval = 20.0f;
    });
    return sharedClient;
}

@end
