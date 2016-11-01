//
//  MyInformationTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyInformationTableViewCell.h"

@implementation MyInformationTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView{
    MyInformationTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
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
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.textAlignment=0;
    _nameLabel.alpha=.7;
    //_imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[_imageBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    _arrowImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
//    _imageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    _imageBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    _imageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    
    
   // [self.contentView addSubview:_imageBtn];
    [self.contentView sd_addSubviews:@[_nameLabel,_arrowImage]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    _arrowImage.hidden=YES;
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-50];
    
    _arrowImage.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(19/2)
    .heightIs(34/2);
    
    
    _lineImageView=[UIImageView new];
    _lineImageView.hidden=YES;
    [self.contentView sd_addSubviews:@[_lineImageView]];
    _lineImageView.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(60);
    
    _nameText=[UITextField new];
    _nameText.placeholder=@"请输入昵称";
    _nameText.alpha=.6;
    _nameText.font=[UIFont systemFontOfSize:16];
    _nameText.textAlignment=2;
    _nameText.hidden=YES;
    [self.contentView sd_addSubviews:@[_nameText]];
    
    _nameText.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(30)
    .widthIs(120);
    
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
