//
//  TopAlertManager.h
//  YFNetWorkIng
//
//  Created by xxlc on 2018/1/8.
//  Copyright © 2018年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopAlert.h"
@interface TopAlertManager : NSObject
+ (void)showAlertWithType:(TopAlertType)type title:(NSString *)title;
@end
