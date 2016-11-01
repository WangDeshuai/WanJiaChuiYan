//
//  MyOrderModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
//我的订单未领取
@property(nonatomic,copy)NSString  * bianHao;
@property(nonatomic,copy)NSString *headImage;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,retain)NSMutableArray * menuArray;
@property(nonatomic,copy)NSString * fenshu;
@property(nonatomic,copy)NSString * payMoney;
@property(nonatomic,copy)NSString * lingquStyle;//领取方式(自己领取，找人带领)
@property(nonatomic,copy)NSString * btnTime;//点击立即领取按钮时间
@property(nonatomic,copy)NSString* jieShouStyle;//接收状态(未接受)
-(id)initWithWeiLingDic:(NSDictionary*)dic;

//我的订单已经领取
@property(nonatomic,copy)NSString  * Ybianhao;
@property(nonatomic,copy)NSString  * Yaddress;
@property(nonatomic,copy)NSString  * Yxiangqing;
@property(nonatomic,copy)NSString  * Ypaymoney;
@property(nonatomic,retain)NSMutableArray  * Ymenuarray;
@property(nonatomic,copy)NSString  * YxiaoZhanID;
-(id)initWithYiLingQuDic:(NSDictionary*)dic;
@end
