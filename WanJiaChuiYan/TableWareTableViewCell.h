//
//  TableWareTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableWareModel.h"
@interface TableWareTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)TableWareModel * model;
@property(nonatomic,retain)UIButton * faFangBtn;
@property(nonatomic,retain)UIButton * fafang;
@end
