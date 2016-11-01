//
//  OrderTableViewModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTableViewModel : NSObject
//附近站点
@property(nonatomic,copy)NSString * jingDu;
@property(nonatomic,copy)NSString * weiDu;
@property(nonatomic,copy)NSString * juLi;
@property(nonatomic,copy)NSString * diZhi;
@property(nonatomic,copy)NSString * quCanID;
@property(nonatomic,copy)NSString * imageName;
@property(nonatomic,copy)NSString * name;
-(id)initWithDic:(NSDictionary*)dic;
//菜品名字的
@property(nonatomic,copy)NSString * menu_id;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * menu_name;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * number;
-(id)initWithMenIDDic:(NSDictionary*)dic;


@end
