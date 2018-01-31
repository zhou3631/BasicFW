//
//  PersonalVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/12.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "PersonalVC.h"
#import "HeaderImageVC.h"
#import "NewsListVC.h"
#import "FeedBackVC.h"



@interface PersonalVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *cellStr = @"FW";

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [self.view addSubview:self.tableView];
    
}
#pragma mark -tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 0;
    }
    return _tableView;
}
#pragma mark -numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
#pragma mark -cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    NSArray *array = @[@"头像处理",@"版本检测",@"缓存处理",@"新闻列表",@"意见反馈"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
#pragma mark -didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {//新闻列表
        NewsListVC *newsList = [NewsListVC new];
        [self.navigationController pushViewController:newsList animated:YES];
    }else if (indexPath.row == 4){//意见反馈
        FeedBackVC *feedBack = [FeedBackVC new];
        [self.navigationController pushViewController:feedBack animated:YES];
    }else{//头像
        HeaderImageVC *headerVC = [HeaderImageVC new];
        headerVC.typeTag = indexPath.row;
        [self.navigationController pushViewController:headerVC animated:YES];
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
