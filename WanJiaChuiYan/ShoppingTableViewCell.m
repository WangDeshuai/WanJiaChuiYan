//
//  ShoppingTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShoppingTableViewCell.h"
@interface ShoppingTableViewCell ()
@property(nonatomic,retain)UIView * bgView;
@end
@implementation ShoppingTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;{
    ShoppingTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ShoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatBJbackCorol];
        [self ContenText];
    }
    return self;
}
#pragma mark --加减背景色
-(void)CreatBJbackCorol{
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    _bgView.userInteractionEnabled=YES;
    [self.contentView sd_addSubviews:@[_bgView]];
    _bgView.sd_layout
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(ScreenWidth/4);
    
    
    _numberLable=[UILabel new];
    _numberLable.textAlignment=1;
    _numberLable.textColor=[UIColor colorWithRed:82/255.0 green:236/255.0 blue:135/255.0 alpha:1];
    _numberLable.font=[UIFont systemFontOfSize:16];
    _numberLable.text=@"1";
    _numberLable.tag=10;
    [_bgView sd_addSubviews:@[_numberLable]];
    _numberLable.sd_layout
    .centerYEqualToView(_bgView)
    .centerXEqualToView(_bgView)
    .widthIs(25)
    .heightIs(25);
    
    
    
    _subtractBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_subtractBtn setBackgroundImage:[UIImage imageNamed:@"bus_reduce"] forState:0];
    [_bgView sd_addSubviews:@[_subtractBtn]];
    _subtractBtn.sd_layout
    .centerYEqualToView(_bgView)
    .rightSpaceToView(_numberLable,0)
    .widthIs(25)
    .heightIs(25);
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"bus_add"] forState:0];
    [_bgView sd_addSubviews:@[_addBtn]];
    _addBtn.sd_layout
    .centerYEqualToView(_bgView)
    .leftSpaceToView(_numberLable,0)
    .widthIs(25)
    .heightIs(25);
    
    
}

-(void)ContenText{
    _menuName1=[UILabel new];
    _menuName1.font=[UIFont systemFontOfSize:16];
    _menuName2=[UILabel new];
    _menuName2.font=[UIFont systemFontOfSize:16];
    _menuName3=[UILabel new];
    _menuName3.font=[UIFont systemFontOfSize:16];
//    _menuName1.backgroundColor=[UIColor redColor];
//    _menuName2.backgroundColor=[UIColor redColor];
//    _menuName3.backgroundColor=[UIColor redColor];
    [self.contentView sd_addSubviews:@[_menuName1,_menuName2,_menuName3]];
    _menuName1.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    
    _menuName2.sd_layout
    .leftEqualToView(_menuName1)
    .topSpaceToView(_menuName1,5)
    .heightRatioToView(_menuName1,1);
  
    _menuName3.sd_layout
    .leftEqualToView(_menuName1)
    .topSpaceToView(_menuName2,5)
    .heightRatioToView(_menuName1,1);
    [_menuName1 setSingleLineAutoResizeWithMaxWidth:150];
    [_menuName2 setSingleLineAutoResizeWithMaxWidth:150];
    [_menuName3 setSingleLineAutoResizeWithMaxWidth:150];
    
    
    
    _price1=[UILabel new];
   // _price1.backgroundColor=[UIColor yellowColor];
    _price2=[UILabel new];
   // _price2.backgroundColor=[UIColor yellowColor];
    _price3=[UILabel new];
  //  _price3.backgroundColor=[UIColor yellowColor];
    _price1.textAlignment=1;
    _price2.textAlignment=1;
    _price3.textAlignment=1;
    _price1.alpha=.7;
     _price2.alpha=.7;
     _price3.alpha=.7;
    [self.contentView sd_addSubviews:@[_price1,_price2,_price3]];
    
    _price1.sd_layout
    .rightSpaceToView(_bgView,20)
    .topEqualToView(_menuName1)
    .heightRatioToView(_menuName1,1);
    
    _price2.sd_layout
    .rightEqualToView(_price1)
    .topEqualToView(_menuName2)
    .heightRatioToView(_price1,1);
    
    _price3.sd_layout
    .rightEqualToView(_price1)
    .heightRatioToView(_price1,1)
    .topEqualToView(_menuName3);
    [_price1 setSingleLineAutoResizeWithMaxWidth:150];
    [_price2 setSingleLineAutoResizeWithMaxWidth:150];
    [_price3 setSingleLineAutoResizeWithMaxWidth:150];
    
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
