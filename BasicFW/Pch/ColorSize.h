//
//  ColorSize.h
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/11.
//  Copyright © 2017年 zyy. All rights reserved.
//

#ifndef ColorSize_h
#define ColorSize_h

/**----------------------------Color-------------------------*/
//16进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//默认透明度的RGB
#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green: g / 255.0 blue: b / 255.0 alpha:1.0]
//自定义透明度的RGB
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 1.0]
//背景颜色
#define BackGroundColor RGBA(245, 245, 245,1.0)
//黑色
#define Black RGB(51, 51, 51)
//白色
#define White RGB(255, 255, 255)
//灰色
#define GrayColor RGB(153, 153, 153)
//tabbar字体颜色
#define K_TitleColor RGB(51, 51, 51)
/**
 *  导航栏颜色
 */
#define navigationColor RGBA(0, 175, 240,1.0)
//导航上分段选择颜色
#define SegmentColor RGBA(253, 182, 21,1.0)
/**
 tableview分割线的颜色
 */
#define SeparatorColor RGBA(227, 226, 226,1.0)






/**----------------------------Size--------------------------*/
/**
 适配iPhoneX
 */
#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (KStatusBarHeight + kNavBarHeight)
//#pragma mark === 字体大小
#define K_TitleSmallFont 26
#define K_EightFont 28
#define K_TitleBigFont 30
//导航相关的高度设置
#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 260
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

/**
 *  屏幕尺寸宽和高
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/**
 *  比例系数适配
 */
#define m6Scale               kScreenWidth/750.0





#endif /* ColorSize_h */
