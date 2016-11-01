//
//  YeJiModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
//查看业绩
@interface YeJiModel : NSObject
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * totleFenShu;
@property(nonatomic,copy)NSString * taoCanShu;
@property(nonatomic,retain) NSMutableArray * menuArr;
-(id)initWithDic:(NSDictionary*)dic;
@end
