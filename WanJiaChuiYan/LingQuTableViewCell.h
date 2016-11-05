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
//价格贵
@property (nonatomic, copy) void (^jiageguiBlock)(NSDictionary * dicc);
//味道差
@property (nonatomic, copy) void (^weidaochaBlock)(NSDictionary*dicc);
//满意
@property (nonatomic, copy) void (^manyiBlock)(NSDictionary*dicc);
//分量少
@property (nonatomic, copy) void (^fenliangshaoBlock)(NSDictionary*dicc);

@end
