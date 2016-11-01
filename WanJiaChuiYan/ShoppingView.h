//
//  ShoppingView.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShoppingDelegate <NSObject>

-(void)clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface ShoppingView : UIView
@property (nonatomic ,assign)id  delegate;
@end
