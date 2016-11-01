//
//  ChuFangDingDanTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuFangOrderModel.h"
@interface ChuFangDingDanTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth;

@property(nonatomic,retain)ChuFangOrderModel * model;

@end
