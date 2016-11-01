//
//  ShiShouTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouFanCaiModel.h"
@interface ShiShouTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UIButton * addBtn;
@property(nonatomic,retain)UIButton * jianBtn;
@property(nonatomic,retain)UILabel * numberLable;

@property(nonatomic,retain)ShouFanCaiModel * model;
@end
