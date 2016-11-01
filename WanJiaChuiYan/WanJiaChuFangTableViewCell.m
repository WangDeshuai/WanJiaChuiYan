//
//  WanJiaChuFangTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WanJiaChuFangTableViewCell.h"

@implementation WanJiaChuFangTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    WanJiaChuFangTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[WanJiaChuFangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _leftImage=[UIImageView new];
    [self.contentView  sd_addSubviews:@[_leftImage]];
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(30/2)
    .heightIs(30/2);
    
    
    _nameLable=[UILabel new];
    _nameLable.font=[UIFont systemFontOfSize:15];
    _nameLable.alpha=.8;
    [self.contentView sd_addSubviews:@[_nameLable]];
    _nameLable.sd_layout
    .leftSpaceToView(_leftImage,15)
    .centerYEqualToView(_leftImage)
    .heightIs(20);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
      _arrowImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_rightmy"]];
    [self.contentView sd_addSubviews:@[_arrowImage]];
    _arrowImage.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(19/2)
    .heightIs(34/2);

    _dingDanLab=[UILabel new];
    _dingDanLab.hidden=YES;
    _dingDanLab.font=[UIFont systemFontOfSize:15];
    _dingDanLab.alpha=.6;
    [self.contentView sd_addSubviews:@[_dingDanLab]];
    _dingDanLab.sd_layout
    .leftSpaceToView(_nameLable,20)
    .centerYEqualToView(_nameLable)
    .heightIs(20);
    [_dingDanLab setSingleLineAutoResizeWithMaxWidth:220];
    
    
    
    _rightImage=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightImage setBackgroundImage:[UIImage imageNamed:@"k-close"] forState:UIControlStateNormal];
    [_rightImage setBackgroundImage:[UIImage imageNamed:@"k-start"] forState:UIControlStateSelected];
    _rightImage.hidden=YES;
    [self.contentView sd_addSubviews:@[_rightImage]];
    
    _rightImage.sd_layout
    .rightSpaceToView(_arrowImage,5)
    .centerYEqualToView(self.contentView)
    .widthIs(120/2)
    .heightIs(28/2);
    
    
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
