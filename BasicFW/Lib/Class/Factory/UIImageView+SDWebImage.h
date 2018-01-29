//
//  UIImageView+SDWebImage.h
//  好奇心
//
//  Created by 党玉华 on 2017/10/9.
//  Copyright © 2017年 winner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName;

@end
