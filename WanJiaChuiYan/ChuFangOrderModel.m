//
//  ChuFangOrderModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChuFangOrderModel.h"

@implementation ChuFangOrderModel
-(id)initWithChuFangDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _phoneNumber=[XYString IsNotNull:[dic objectForKey:@"connect_tel"]];
         _headImage=[XYString IsNotNull:[dic objectForKey:@"station_image"]];
         _address=[XYString IsNotNull:[dic objectForKey:@"addr"]];
         _fenshu=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"send_number_total"]]];
         _payNumber=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"money_total"]]];
        _contentArr=[dic objectForKey:@"orderDetailInfo"];
    }
    
    return self;
}
//按照菜品份
-(id)initWithCaiFenDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _caiName=[XYString IsNotNull:[dic objectForKey:@"menu_name"]];
        _addressArray=[dic objectForKey:@"orderDetailInfo"];
        _caiFenshu=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"send_number_total"]]];
        _payMoney=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"money_total"]]];
        
        
    }
    
    return self;
}
@end
