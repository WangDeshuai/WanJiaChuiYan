//
//  ChuFangDingDanTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChuFangDingDanTableViewCell.h"
@interface ChuFangDingDanTableViewCell()
@property(nonatomic,retain)UILabel * phoneNumber;
@property(nonatomic,retain)UIImageView * headImage;
@property(nonatomic,retain)UILabel * titleLable;
@property(nonatomic,retain)UIView * contenttView;
@property(nonatomic,retain)UILabel * dateLable;
@property(nonatomic,retain)UILabel * totalLable;
@property(nonatomic,retain)UILabel * payMoney;



@end
@implementation ChuFangDingDanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth{
    ChuFangDingDanTableViewCell * cell =[tableView cellForRowAtIndexPath:indepaxth];
    if (!cell) {
        cell=[[ChuFangDingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _phoneNumber=[UILabel new];
    _headImage=[UIImageView new];
    _titleLable=[UILabel  new];
    [self.contentView sd_addSubviews:@[_phoneNumber,_headImage,_titleLable]];
   
    [self dioYongLable:_phoneNumber];
    _titleLable.font=[UIFont systemFontOfSize:16];
    _titleLable.textAlignment=0;
    _titleLable.alpha=.8;
    _titleLable.textColor=[UIColor blackColor];
    
    
    _phoneNumber.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,15)
    .heightIs(15);
    [_phoneNumber setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    _headImage.sd_layout
    .leftEqualToView(_phoneNumber)
    .widthIs(60)
    .heightIs(60)
    .topSpaceToView(_phoneNumber,15);
    
    _titleLable.sd_layout
    .leftSpaceToView(_headImage,10)
    .heightIs(15)
    .topEqualToView(_headImage);
    [_titleLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    _contenttView=[UIView new];
    _dateLable=[UILabel new];
    _totalLable=[UILabel new];
    _payMoney=[UILabel new];
    
   // _contenttView.backgroundColor=[UIColor redColor];
    [self dioYongLable:_dateLable];
    [self dioYongLable:_totalLable];
    [self dioYongLable:_payMoney];
    
    [self.contentView sd_addSubviews:@[_contenttView,_dateLable,_totalLable,_payMoney]];
    
    _contenttView.sd_layout
    .leftEqualToView(_titleLable)
    .topSpaceToView(_titleLable,15)
    .rightSpaceToView(self.contentView,10)
    .heightIs(100);//高度不固定
    
   
    
    
    _payMoney.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_contenttView,15)
    .heightIs(20);
    [_payMoney setSingleLineAutoResizeWithMaxWidth:150];
    
    _totalLable.sd_layout
    .centerYEqualToView(_payMoney)
    .heightRatioToView(_payMoney,1)
    .rightSpaceToView(_payMoney,10);
    [_totalLable setSingleLineAutoResizeWithMaxWidth:100];
    
    [self setupAutoHeightWithBottomView:_totalLable bottomMargin:15];
    
}

-(void)dioYongLable:(UILabel*)lb{
    lb.alpha=.6;
    lb.textAlignment=0;
    lb.font=[UIFont systemFontOfSize:14];
    lb.textColor=[UIColor blackColor];
}
-(void)setModel:(ChuFangOrderModel *)model
{
    _model=model;
    _phoneNumber.text=[NSString stringWithFormat:@"联系电话  %@",model.phoneNumber];
    [_headImage setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"head_pic"]];
    _titleLable.text=[NSString stringWithFormat:@"取餐点  %@",model.address];
    _totalLable.text=[NSString stringWithFormat:@"共%@份",model.fenshu];
    _payMoney.text=[NSString stringWithFormat:@"实付¥%@份",model.payNumber];
    
    for (int i = 0; i<model.contentArr.count; i++) {
        NSDictionary * dic =model.contentArr[i];
        UILabel *  nameLabel =[UILabel new];
        
        UILabel * fenShuLabel=[UILabel new];
        UILabel * priceLabel=[UILabel new];
        [self dioYongLable:nameLabel];
        [self dioYongLable:fenShuLabel];
        [self dioYongLable:priceLabel];
        
        nameLabel.frame=CGRectMake(0, (0+15+10)*i, 120, 15);
        fenShuLabel.frame=CGRectMake(120, (0+15+10)*i, 70, 15);
        priceLabel.frame=CGRectMake(200, (0+15+10)*i, 70, 15);
        
        priceLabel.textAlignment=2;
        fenShuLabel.textAlignment=2;
        
        nameLabel.text=[dic objectForKey:@"menu_name"];
        fenShuLabel.text=[NSString stringWithFormat:@"x%@份",[dic objectForKey:@"send_number_sum"]];
        priceLabel.text=[NSString stringWithFormat:@"%@元",[dic objectForKey:@"price"]];
        
        [_contenttView addSubview:nameLabel];
        [_contenttView addSubview:fenShuLabel];
        [_contenttView addSubview:priceLabel];
        _contenttView.sd_layout.heightIs( (0+15+10)*i+20);
    }

    
    
    
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
