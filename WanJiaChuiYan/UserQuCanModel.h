//
//  UserQuCanModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserQuCanModel : NSObject
@property(nonatomic,assign)BOOL isOpen;
-(id)initWithUserDic:(NSDictionary*)dic;
@end
