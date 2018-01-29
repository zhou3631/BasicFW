//
//  NewsListCell.h
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/29.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageview;//前面图片
@property (nonatomic, strong) UILabel *newsLabel;//新闻简介
@property (nonatomic, strong) UILabel *timeLael;//时间

//- (void)cellForModel:(NewsModel *)model withIndexPath:(NSIndexPath *)indexPath;

@end
