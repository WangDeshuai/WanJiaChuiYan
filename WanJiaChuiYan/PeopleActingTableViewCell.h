//
//  PeopleActingTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleDaiLingModel.h"
#import "FuZhanZhangModel.h"
@interface PeopleActingTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UISwitch * switchbtn;

@property(nonatomic,retain)PeopleDaiLingModel * model;
@property(nonatomic,retain)FuZhanZhangModel * model2;
@end
