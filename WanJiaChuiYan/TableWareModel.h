//
//  TableWareModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableWareModel : NSObject
@property(nonatomic,copy) NSString*addTime;
@property(nonatomic,copy) NSString*account;
@property(nonatomic,copy) NSString*money;
@property(nonatomic,copy) NSString*subject;
@property(nonatomic,copy) NSString*bianHao;
@property(nonatomic,copy) NSString*headUrl;
@property(nonatomic,copy) NSString *isFafang;
-(id)initWithCanJuDic:(NSDictionary*)dic;
@end
