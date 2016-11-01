//
//  SettlementModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettlementModel : NSObject
@property(nonatomic,copy)NSString *bianHao;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * address;

-(id)initWithOrderDic:(NSDictionary*)dic;
@end
