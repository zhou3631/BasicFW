//
//  AFAppDotNetAPIClient.h
//  YFNetWorkIng
//
//  Created by xxlc on 2017/12/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
