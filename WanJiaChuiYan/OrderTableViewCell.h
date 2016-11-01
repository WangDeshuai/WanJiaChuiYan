//
//  OrderTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewModel.h"
@interface OrderTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,retain)OrderTableViewModel * model;
@property(nonatomic,retain)UIButton * changeBtn;//立即更换
@property(nonatomic,retain)UIButton * imageLeft;//头像
@end
