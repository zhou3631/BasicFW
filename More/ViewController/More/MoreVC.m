//
//  MoreVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/12.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "MoreVC.h"
#import "WKWebViewVC.h"
#import "ShufflingVC.h"
#import "ActivityCenterVC.h"



@interface MoreVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *cellStr = @"FW";

@implementation MoreVC

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
    return 3;
}
#pragma mark -cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    NSArray *array = @[@"UIWebView",@"WkWebView",@"其它"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
#pragma mark -didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        ShufflingVC *shuff = [ShufflingVC new];
        [self.navigationController pushViewController:shuff animated:YES];
    }else{
        //    WKWebViewVC *headerVC = [WKWebViewVC new];
        ActivityCenterVC *headerVC = [ActivityCenterVC new];
        //    headerVC.urlString = @"https://www.baidu.com";
        //    headerVC.HTMLString = @"1";
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
