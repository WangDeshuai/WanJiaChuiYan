//
//  MenuModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject
@property(nonatomic,copy)NSString * menuName1;
@property(nonatomic,copy)NSString * menuName2;
@property(nonatomic,copy)NSString * menuName3;
@property(nonatomic,copy)NSString * price1;
@property(nonatomic,copy)NSString * price2;
@property(nonatomic,copy)NSString * price3;
@property(nonatomic,copy)NSString * fenShu;
@property(nonatomic,copy)NSString * taoCanID;
-(id)initWithDic:(NSDictionary*)dic;
@end
