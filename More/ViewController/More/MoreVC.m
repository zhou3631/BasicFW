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
#import "GesturesVC.h"
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
    //监听网络
    [YFNetManager noticeNetworkStatusBlock:^(NetWorkStatus status) {
        NSLog(@"status===%lu",(unsigned long)status);
        [TopAlertManager showAlertWithType:TopAlertTypeMessage title:@"网络有变化了！"];
    }];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic setValue:@"aaaa" forKey:@"cloue"];
    [ApiManager postProvinceInfo:^(id obj, NSError *error) {
        
    } muDic:mudic];
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
    return 6;
}
#pragma mark -cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    NSArray *array = @[@"UIWebView",@"WkWebView",@"其它",@"打电话功能",@"手势密码",@"指纹密码"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
#pragma mark -didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        ShufflingVC *shuff = [ShufflingVC new];
        [self.navigationController pushViewController:shuff animated:YES];
    }else if (indexPath.row == 3){
        NSString *clip = @"客服时间:9:00-17:30\n400-0571-909";
        //客服电话
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"客服电话" message:clip preferredStyle:UIAlertControllerStyleAlert];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:clip];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36 * m6Scale] range:NSMakeRange(clip.length - 12, 12)];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26 * m6Scale] range:NSMakeRange(0, clip.length - 12)];
        //        if ([alert valueForKey:@"attributedMessage"]) {
        
        [alert setValue:attStr forKey:@"attributedMessage"];
        //        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *str = @"tel://400-0571-909";
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 4){
        GesturesVC *gestures = [GesturesVC new];
        [self.navigationController pushViewController:gestures animated:YES];
    }else if (indexPath.row == 5){
        
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
