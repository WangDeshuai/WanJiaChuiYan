//
//  ToolClass.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject
#pragma mark --判断是否登录
+(BOOL)isLogin;
#pragma mark --判断是否是万家厨房或者饮烟小站
+(BOOL)isWanJiaAndYinYan;

#pragma mark --判断用户身份
+(NSString*)userType;

#pragma mark --判断有没有基本资料，要是没有就是第一次登录，让用户填写
+(BOOL)isInfomation;
#pragma mark --获取本地时间
+(NSString *)getNowTime;

#pragma mark --本地时间和网络时间对比
+ (BOOL )getTimeDifferentWith:(NSString *)date  DataNow:(NSString*)dataNow;

#pragma mark -- 拨打电话
+(void)tellPhone:(NSString*)tell;

#pragma mark --是否开启定位服务（开启YES）
+(BOOL)kaiQiDingWei;

@end
