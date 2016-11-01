//
//  ToApplyForModel.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToApplyForModel : NSObject
@property(nonatomic,copy)NSString * distance;
@property(nonatomic,copy)NSString * idd;
@property(nonatomic,copy)NSString * account;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * selfPraised;//自己是不是点赞了
@property(nonatomic,assign)BOOL isMyself;
@property(nonatomic,copy)NSString * praiseNumber;
@property(nonatomic,copy)NSString * headImage;
@property(nonatomic,copy)NSString * titleName;
-(id)initWithReviewDic:(NSDictionary*)dic;
@end
