//
//  MyInformationTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UIImageView * arrowImage;

@property(nonatomic,retain)UITextField * nameText;
@property(nonatomic,retain)UIImageView * lineImageView;
@end
