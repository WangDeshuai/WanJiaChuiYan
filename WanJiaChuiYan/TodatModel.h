//
//  TodatModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodatModel : NSObject

@property(nonatomic,copy)NSString* kitchen_id;
@property(nonatomic,copy)NSString * menu_id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * number;
//@property(nonatomic,copy)NSString * status;
@property(nonatomic,assign)BOOL  isopen;
-(id)initWithMenuDic:(NSDictionary*)dic;
@end
