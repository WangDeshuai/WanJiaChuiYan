//
//  MyOrderTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;;
@property(nonatomic,retain)UILabel * nameLable;
@property(nonatomic,retain)UILabel * contentLable;
@end
