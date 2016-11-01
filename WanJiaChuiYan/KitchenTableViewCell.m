//
//  KitchenTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "KitchenTableViewCell.h"

@implementation KitchenTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView{
    KitchenTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[KitchenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
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
#pragma mark -- 初始化
-(void)CreatStar{
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.alpha=.8;
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _textField=[UITextField new];
    _textField.font=[UIFont systemFontOfSize:14];
    [self.contentView sd_addSubviews:@[_textField]];
    _textField.sd_layout
    .leftSpaceToView(_nameLabel,15)
    .rightSpaceToView(self.contentView,50)
    .centerYEqualToView(_nameLabel)
    .heightIs(30);
    
     _arrowImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    _arrowImage.hidden=YES;
    [self.contentView sd_addSubviews:@[_arrowImage]];
    _arrowImage.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(19/2)
    .heightIs(34/2);
    
    
    _imagebgView=[UIView new];
    _imagebgView.hidden=YES;
    _imagebgView.backgroundColor=[UIColor clearColor];
    [self.contentView sd_addSubviews:@[_imagebgView]];
    _imagebgView.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,0)
    .heightIs(60);
    
    
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.tag=10;
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"apply_kitchen_add"] forState:0];
    _addBtn.frame=CGRectMake(0, 0, 60, 60);
    [_imagebgView addSubview:_addBtn];
//    [_imagebgView sd_addSubviews:@[_addBtn]];
//    _addBtn.sd_layout
//    .leftSpaceToView(_imagebgView,0)
//    .topSpaceToView(_imagebgView,0)
//    .heightIs(60)
//    .widthIs(60);
    
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
