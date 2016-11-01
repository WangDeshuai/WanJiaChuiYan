//
//  MapViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property(nonatomic,copy)NSString * userAddress;
@property(nonatomic,copy)NSString * addressCity;
@property(nonatomic,copy)void(^JingWeiBlock)(NSString*jiDu,NSString*weiDu);
@end
