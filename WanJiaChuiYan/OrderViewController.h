//
//  OrderViewController.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"
#import "CopyiPhoneFadeView.h"
@interface OrderViewController : BaseViewController
{
    int addNumber;
    int number;
    UIButton * numberBtn;//购物车上面的数字
    UILabel * leftLable ;
    UILabel * centerLable;
    UILabel * rightLable;
    /***/
    
     UIButton * imageLeft ;
     UIButton * btnRight;
    CopyiPhoneFadeView *iphoneFade;
    UILabel * nameLabel;
    UIImageView * image1;
    UILabel * distance;
    UILabel * label1;
    UIImageView * image2;
    UILabel * label2;
    UITapGestureRecognizer *mTap;
    UIView * bggview;
    UILabel * paomadeng;
    UIImageView * image3;
}
@property(nonatomic,retain)NSMutableArray * priceArray;
@property(nonatomic,retain)NSMutableArray *MenuID;
@end
