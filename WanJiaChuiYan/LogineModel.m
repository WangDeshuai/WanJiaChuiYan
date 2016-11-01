//
//  LogineModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LogineModel.h"

@implementation LogineModel
-(id)initWithbaseInfoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _registid=[XYString IsNotNull:[dic objectForKey:@"regist_id"]];
        _name=[XYString IsNotNull:[dic objectForKey:@"name"]];
        _headimgurl=[XYString IsNotNull:[dic objectForKey:@"headimgurl"]];
        _takeStationid=[XYString IsNotNull:[dic objectForKey:@"takeStation_id"]];
        _addtime=[XYString IsNotNull:[dic objectForKey:@"add_time"]];
    }
    
    return self;
}
@end
