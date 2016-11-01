//
//  TableWareTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TableWareTableViewCell.h"
@interface TableWareTableViewCell()

@property(nonatomic,retain)UILabel * account;
@property(nonatomic,retain)UILabel * bianHao;
@property(nonatomic,retain)UIImageView * headImage;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * dateLabel;
@property(nonatomic,retain)UILabel * priceLabel;

@end

@implementation TableWareTableViewCell


+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    TableWareTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[TableWareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _account=[UILabel new];
    _bianHao=[UILabel new];
    _headImage=[UIImageView new];
    _titleLabel=[UILabel new];
    _dateLabel=[UILabel new];
    _priceLabel=[UILabel new];
    _faFangBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _fafang=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _account.alpha=.7;
    _account.font=[UIFont systemFontOfSize:16];
    
    _bianHao.font=[UIFont systemFontOfSize:13];
    _bianHao.alpha=.5;
    
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.alpha=.7;
    
    _dateLabel.font=[UIFont systemFontOfSize:13];
    _dateLabel.alpha=.5;
    
    _priceLabel.font=[UIFont systemFontOfSize:14];
    _priceLabel.alpha=.7;
    
    
//    _account.text=@"账号  15032735032";
//    _bianHao.text=@"订单编号  254129572";
//    _headImage.image=[UIImage imageNamed:@"head_pic"];
//    _titleLabel.text=@"便携式餐具";
//    _dateLabel.text=@"2016-09-05";
//    _priceLabel.text=@"¥3.0元";
   // _faFangBtn.backgroundColor=[UIColor redColor];
    
    [_faFangBtn setBackgroundImage:[UIImage imageNamed:@"fafang_now"] forState:UIControlStateNormal];
    [_faFangBtn setBackgroundImage:[UIImage imageNamed:@"canjv_fafang"] forState:UIControlStateSelected];
    
    [_fafang setBackgroundImage:[UIImage imageNamed:@"canjv_weifafang"] forState:UIControlStateNormal];
    [_fafang setBackgroundImage:[UIImage imageNamed:@"canjv_yifafang"] forState:UIControlStateSelected];
    
    
    [self.contentView sd_addSubviews:@[_account,_bianHao,_headImage,_faFangBtn]];
    [self.contentView sd_addSubviews:@[_titleLabel,_priceLabel,_dateLabel,_fafang]];
    
    
    
    _account.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_account setSingleLineAutoResizeWithMaxWidth:300];
    
    _bianHao.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_account)
    .heightIs(15);
    [_bianHao setSingleLineAutoResizeWithMaxWidth:300];
    
    
    _headImage.sd_layout
    .leftEqualToView(_account)
    .topSpaceToView(_account,10)
    .widthIs(60)
    .heightIs(60);
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(_headImage,10)
    .topEqualToView(_headImage)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
   
    
    _priceLabel.sd_layout
    .topSpaceToView(_titleLabel,5)
    .leftEqualToView(_titleLabel)
    .heightRatioToView(_titleLabel,1);
    [_priceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _fafang.sd_layout
    .leftSpaceToView(_priceLabel,5)
    .centerYEqualToView(_priceLabel)
    .widthIs(122/2)
    .heightIs(32/2);
    
    
    
    _dateLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_priceLabel,5)
    .heightIs(15);
    [_dateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _faFangBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_titleLabel)
    .widthIs(102/2)
    .heightIs(42/2);
    
    
    
    [self setupAutoHeightWithBottomView:_dateLabel bottomMargin:15];
    
}


-(void)setModel:(TableWareModel *)model
{
    _model=model;
    _account.text=[NSString stringWithFormat:@"账号  %@",model.account];
    _bianHao.text=[NSString stringWithFormat:@"订单编号  %@",model.bianHao];
    [_headImage setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"head_pic"]];
    _titleLabel.text=model.subject;//@"便携式餐具";
    _dateLabel.text=model.addTime;//@"2016-09-05";
    _priceLabel.text=[NSString stringWithFormat:@"¥%@元",model.money];//@"¥3.0元";
    
    if ([model.isFafang isEqualToString:@"0"]) {
        _fafang.selected=NO;
        _faFangBtn.selected=NO;
    }else{
        _faFangBtn.selected=YES;
        _fafang.selected=YES;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
