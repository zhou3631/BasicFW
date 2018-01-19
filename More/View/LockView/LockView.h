//
//  LockView.h
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/18.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define lockBtnCount 9
#define columeCount 3
#define lineCount 3

@interface LockView : UIView

@property (nonatomic, strong) NSMutableArray *buttons;//绘制的点存入
@property (nonatomic, strong) NSMutableArray *btnArray;


@end
