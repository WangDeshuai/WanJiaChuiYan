//
//  FuZhanZhangModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/7.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuZhanZhangModel : NSObject
//副站长开关
@property(nonatomic,copy)NSString * msg;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,copy)NSString * code;
-(id)initWithFuDic:(NSDictionary*)dic;
//副站长详情
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)BOOL isSwitch;
-(id)initWithFuZhanZhangDic:(NSDictionary*)dic;
@end
