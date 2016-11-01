//
//  RegisterViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property(nonatomic,copy)void(^userNamePswBlock)(NSString*user,NSString*psw);
@end
