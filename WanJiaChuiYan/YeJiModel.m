//
//  YeJiModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YeJiModel.h"

@implementation YeJiModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _time=[self string:[dic objectForKey:@"orderDate"]];
        _totleFenShu=[self string:[dic objectForKey:@"total_number"]];
        _taoCanShu=[self string:[dic objectForKey:@"total_number"]];
        if ([dic objectForKey:@"orderList"]==[NSNull null] || [[dic objectForKey:@"orderList"] count]==0) {
            
        }else{
            _menuArr=[dic objectForKey:@"orderList"];
        }
    }
    
    return self;
}

-(NSString*)string:(id)str{
    NSString * string;
    if (str==nil || str==[NSNull null]) {
        string=@"";
    }else{
        string=[NSString stringWithFormat:@"%@",str];//   str;
    }
    
    return string;
    
}
@end
