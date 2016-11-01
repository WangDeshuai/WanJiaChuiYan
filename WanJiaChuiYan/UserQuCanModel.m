//
//  UserQuCanModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UserQuCanModel.h"

@implementation UserQuCanModel
-(id)initWithUserDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
     
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([content isEqualToString:@"1"]) {
            _isOpen=YES;
        }else{
            _isOpen=NO;
        }
        
    }
    return self;
}
@end
