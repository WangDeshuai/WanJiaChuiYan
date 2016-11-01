//
//  FuZhanZhangModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/7.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuZhanZhangModel.h"

@implementation FuZhanZhangModel
//副站长开关
-(id)initWithFuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _msg=[dic objectForKey:@"msg"];
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        _code=[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([content isEqualToString:@"1"]) {
            _isOpen=YES;
        }else{
            _isOpen=NO;
        }
        
    }
    
    return self;
}

//副站长详情
-(id)initWithFuZhanZhangDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _phoneNumber= [XYString IsNotNull:[dic objectForKey:@"vice_account"]];
        _name=[XYString IsNotNull:[dic objectForKey:@"vice_name"]];
        NSString * status =[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        if ([status isEqualToString:@"0"]) {
            //关闭
            _isSwitch=NO;
        }else{
            //打开
            _isSwitch=YES;
        }
    }
    
    return self;
}
@end
