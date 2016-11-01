//
//  ChuFangMessageModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChuFangMessageModel.h"

@implementation ChuFangMessageModel
-(id)initWithMessageDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _phoneNumber=[XYString IsNotNull:[dic objectForKey:@"connect_tel"]];//   ;
        _address=[XYString IsNotNull:[dic objectForKey:@"addr"]];
        _zuoBiao= [NSString stringWithFormat:@"%@，%@",[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"]];
        _payStye=[XYString IsNotNull:[dic objectForKey:@"payReceive_name"]];
        _payCode= [NSString stringWithFormat:@"%@",[dic objectForKey:@"payReceive_account"]];  
        _imageArr=[dic objectForKey:@"imgList"];
        _BianHaoName=[XYString IsNotNull:[dic objectForKey:@"name"]];
    }
    return self;
}
-(id)initWithXiaoZhanMessageDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
    
        _pingTaiAccount=[XYString IsNotNull:[dic objectForKey:@"master_account"]];
        _phoneNumber=[XYString IsNotNull:[dic objectForKey:@"connect_tel"]];//   ;
        
        
        _address=[XYString IsNotNull:[dic objectForKey:@"addr"]];
        _zuoBiao= [NSString stringWithFormat:@"%@，%@",[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"]];
       
        _payStye=[XYString IsNotNull:[dic objectForKey:@"payReceive_name"]];
        _payCode=[XYString IsNotNull:[dic objectForKey:@"payReceive_account"]];
       
        _imageArr=[dic objectForKey:@"imgList"];
        _xiaoZhanImage=[XYString IsNotNull:[dic objectForKey:@"station_image"]];
        _BianHaoName=[XYString IsNotNull:[dic objectForKey:@"name"]];
        
        
    }
    return self;
}
@end
