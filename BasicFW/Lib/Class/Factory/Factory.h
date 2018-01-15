//
//  Factory.h
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

/** 左边的按钮 */
+ (UIButton *)addLeftbottonToVC:(UIViewController *)vc;
/** 右边的文字按钮 */
+ (UIButton *)addRightbottonToVC:(UIViewController *)vc andrightStr:(NSString *)rightStr;
/** 判断手机号码格式是否正确 */
+ (BOOL)valiMobile:(NSString *)mobile;
//时间戳转换
+ (NSString *)stdTimeyyyyMMddFromNumer:(NSNumber *)num andtag:(NSInteger)tag;
//时间戳转换周
+ (NSString *)translateWeekDayWithStr:(NSString *)dateStr;
//银行卡正则校验
+ (BOOL)IsBankCard:(NSString *)cardNumber;
//校验身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;
//带逗号的金额处理
+ (NSString *)exchangeStrWithNumber:(NSNumber *)number;
+ (NSString *)countNumAndChangeformat:(NSString *)num;
+ (NSString *)countNumAndChange:(NSString *)num;

@end
