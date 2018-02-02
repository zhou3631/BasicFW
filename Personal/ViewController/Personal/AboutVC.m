//
//  AboutVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/2/1.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *cellStr = @"FW";

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"关于我们"];
    [self.view addSubview:self.tableView];
    
}
#pragma mark -tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorColor = SeparatorColor;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark -numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark -cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section) {
        cell.textLabel.text = @"平台介绍";
    }else{
        cell.textLabel.text = @"投诉与意见";
    }
    return cell;
}
#pragma mark -didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark -头部版本记录
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = BackGroundColor;
    if (section) {
        return nil;
    }else{
        UIImageView *aboutImage = [[UIImageView alloc] init];
//        aboutImage.image = [UIImage imageNamed:@""];
        aboutImage.backgroundColor = [UIColor redColor];
        [headerView addSubview:aboutImage];
        [aboutImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView.mas_centerX);
            make.centerY.equalTo(headerView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100*m6Scale, 100*m6Scale));
        }];
        //版本记录
        UILabel *versionLab = [UILabel new];
        versionLab.text = @"财高八斗 1.0";
        versionLab.font = [UIFont systemFontOfSize:30*m6Scale];
        [headerView addSubview:versionLab];
        [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView.mas_centerX);
            make.top.equalTo(aboutImage.mas_bottom).offset(10*m6Scale);
        }];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*m6Scale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 0.1;
    }else{
        return 200*m6Scale;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
