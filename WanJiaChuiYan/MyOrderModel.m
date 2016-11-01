//
//  MyOrderModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel
//我的订单未领取
-(id)initWithWeiLingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _bianHao=[XYString IsNotNull:[dic objectForKey:@"out_trade_no"]];
        _headImage=[XYString IsNotNull:[dic objectForKey:@"station_image"]];
         _address=[XYString IsNotNull:[dic objectForKey:@"addr"]];
         _payMoney=[XYString IsNotNull:[dic objectForKey:@"money_total"]];
        _menuArray=[dic objectForKey:@"orderDetailList"];
        _fenshu=[XYString IsNotNull:[dic objectForKey:@"send_number_total"]];
         ;
        
        _lingquStyle=[NSString stringWithFormat:@"%@",[dic objectForKey:@"receive_type"]];//[XYString IsNotNull:[dic objectForKey:@"receive_type"]];
        _btnTime=[XYString IsNotNull:[dic objectForKey:@"click_receive_time"]];
        _jieShouStyle=[NSString stringWithFormat:@"%@",[dic objectForKey:@"receive_status"]];//[XYString IsNotNull:[dic objectForKey:@"receive_status"]];
        
    }
    
    
    return self;
}
//我的订单已经领取
-(id)initWithYiLingQuDic:(NSDictionary*)dic{
    
    self=[super init];
    if (self) {
        
        _Ybianhao=[XYString IsNotNull:[dic objectForKey:@"out_trade_no"]];
         _Yaddress=[XYString IsNotNull:[dic objectForKey:@"addr"]];
         _Yxiangqing=[XYString IsNotNull:[dic objectForKey:@"submit_time"]];
         _Ypaymoney=[XYString IsNotNull:[dic objectForKey:@"money_total"]];
        _Ymenuarray=[dic objectForKey:@"orderDetailList"];
        _YxiaoZhanID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"station_id"]];
        
    }
    
    
    return self;
    
}



@end
