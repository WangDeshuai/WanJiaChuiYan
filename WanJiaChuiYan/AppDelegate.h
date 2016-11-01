//
//  AppDelegate.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *appKey = @"1dfef5a5c152770dd0cb311b";
static NSString *channel = @"994d01a46e172a3a4bc6b0bf";
static BOOL isProduction = FALSE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     BMKMapManager* _mapManager; 
}
@property (strong, nonatomic) UIWindow *window;


@end

