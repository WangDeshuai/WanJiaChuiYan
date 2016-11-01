//
//  YeJiViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface YeJiViewController : BaseViewController
/*
 urlName=kitchen;是万家厨房
 urlName=station;是小站
 
 */
@property(nonatomic,copy)NSString* urlName;
@property(nonatomic,copy)NSString* urlName2;
@property(nonatomic,assign)NSInteger tagg;
@end
