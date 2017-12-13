//
//  API.h
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/11.
//  Copyright © 2017年 zyy. All rights reserved.
//

#ifndef API_h
#define API_h

#import "Masonry.h"//约束

/*
 1 正式
 0 测试服务器地址
 */
#if 0
#define Localhost @"https://mobile.hcjinfu.com"

#else
#define Localhost @"http://124.90.42.54:7000" //(测试服)

#endif
/**
 *  如果不需要log,把1改成0
 */
#define  myTest  1
#if myTest

#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil
#endif


#endif /* API_h */
