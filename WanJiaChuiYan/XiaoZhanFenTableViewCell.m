//
//  XiaoZhanFenTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiaoZhanFenTableViewCell.h"
@interface XiaoZhanFenTableViewCell()
@property(nonatomic,retain)UILabel * menuLabel;
@property(nonatomic,retain)UIView * bgView;
@property(nonatomic,retain)UILabel * totalLabel;
@property(nonatomic,retain)UILabel * payMoney;


@end
@implementation XiaoZhanFenTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth{
    XiaoZhanFenTableViewCell * cell =[tableView cellForRowAtIndexPath:indepaxth];
    if (!cell) {
        cell=[[XiaoZhanFenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    _menuLabel=[UILabel new];
    _bgView=[UIView new];
    _totalLabel=[UILabel new];
    _payMoney=[UILabel new];
    
    _menuLabel.font=[UIFont systemFontOfSize:15];
    _menuLabel.alpha=.7;
    
    
    _totalLabel.alpha=.5;
    _totalLabel.font=[UIFont systemFontOfSize:15];
    
    _payMoney.alpha=.5;
    _payMoney.font=[UIFont systemFontOfSize:15];
    
    [self.contentView sd_addSubviews:@[_menuLabel,_bgView,_totalLabel,_payMoney]];
    _menuLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_menuLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-30];
    
    _bgView.sd_layout
    .leftEqualToView(_menuLabel)
    .topSpaceToView(_menuLabel,15)
    .heightIs(100)
    .rightSpaceToView(self.contentView,15);
    
    _payMoney.sd_layout
    .rightSpaceToView(self.contentView,15)
    .heightIs(20)
    .topSpaceToView(_bgView,15);
    [_payMoney setSingleLineAutoResizeWithMaxWidth:200];
  
    _totalLabel.sd_layout
    .rightSpaceToView(_payMoney,10)
    .heightRatioToView(_payMoney,1)
    .topEqualToView(_payMoney);
    [_totalLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    [self setupAutoHeightWithBottomView:_totalLabel bottomMargin:15];
}
-(void)setModel:(ChuFangOrderModel *)model
{
    _model=model;
    _menuLabel.text=[NSString stringWithFormat:@"菜品  %@",model.caiName];
    _totalLabel.text=[NSString stringWithFormat:@"共%@份",model.caiFenshu];
    _payMoney.text=[NSString stringWithFormat:@"总金额¥%@",model.payMoney];
  
    for (int i = 0; i<model.addressArray.count; i++) {
        NSDictionary * dic =model.addressArray[i];
        UILabel *  nameLabel =[UILabel new];
        
        UILabel * fenShuLabel=[UILabel new];
        [self dioYongLable:nameLabel];
        [self dioYongLable:fenShuLabel];
        
        nameLabel.frame=CGRectMake(0, (0+15+10)*i,ScreenWidth-100, 15);
        fenShuLabel.frame=CGRectMake(ScreenWidth-120, (0+15+10)*i, 70, 15);
        fenShuLabel.textAlignment=2;
        nameLabel.text=[dic objectForKey:@"addr"];
        fenShuLabel.text=[NSString stringWithFormat:@"x%@份",[dic objectForKey:@"send_number_sum"]];
        [_bgView addSubview:nameLabel];
        [_bgView addSubview:fenShuLabel];
        _bgView.sd_layout.heightIs( (0+15+10)*i+20);
    }

    
    
}
-(void)dioYongLable:(UILabel*)lb{
    lb.alpha=.6;
    lb.textAlignment=0;
    lb.font=[UIFont systemFontOfSize:14];
    lb.textColor=[UIColor blackColor];
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
