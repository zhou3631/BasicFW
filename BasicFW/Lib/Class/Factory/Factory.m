//
//  Factory.m
//  BasicFW
//
//  Created by 周玉阳 on 2017/12/25.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "Factory.h"

@implementation Factory

 //左边的按钮
+ (UIButton *)addLeftbottonToVC:(UIViewController *)vc{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70*m6Scale, 70*m6Scale)];
    [button setImage:[UIImage imageNamed:@"Back-Arrow"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    vc.navigationItem.leftBarButtonItem = leftBarButton;
    return button;
}
//右边的文字按钮
+ (UIButton *)addRightbottonToVC:(UIViewController *)vc andrightStr:(NSString *)rightStr{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    [button setTitle:rightStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:30 * m6Scale];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    vc.navigationItem.rightBarButtonItem = rightBarButton;
    return button;
}
//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[345678][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//时间戳转换
+ (NSString *)stdTimeyyyyMMddFromNumer:(NSNumber *)num andtag:(NSInteger)tag
{
    if ([num isEqualToNumber:@0]|| num==nil || [num isKindOfClass:[NSNull class]]){
        return @"";
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[num doubleValue]/1000];
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        switch (tag) {
            case 0:
                formatter.dateFormat = @"yyyy-MM-dd";
                break;
            case 1:
                formatter.dateFormat = @"yyyy-MM-dd HH:mm";
                break;
            case 2:
                formatter.dateFormat = @"yyyy年-MM月-dd日 HH:mm";
                break;
            case 3:
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                break;
            case 4:
                formatter.dateFormat = @"yyyy.MM.dd";
                break;
            case 5:
                formatter.dateFormat = @"yyyy-MM-dd\nHH:mm:ss";
                break;
            case 6:
                formatter.dateFormat = @"yyyy.MM.dd HH:mm";
                break;
            case 7:
                formatter.dateFormat = @"MM-dd HH:mm";
                break;
            case 8:
                formatter.dateFormat = @"MM-dd";
                break;
                
            default:
                break;
        }
        NSString *time = [formatter stringFromDate:date];
        
        return time;
    }
}
//时间戳转换周
+ (NSString *)translateWeekDayWithStr:(NSString *)dateStr {
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSTimeInterval inter = [dateStr doubleValue] / 1000.0;
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:inter];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
/**
 *银行卡正则校验
 */
+ (BOOL)IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
//校验身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}
/**
 *  转换格式
 */
+ (NSString *)exchangeStrWithNumber:(NSNumber *)number {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *str = [numberFormatter stringFromNumber:number];
    
    return str;
}
//正常的添加逗号
+ (NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
/**
 带小数的逗号分隔
 */
+ (NSString *)countNumAndChange:(NSString *)num{
    
    NSString *money = num;
    NSMutableString *tempStr = money.mutableCopy;
    NSRange range = [money rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length > 0) {
        index = range.location;
    }else{
        index = money.length;
    }
    while ((index - 3) > 0) {
        index -= 3;
        [tempStr insertString:@"," atIndex:index];
    }
    //    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"." withString:@","].mutableCopy;
    NSLog(@"%@",tempStr);
    return tempStr;
}

@end
