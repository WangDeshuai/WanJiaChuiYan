//
//  MyTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UIButton * imageBtn;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UIImageView * arrowImage;
@property(nonatomic,retain)UIButton * daiLingImage;//找人代领的
@end
