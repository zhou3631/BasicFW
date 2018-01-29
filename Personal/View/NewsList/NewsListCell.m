//
//  NewsListCell.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/29.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "NewsListCell.h"

@implementation NewsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self creatView];
    }
    return self;
}
/**
 布局
 */
- (void)creatView{
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.newsLabel];
    [self.contentView addSubview:self.timeLael];
    //图片
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30*m6Scale);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(90*m6Scale, 90*m6Scale));
    }];
    //新闻
    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageview.mas_right).offset(30*m6Scale);
        make.top.equalTo(self.contentView.mas_top).offset(30*m6Scale);
        make.width.mas_equalTo(@(500*m6Scale));
    }];
    //时间
    [self.timeLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageview.mas_right).offset(30*m6Scale);
        make.top.equalTo(_newsLabel.mas_bottom).offset(10*m6Scale);
    }];
}
#pragma mark -imageview
- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [UIImageView new];
//        _imageview.image = [UIImage imageNamed:@"社保查询"];
        [_imageview downloadImage:@"http://img.qdaily.com/article/article_show/20161110122926LJBdCEmQtRVzhGji.png?imageMogr2/auto-orient/thumbnail/!640x380r/gravity/Center/crop/640x380/quality/85/format/jpg/ignore-error/1" placeholder:@"guide3"];
    }
    return _imageview;
}
#pragma mark -newsLabel
- (UILabel *)newsLabel{
    if (!_newsLabel) {
        _newsLabel = [UILabel new];
        _newsLabel.text = @"什么是社保?";
        _newsLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _newsLabel.font = [UIFont systemFontOfSize:30*m6Scale];
    }
    return _newsLabel;
}
#pragma mark -newsLabel
- (UILabel *)timeLael{
    if (!_timeLael) {
        _timeLael = [UILabel new];
        _timeLael.text = @"2017-04-25";
        _timeLael.textColor = [UIColor grayColor];
        _timeLael.font = [UIFont systemFontOfSize:25*m6Scale];
    }
    return _timeLael;
}

//- (void)cellForModel:(NewsModel *)model withIndexPath:(NSIndexPath *)indexPath{
//    //    NSLog(@"%@",model.newsTitle);
//    _newsLabel.text = model.newsTitle;//新闻标题
//    _timeLael.text = model.addtime;//新闻添加时间
//    _imageview.image = [UIImage imageNamed:@"社保查询"];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
