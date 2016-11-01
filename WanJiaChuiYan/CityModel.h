//
//  CityModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic,copy)NSString * cityname;
@property(nonatomic,copy)NSString *provname;
-(id)initWithShengDic:(NSDictionary*)dic;
@end
