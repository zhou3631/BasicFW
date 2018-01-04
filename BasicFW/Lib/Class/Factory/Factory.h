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


@end
