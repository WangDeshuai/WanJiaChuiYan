//
//  MyOrderTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyOrderTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _nameLable=[UILabel new];
    _nameLable.font=[UIFont systemFontOfSize:16];
    _nameLable.alpha=.9;
    [self.contentView sd_addSubviews:@[_nameLable]];
    _nameLable.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    _contentLable=[UILabel new];
    _contentLable.font=[UIFont systemFontOfSize:15];
    _contentLable.alpha=.8;
    _contentLable.textColor=[UIColor grayColor];
    [self.contentView sd_addSubviews:@[_contentLable]];
    _contentLable.sd_layout
    .leftSpaceToView(_nameLable,20)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_contentLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
