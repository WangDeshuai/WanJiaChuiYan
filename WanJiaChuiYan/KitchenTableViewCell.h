//
//  KitchenTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KitchenTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UITextField * textField;
@property(nonatomic,retain)UIImageView * arrowImage;

@property(nonatomic,retain)UIView * imagebgView;
@property(nonatomic,retain)UIButton * addBtn;
@end
