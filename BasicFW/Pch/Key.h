//
//  Key.h
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/11.
//  Copyright © 2017年 zyy. All rights reserved.
//

#ifndef Key_h
#define Key_h

//存储到本地
#define UserDefaults(Object, Key)\
[[NSUserDefaults standardUserDefaults] setObject:Object forKey:Key];\

#define defaults [NSUserDefaults standardUserDefaults]
//block里面的引用
#define Weakify(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//引导页的张数
#define GuideCount 4

#endif /* Key_h */
