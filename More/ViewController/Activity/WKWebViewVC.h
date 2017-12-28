//
//  WKWebViewVC.h
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/26.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWebViewVC : UIViewController
@property (nonatomic, copy) NSString *urlName;//头部名称
@property (nonatomic, copy) NSString *strUrl;//跳转路径
/** token,如不传则不会设置请求头 */
@property (nonatomic, copy) NSString *token;
/** 加载网页地址 */
@property (nonatomic, copy) NSString *urlString;
/** 加载HTMLString */
@property (nonatomic, copy) NSString *HTMLString;

@end
