//
//  PeopleDaiLingModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleDaiLingModel.h"

@implementation PeopleDaiLingModel
//查询找人带领开关状态
-(id)initWithZhaoRenDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * open =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        
        if ([open isEqualToString:@"0"])
        {
            _isOpen=NO;
        }else{
            _isOpen=YES;
        }
        
    }
    
    return self;
}
//找人带领详情
-(id)initWithZhaoRenDaiLingDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _name= [self isString:[dic objectForKey:@"replace_user_name"]];    //[dic objectForKey:@"replace_user_name"];
        _account=[self isString:[dic objectForKey:@"replace_account"]];//[dic objectForKey:@"replace_account"];
        NSString * status =[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];//;
        if ([status isEqualToString:@"0"])
        {
            _isSwitch=NO;
        }else{
            _isSwitch=YES;
        }
    }
    
    return self;
}

-(NSString*)isString:(id)str{
    NSString * stri=nil;
    if (str==nil || str==[NSNull null] || [str isEqualToString:@"(null)"]) {
        stri=@"";
    }else{
        stri=str;
    }
    
    return stri;
}

@end
