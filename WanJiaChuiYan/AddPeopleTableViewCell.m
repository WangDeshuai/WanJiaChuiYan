//
//  AddPeopleTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AddPeopleTableViewCell.h"

@implementation AddPeopleTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    AddPeopleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[AddPeopleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _nameLabel.alpha=.7;
    _nameLabel.textAlignment=1;
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _textFiled=[UITextField new];
    _textFiled.font=[UIFont systemFontOfSize:15];
    _textFiled.alpha=.7;
    
    [self.contentView sd_addSubviews:@[_textFiled]];
    _textFiled.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,10);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -- 重新cell frame
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
@end
