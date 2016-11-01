//
//  LogineModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogineModel : NSObject
//baseInfo里面的参数
@property(nonatomic,copy)NSString * registid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *headimgurl;
@property(nonatomic,copy)NSString *addtime;
@property(nonatomic,copy)NSString *takeStationid;
-(id)initWithbaseInfoDic:(NSDictionary*)dic;
@end
