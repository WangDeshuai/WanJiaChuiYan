//
//  ShiShouTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShiShouTableViewCell.h"
@interface ShiShouTableViewCell()
@property(nonatomic,retain)UILabel * nameLable;
@property(nonatomic,retain)UILabel * fenShuLable;
@property(nonatomic,retain)UIView * rightView;
@end
@implementation ShiShouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    ShiShouTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ShiShouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     //   self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
       [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _nameLable=[UILabel new];
    _fenShuLable=[UILabel new];
    _rightView=[UIView  new];
   
    [self shuXingLable:_nameLable];
    [self shuXingLable:_fenShuLable];
   
  //  _nameLable.text=@"西红柿炒鸡蛋";
//    _fenShuLable.text=@"15";
    [self.contentView sd_addSubviews:@[_nameLable,_fenShuLable,_rightView]];
    
    
    _nameLable.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(ScreenWidth/3);
    
    _fenShuLable.sd_layout
    .leftSpaceToView(_nameLable,0)
    .topEqualToView(_nameLable)
    .bottomEqualToView(_nameLable)
    .widthRatioToView(_nameLable,1);
//
    _rightView.sd_layout
    .rightSpaceToView(self.contentView,0)
    .topEqualToView(_fenShuLable)
    .widthRatioToView(_fenShuLable,1)
    .heightRatioToView(_fenShuLable,1);

    _numberLable=[UILabel new];
    _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _jianBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"bus_add"] forState:0];
    [_jianBtn setBackgroundImage:[UIImage imageNamed:@"bus_reduce"] forState:0];
    [self shuXingLable:_numberLable];
  // _numberLable.text=@"15";
//
    [_rightView sd_addSubviews:@[_numberLable,_addBtn,_jianBtn]];
//    
    _numberLable.sd_layout
    .topSpaceToView(_rightView,0)
    .bottomSpaceToView(_rightView,0)
    .centerXEqualToView(_rightView);
    [_numberLable setSingleLineAutoResizeWithMaxWidth:300];
//
    _addBtn.sd_layout
    .leftSpaceToView(_numberLable,10)
    .centerYEqualToView(_numberLable)
    .widthIs(20)
    .heightIs(20);
    
    _jianBtn.sd_layout
    .rightSpaceToView(_numberLable,10)
    .centerYEqualToView(_numberLable)
    .widthRatioToView(_addBtn,1)
    .heightEqualToWidth();
    
}
-(void)setModel:(ShouFanCaiModel *)model{
    _model=model;
     _nameLable.text=model.menuName;
    _fenShuLable.text=model.yingShou;
    _numberLable.text=model.shiShou;
    
}
-(void)shuXingLable:(UILabel*)labe{
    labe.font=[UIFont systemFontOfSize:15];
    labe.textColor=[UIColor blackColor];
    labe.alpha=.7;
    labe.textAlignment=1;
}
@end
