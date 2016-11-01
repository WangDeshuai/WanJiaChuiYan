//
//  RegisterModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject
@property(nonatomic,copy)NSString * msg;
@property(nonatomic,copy)NSString * code;
-(id)initWithDic:(NSDictionary*)dic;
@end
