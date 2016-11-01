//
//  MyTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.adjustsImageWhenHighlighted=NO;
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.textAlignment=1;
    _arrowImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_rightmy"]];
    [self.contentView sd_addSubviews:@[_imageBtn,_nameLabel,_arrowImage]];
    
    
    _imageBtn.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(44);
    _nameLabel.sd_layout
    
    .leftSpaceToView(_imageBtn,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
  
    _arrowImage.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(19/2)
    .heightIs(34/2);
    
    
    _daiLingImage=[UIButton buttonWithType:UIButtonTypeCustom];
    _daiLingImage.hidden=YES;
    _daiLingImage.adjustsImageWhenDisabled=NO;
    [_daiLingImage setImage:[UIImage imageNamed:@"k-close"] forState:0];
    [_daiLingImage setImage:[UIImage imageNamed:@"k-start"] forState:UIControlStateSelected];
    [self.contentView sd_addSubviews:@[_daiLingImage]];
    
    
    _daiLingImage.sd_layout
    .rightSpaceToView(_arrowImage,10)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(14);
    
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
