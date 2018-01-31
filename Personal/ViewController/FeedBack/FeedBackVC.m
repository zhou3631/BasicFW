//
//  FeedBackVC.m
//  BasicFW
//
//  Created by 周玉阳 on 2018/1/31.
//  Copyright © 2018年 zyy. All rights reserved.
//

#import "FeedBackVC.h"
#import "PlaceholderTextView.h"

//默认最大输入字数为 kMaxTextCount  240
#define kMaxTextCount 240

@interface FeedBackVC ()<UITextViewDelegate>
@property (nonatomic, strong) PlaceholderTextView *textView;//文本输入
@property (nonatomic, strong) UILabel *textNumberLab;//文字个数提示label
@property (nonatomic, strong) UILabel *promptLab;//问题和意见
@property (nonatomic, assign) float noteTextHeight;
@property (nonatomic, assign) float allViewHeight;


@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [TitleLabelStyle addtitleViewToVC:self withTitle:@"意见反馈"];
    //右边提交按钮
    UIButton *rightBtn = [Factory addRightbottonToVC:self andrightStr:@"提交"];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self updateViewsFrame];//界面frame
    
}
#pragma mark -textView
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]init];
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.placeholder = @"请填写不少于10个字的描述";
        [_textView setFont:[UIFont fontWithName:@"Heiti SC" size:30*m6Scale]];
        [_textView setTextColor:[UIColor blackColor]];
        _textView.delegate = self;
        _textView.font = [UIFont boldSystemFontOfSize:30*m6Scale];
    }
    return _textView;
}
#pragma mark -字数显示
- (UILabel *)textNumberLab{
    if (!_textNumberLab) {
        _textNumberLab = [[UILabel alloc]init];
        _textNumberLab.textAlignment = NSTextAlignmentRight;
        _textNumberLab.font = [UIFont boldSystemFontOfSize:24*m6Scale];
        _textNumberLab.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        _textNumberLab.backgroundColor = [UIColor whiteColor];
        _textNumberLab.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
    }
    return _textNumberLab;
}
#pragma mark -问题和意见
- (UILabel *)promptLab{
    if (!_promptLab) {
        _promptLab = [UILabel new];
        _promptLab.text = @"问题和意见";
        _promptLab.font = [UIFont systemFontOfSize:30*m6Scale];
    }
    return _promptLab;
}

/**
 界面的frame
 */
- (void)updateViewsFrame{
    [self.view addSubview:self.promptLab];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.textNumberLab];
    //问题和意见
    [_promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30*m6Scale);
        make.top.equalTo(self.view.mas_top).offset(30*m6Scale);
    }];
    //意见输入
    if (!_allViewHeight) {
        _allViewHeight = 0;
    }
    if (!_noteTextHeight) {
        _noteTextHeight = 100;
    }
    //文本编辑框
    _textView.frame = CGRectMake(30*m6Scale, 80*m6Scale, kScreenWidth - 60*m6Scale, _noteTextHeight);
    //文字个数提示Label
    _textNumberLab.frame = CGRectMake(30*m6Scale, _textView.frame.origin.y + _textView.frame.size.height - 30*m6Scale, kScreenWidth - 60*m6Scale, 30*m6Scale);
}
/**
 *  恢复原始界面布局
 */
-(void)resumeOriginalFrame{
    //文本编辑框
    _textView.frame = CGRectMake(30*m6Scale, 0, kScreenWidth - 60*m6Scale, _noteTextHeight);
    //文字个数提示Label
    _textNumberLab.frame = CGRectMake(0, _textView.frame.origin.y + _textView.frame.size.height - 30*m6Scale, kScreenWidth - 20*m6Scale, 30*m6Scale);
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"当前输入框文字个数:%ld",_textView.text.length);
    //当前输入字数
    _textNumberLab.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_textView.text.length,kMaxTextCount];
    if (_textView.text.length > kMaxTextCount) {
        _textNumberLab.textColor = [UIColor redColor];
    }else{
        _textNumberLab.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    [self textChanged];
    return YES;
}
//文本框每次输入文字都会调用  -> 更改文字个数提示框
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSLog(@"当前输入框文字个数:%ld",_textView.text.length);
    //
    _textNumberLab.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_textView.text.length,kMaxTextCount];
    if (_textView.text.length > kMaxTextCount) {
        _textNumberLab.textColor = [UIColor redColor];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"超出文字限制" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        _textNumberLab.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self textChanged];
}
/**
 *  文本高度自适应
 */
-(void)textChanged{
    
    CGRect orgRect = self.textView.frame;//获取原始UITextView的frame
    //获取尺寸
    CGSize size = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)];
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    //如果文本框没字了恢复初始尺寸
    if (orgRect.size.height > 100) {
        _noteTextHeight = orgRect.size.height;
    }else{
        _noteTextHeight = 100;
    }
    [self updateViewsFrame];
}

/**
 右边导航按钮
 */
- (void)rightBtn:(UIButton *)sender{
    
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
