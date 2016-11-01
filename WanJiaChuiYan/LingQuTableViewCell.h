//
//  LingQuTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
@interface LingQuTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID index:(NSIndexPath*)indepath;
@property(nonatomic,retain)MyOrderModel * model;
@property (nonatomic, copy) void (^tuijianBlock)(NSInteger tagg,UIButton * btn);
@property (nonatomic, copy) void (^tucaoBlock)(NSInteger tagg ,UIButton*btn);
@end
