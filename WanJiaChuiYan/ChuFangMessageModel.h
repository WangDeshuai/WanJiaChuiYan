//
//  ChuFangMessageModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChuFangMessageModel : NSObject
//查询厨房的信息
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * zuoBiao;
@property(nonatomic,copy)NSString * payStye;
@property(nonatomic,copy)NSString * payCode;
@property(nonatomic,retain)NSArray * imageArr;
@property(nonatomic,copy)NSString * BianHaoName;
-(id)initWithMessageDic:(NSDictionary*)dic;
//查询小站的信息（比厨房多有个小站图片）
@property(nonatomic,copy)NSString * xiaoZhanImage;
@property(nonatomic,copy)NSString * pingTaiAccount;
-(id)initWithXiaoZhanMessageDic:(NSDictionary*)dic;
@end
