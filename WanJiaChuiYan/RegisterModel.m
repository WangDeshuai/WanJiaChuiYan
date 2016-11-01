//
//  RegisterModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        _code=[XYString IsNotNull:code];
        _msg=[XYString IsNotNull:[dic objectForKey:@"msg"]];
    }
    
    return self;
}
@end
