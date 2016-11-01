//
//  CityModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(id)initWithShengDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _cityname =[dic objectForKey:@"cityname"];
         _provname =[dic objectForKey:@"provname"];
    }
    
    return self;
}
@end
