//
//  ShouCaiTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouFanCaiModel.h"
@interface ShouCaiTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID index:(NSIndexPath*)indepath;
@property(nonatomic,retain)UIButton * shiShouBtn;
@property(nonatomic,retain)ShouFanCaiModel * model;
@property(nonatomic,retain)NSMutableArray * dataArr;
@end
