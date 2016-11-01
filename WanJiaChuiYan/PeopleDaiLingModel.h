//
//  PeopleDaiLingModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleDaiLingModel : NSObject
//我的界面找人带领开关
@property(nonatomic,assign)BOOL isOpen;
-(id)initWithZhaoRenDic:(NSDictionary*)dic;

//找人带领
@property(nonatomic,copy)NSString * account;
@property(nonatomic,assign)BOOL isSwitch;
@property(nonatomic,copy)NSString * name;
-(id)initWithZhaoRenDaiLingDic:(NSDictionary*)dic;


@end
