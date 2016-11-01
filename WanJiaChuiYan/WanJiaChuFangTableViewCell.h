//
//  WanJiaChuFangTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WanJiaChuFangTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UILabel * nameLable;
@property(nonatomic,retain)UIImageView * leftImage;
@property(nonatomic,retain)UIImageView * arrowImage;
@property(nonatomic,retain)UILabel * dingDanLab;
@property(nonatomic,retain)UIButton * rightImage;
@end
