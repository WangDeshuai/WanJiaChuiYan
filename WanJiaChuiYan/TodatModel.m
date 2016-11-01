//
//  TodatModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TodatModel.h"

@implementation TodatModel
-(id)initWithMenuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        
       
        _kitchen_id=[XYString IsNotNull:[dic objectForKey:@"regist_id"]];
        NSString* _status=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        if ([_status isEqualToString:@"1"]) {
            _isopen=YES;
        }else{
            _isopen=NO;
        }
        
        _menu_id=[XYString IsNotNull:[dic objectForKey:@"menu_id"]];
        _name=[XYString IsNotNull:[dic objectForKey:@"name"]];
        _number=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]]];
        
    }
    
    return self;
    
}
@end
