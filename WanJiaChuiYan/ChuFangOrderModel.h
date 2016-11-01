//
//  ChuFangOrderModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChuFangOrderModel : NSObject
//按照厨房分
@property (nonatomic,copy)NSString * phoneNumber;
@property (nonatomic,copy)NSString * headImage;
@property (nonatomic,copy)NSString * address;
@property (nonatomic,copy)NSString * fenshu;
@property (nonatomic,copy)NSString * payNumber;
@property(nonatomic,retain)NSMutableArray * contentArr;
-(id)initWithChuFangDic:(NSDictionary*)dic;

//安菜品分
@property(nonatomic,copy)NSString * caiName;
@property(nonatomic,retain)NSMutableArray * addressArray;
@property(nonatomic,copy)NSString * caiFenshu;
@property(nonatomic,copy)NSString * payMoney;
-(id)initWithCaiFenDic:(NSDictionary*)dic;



@end
