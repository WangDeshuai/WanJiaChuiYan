//
//  TheRulesTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/7.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheRulesTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;

@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * contentLabel;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger number;
@end
