//
//  YeJiTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YeJiModel.h"
@interface YeJiTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth;
@property(nonatomic,retain)UILabel * taoCanShu;
@property(nonatomic,retain)UILabel * totleLable;
@property(nonatomic,retain)YeJiModel * model;
@end
