//
//  TodayBusineTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodatModel.h"
@interface TodayBusineTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
//@property(nonatomic,retain)UILabel * nameLable;
@property(nonatomic,retain)UISwitch * swich;

@property(nonatomic,retain)TodatModel * model;
//@property(nonatomic,retain)UITextField * textfiled;
//@property(nonatomic,retain)UILabel * shuLiang;
//@property(nonatomic,retain)UILabel * fenShu;
@end
