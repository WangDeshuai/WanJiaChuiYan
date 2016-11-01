//
//  ShouCaiTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShouCaiTableViewCell.h"
@interface ShouCaiTableViewCell()
@property(nonatomic,retain)UILabel * phoneNumber;
@property(nonatomic,retain)UILabel * titleLable;
@property(nonatomic,retain)UIView * contenttView;
@property(nonatomic,retain)UILabel * totalLable;
@property(nonatomic,retain)UILabel * payMoney;
@end
@implementation ShouCaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID index:(NSIndexPath*)indepath
{
    ShouCaiTableViewCell * cell =[tableView  cellForRowAtIndexPath:indepath];
    if (!cell) {
        cell=[[ShouCaiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titleLable=[UILabel new];
    _shiShouBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _contenttView=[UIView new];
    
    [self dioYongLable:_phoneNumber];
    _titleLable.alpha=.8;
    _titleLable.font=[UIFont systemFontOfSize:15];
    _titleLable.textColor=[UIColor blackColor];
    _titleLable.textAlignment=0;
  //  _contenttView.backgroundColor=[UIColor redColor];
    
    
//    _phoneNumber.text=@"联系电话 15032735032";
//    _titleLable.text=@"厨房地址 广安大街安桥商务";
   
    
    [_shiShouBtn setBackgroundImage:[UIImage imageNamed:@"shishou"] forState:0];
    
    [self.contentView sd_addSubviews:@[_phoneNumber,_titleLable,_shiShouBtn,_contenttView]];
    
    _phoneNumber.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,15)
    .heightIs(15);
    [_phoneNumber setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

    _titleLable.sd_layout
    .leftEqualToView(_phoneNumber)
    .heightIs(20)
    .topSpaceToView(_phoneNumber,15);
    [_titleLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    _shiShouBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_phoneNumber)
    .heightIs(44/2)
    .widthIs(104/2);
    
    
    
    _contenttView.sd_layout
    .leftEqualToView(_titleLable)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_titleLable,10);
    
   
    
    
    
    
    
    _totalLable=[UILabel new];
    _payMoney=[UILabel new];
    [self dioYongLable:_totalLable];
    [self dioYongLable:_payMoney];
    _totalLable.font=[UIFont systemFontOfSize:15];
    _payMoney.font=[UIFont systemFontOfSize:15];
    _totalLable.alpha=.7;
    _payMoney.alpha=.7;
    
    [self.contentView sd_addSubviews:@[_totalLable,_payMoney]];
    _payMoney.sd_layout
    .rightEqualToView(_contenttView)
    .topSpaceToView(_contenttView,20)
    .heightIs(15);
    [_payMoney setSingleLineAutoResizeWithMaxWidth:250];
    
    _totalLable.sd_layout
    .rightSpaceToView(_payMoney,15)
    .topEqualToView(_payMoney)
    .heightRatioToView(_payMoney,1);
     [_totalLable setSingleLineAutoResizeWithMaxWidth:250];
    
    [self setupAutoHeightWithBottomView:_totalLable bottomMargin:10];
    
}


-(void)setModel:(ShouFanCaiModel *)model
{
    _model=model;
    _phoneNumber.text=[NSString stringWithFormat:@"联系电话  %@",model.phoneNumber];//@"联系电话 15032735032";
    _titleLable.text=[NSString stringWithFormat:@"厨房地址  %@",model.address];
    _totalLable.text=[NSString stringWithFormat:@"共计%@份",model.fenShu];//@"共150份";
    _payMoney.text=[NSString stringWithFormat:@"总计¥%@",model.price];//@"总计¥95.00";
  
    
    for (int i = 0; i<model.menuArray.count; i++) {
        NSDictionary * dic =model.menuArray[i];
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
@end
