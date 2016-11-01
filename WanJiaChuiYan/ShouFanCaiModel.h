//
//  ShouFanCaiModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouFanCaiModel : NSObject
@property(nonatomic,copy)NSString *  phoneNumber;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString *fenShu;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString *chuID;
@property(nonatomic,retain)NSMutableArray * menuArray;
-(id)initWithDic:(NSDictionary*)dic;


//实收
@property(nonatomic,copy)NSString * menuName;
@property(nonatomic,copy)NSString * yingShou;
@property(nonatomic,copy)NSString * shiShou;
@property(nonatomic,copy)NSString * iddMenu;
@property(nonatomic,copy)NSString * iddChuFang;
-(id)initWithShiShouDic:(NSDictionary*)dic;

@end
