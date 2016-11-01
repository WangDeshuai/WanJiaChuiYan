//
//  ShoppingTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
//right
@property(nonatomic,retain)UIButton * addBtn;
@property(nonatomic,retain)UIButton * subtractBtn;
@property(nonatomic,retain)UILabel * numberLable;
//left
@property(nonatomic,retain)UILabel * menuName1;
@property(nonatomic,retain)UILabel * menuName2;
@property(nonatomic,retain)UILabel * menuName3;
@property(nonatomic,retain)UILabel * price1;
@property(nonatomic,retain)UILabel * price2;
@property(nonatomic,retain)UILabel * price3;
@end
