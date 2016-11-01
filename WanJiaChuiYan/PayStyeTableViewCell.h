//
//  PayStyeTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayStyeTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UIButton * leftImage;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UIButton * rightImage;
@end
