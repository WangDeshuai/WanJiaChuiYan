//
//  MenuModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _menuName1=[dic objectForKey:@"menuname1"];
        
        
    }
    
    return self;
}
@end
