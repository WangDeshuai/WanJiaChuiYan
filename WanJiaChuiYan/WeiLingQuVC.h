//
//  WeiLingQuVC.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface WeiLingQuVC : BaseViewController
{
    NSInteger indexpathRow;
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    UILabel * labelText;


}
@end
