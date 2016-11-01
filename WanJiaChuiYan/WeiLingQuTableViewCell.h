//
//  WeiLingQuTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
#import "FadeStringView.h"




@interface WeiLingQuTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID  indexp:(NSIndexPath*)indepaxth;
@property(nonatomic,retain)UIButton * immediatelyBtn;//立即领取
@property(nonatomic,retain)UIButton * queRenBtn;//确认领取
@property(nonatomic,retain)UIButton * weiLingQuBtn;//未领取
@property(nonatomic,retain)UIImageView * fafangImage;

@property(nonatomic,retain)MyOrderModel * model;
@property(nonatomic,assign)NSInteger tagg;
@property(nonatomic,retain)UITapGestureRecognizer * mTap;
@property(nonatomic,retain)FadeStringView * fadeStringView;
@end
