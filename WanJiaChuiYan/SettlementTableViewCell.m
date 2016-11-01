//
//  SettlementTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SettlementTableViewCell.h"
@interface SettlementTableViewCell()



@end
@implementation SettlementTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;{
    SettlementTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[SettlementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self setup];
    }
    return self;
}

-(void)setup{
    _nameLable=[UILabel new];
    _nameLable.font=[UIFont systemFontOfSize:15];
    _nameLable.alpha=.7;
    _nameLable.textAlignment=0;
    [self.contentView sd_addSubviews:@[_nameLable]];
    _nameLable.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    
    _contentLabel=[UILabel new];
    _contentLabel.font=[UIFont systemFontOfSize:14];
    _contentLabel.alpha=.5;
   [self.contentView sd_addSubviews:@[_contentLabel]];
    _contentLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_nameLable)
    .heightRatioToView(_nameLable,1);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
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
