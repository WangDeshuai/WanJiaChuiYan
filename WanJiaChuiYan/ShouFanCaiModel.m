//
//  ShouFanCaiModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShouFanCaiModel.h"

@implementation ShouFanCaiModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _phoneNumber=[self string:[dic objectForKey:@"connect_tel"]];
        _address=[self string:[dic objectForKey:@"addr"]];
        _fenShu=[self string:[dic objectForKey:@"send_number_total"]];
        _price=[self string:[dic objectForKey:@"money_total"]];
        _menuArray=[dic objectForKey:@"orderDetailInfo"];
        _chuID=[self string:[dic objectForKey:@"kitchen_id"]];
    }
    
    
    return self;
}

//实收
-(id)initWithShiShouDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _menuName=[self string:[dic objectForKey:@"menu_name"]];
         _yingShou=[self string:[dic objectForKey:@"send_number_sum"]];
         _shiShou=[self string:[dic objectForKey:@"number_practical"]];
         _iddMenu=[self string:[dic objectForKey:@"menu_id"]];
        _iddChuFang=[self string:[dic objectForKey:@"kitchen_id"]];
    }
    return self;
    
    
}

-(NSString*)string:(id)str{
    NSString * strr =[NSString stringWithFormat:@"%@",str];
    NSString * string;
    if (strr==nil || [strr isEqualToString:@"(null)"]) {
        string=@"";
    }else{
        string=strr;
    }
    
    return string;
}
@end
