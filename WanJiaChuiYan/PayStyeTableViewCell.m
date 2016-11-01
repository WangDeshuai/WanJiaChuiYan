//
//  PayStyeTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PayStyeTableViewCell.h"

@interface PayStyeTableViewCell ()


@end


@implementation PayStyeTableViewCell


+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    PayStyeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[PayStyeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStra];
    }
    return self;
}

-(void)CreatStra{
    _leftImage=[UIButton new];
    [self.contentView sd_addSubviews:@[_leftImage]];
    
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,5)
    .centerYEqualToView(self.contentView)
    .heightIs(50)
    .widthIs(50);
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.alpha=.7;
    _nameLabel.textAlignment=1;
    [self.contentView sd_addSubviews:@[_nameLabel]];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_leftImage,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    _rightImage=[UIButton new];
    [_rightImage setImage:[UIImage imageNamed:@"zhifu_button"] forState:0];
    [_rightImage setImage:[UIImage imageNamed:@"zhifu_button_click"] forState:UIControlStateSelected];
    [self.contentView sd_addSubviews:@[_rightImage]];
    
    _rightImage.sd_layout
    .rightSpaceToView(self.contentView,5)
    .centerYEqualToView(self.contentView)
    .heightIs(50)
    .widthIs(50);
    
    
    
    
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end
