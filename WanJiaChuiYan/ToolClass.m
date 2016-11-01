//
//  ToolClass.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass
+(BOOL)isLogin{
    NSString * str =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if (str==nil) {
        return NO;
    }
    return YES;
}

#pragma mark --判断用户身份
+(NSString*)userType{
    
    NSDictionary * dic =[XYString duquPlistWenJianPlistName:@"regist"];
    NSString * type;
    
    if (dic==nil) {
       type=@"1";
        NSLog(@"是空的");
    }else{
        type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"user_type"]];
    }
    
//    if ([type isEqualToString:@"2"]) {
//        //1是普通用户，2是万家厨房 3炊烟小站 4副站长
//        return @"2";
//    }

    return type;
}


#pragma mark --判断是否是万家厨房或者饮烟小站
+(BOOL)isWanJiaAndYinYan{
    if (![self isLogin]) {
        return NO;
    }
    NSDictionary * dic =[XYString duquPlistWenJianPlistName:@"base"];
    NSString * type =[NSString stringWithFormat:@"%@",[dic objectForKey:@"user_type"]];
   
    if ([type isEqualToString:@"1"]) {
        //一会改为NO
        return NO;
    }

    
    return YES;
}
#pragma mark --判断有没有基本资料，要是没有就是第一次登录，让用户填写
+(BOOL)isInfomation{
  NSDictionary* dic=[XYString  duquPlistWenJianPlistName:@"base"];
    if (dic==nil) {
        return NO;
    }
    return YES;
}

#pragma mark --获取本地时间
//+(BOOL)getBenDiTime
//{
//    __block  BOOL ss;
////     __weak __typeof(self)weakSelf = self;
//    [Engine xiaDanCloseTimesuccess:^(NSDictionary *dic) {
//        //NSLog(@"输出%@",[ToolClass getNowTime]);
//        NSDictionary * dicc =[dic objectForKey:@"content"];
//        NSString  * time =[dicc objectForKey:@"order_close_time"];
//      ss=  [ToolClass getTimeDifferentWith:time DataNow:[ToolClass getNowTime]];
//    } error:^(NSError *error) {
//        
//    }];
//    
//    
//    return ss;
//}

/* 获取本地时间 */
+(NSString *)getNowTime {
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
/* 计算消息时间距离当前时差 */
+ (BOOL )getTimeDifferentWith:(NSString *)date  DataNow:(NSString*)dataNow{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm:ss"]; /* ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制 */
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    /* 设置时区,这个对于时间的处理有时很重要 */
    NSDate *dateModel = [formatter dateFromString:date]; /* 按照格式设置传入的date时间 */
    NSDate *dateNow = [formatter dateFromString:dataNow];/* 按照格式设置本地时间 */
    NSString *timeModel = [NSString stringWithFormat:@"%ld", (long)[dateModel timeIntervalSince1970]];/* 计算传入时间的时间戳 */
    NSString *timeNow = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];/* 计算当前时间的时间戳 */
    NSInteger time = ([timeNow integerValue] - [timeModel integerValue]) / 60;/* 计算时差 */
    
    if (time>0) {
        NSLog(@"过了10点");
        
        return YES;
    }else{
        NSLog(@"没到10点");
        return NO;
    }
    
//    if (time > 60) {
//        return [NSString stringWithFormat:@"%ld小时前",time / 60];
//    } else {
//        return [NSString stringWithFormat:@"%ld分钟前",time % 60];
//    }
}

#pragma mark -- 拨打电话
+(void)tellPhone:(NSString*)tell{
    //联系我们
    NSString *allString = [NSString stringWithFormat:@"tel:%@",tell];
    NSString*telUrl =[allString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
}
#pragma mark --是否开启定位服务（开启YES）
+(BOOL)kaiQiDingWei{
    
    return NO;
    
}

@end
