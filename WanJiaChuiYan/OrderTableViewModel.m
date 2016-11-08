//
//  OrderTableViewModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "OrderTableViewModel.h"

@implementation OrderTableViewModel
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        _jingDu=[NSString stringWithFormat:@"%@",[dic objectForKey:@"longitude"]];
         _weiDu=[NSString stringWithFormat:@"%@",[dic objectForKey:@"latitude"]];
         _diZhi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"addr"]];
         _imageName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"station_image"]];
         _name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
         _quCanID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        if ([dic objectForKey:@"advertisement"]==[NSNull null])
        {
            _guangGaoYu=@"";
        }else{
            _guangGaoYu=[dic objectForKey:@"advertisement"];
        }
    NSString* jl=[NSString stringWithFormat:@"%@",[dic objectForKey:@"distance"]];
        int juli = [jl intValue];
        if (juli>=1000) {
            _juLi=[NSString stringWithFormat:@"%dkm",juli/1000];
        }else{
             _juLi=[NSString stringWithFormat:@"%dm",juli];
        }
        
    }
    
    return self;
}

-(id)initWithMenIDDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _menu_id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"menu_id"]];
        _price=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
        _menu_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"menu_name"]];
        _type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
        _number=[NSString stringWithFormat:@"%@",[dic objectForKey:@"surplus_number"]];
    }
    
    return self;
}
@end
