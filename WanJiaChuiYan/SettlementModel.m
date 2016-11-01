//
//  SettlementModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SettlementModel.h"

@implementation SettlementModel
-(id)initWithOrderDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bianHao=[XYString IsNotNull:[dic objectForKey:@"out_trade_no"]];
        _time=[XYString IsNotNull:[dic objectForKey:@"take_time"]];
        _address=[XYString IsNotNull:[dic objectForKey:@"take_addr"]];

        
    }
    return self;
}
@end
