//
//  PayStyeDaFan.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface PayStyeDaFan : BaseViewController

@property(nonatomic,copy)NSString * dingDan;
@property(nonatomic,copy)NSString * jiage;

/*
 用来区分是从打饭购物车进来的还是从餐具购买进来的
 当number==2的时候是从餐具界面来的
 
 */
@property(nonatomic,assign)NSInteger number;
@end
