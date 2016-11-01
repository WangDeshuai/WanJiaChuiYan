//
//  CityViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface CityViewController : BaseViewController
@property(nonatomic,copy)void(^cityNameBlock)(NSString*name);
@end
