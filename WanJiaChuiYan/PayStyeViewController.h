//
//  PayStyeViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface PayStyeViewController : BaseViewController
@property(nonatomic,copy)void(^payStyeBlock)(NSString*payName);
@end
