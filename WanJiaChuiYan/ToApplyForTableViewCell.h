//
//  ToApplyForTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToApplyForModel.h"
@interface ToApplyForTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)ToApplyForModel * model;
@property(nonatomic,retain)UIButton * zhiChitBtn;
@property(nonatomic,retain)UIButton * numberBtn;
@end
