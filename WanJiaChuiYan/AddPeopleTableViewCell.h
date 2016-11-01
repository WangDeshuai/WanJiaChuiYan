//
//  AddPeopleTableViewCell.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPeopleTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)UILabel *  nameLabel ;
@property(nonatomic,retain)UITextField *  textFiled;
@end
