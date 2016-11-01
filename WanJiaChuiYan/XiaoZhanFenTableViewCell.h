//
//  XiaoZhanFenTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuFangOrderModel.h"
@interface XiaoZhanFenTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth;
@property(nonatomic,retain)ChuFangOrderModel * model;
@end
