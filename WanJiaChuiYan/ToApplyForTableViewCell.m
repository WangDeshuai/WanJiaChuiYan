//
//  ToApplyForTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ToApplyForTableViewCell.h"

@interface ToApplyForTableViewCell ()

@property(nonatomic,retain)UIImageView * leftImage;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * distenceLabel;
@property(nonatomic,retain)UILabel * accountLabel;
@property(nonatomic,retain)UILabel * phoneLabel;
@property(nonatomic,retain)UIView  * view1;
@property(nonatomic,retain)UIView  * view2;

@end


@implementation ToApplyForTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    ToApplyForTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ToApplyForTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _leftImage=[UIImageView new];
    _titleLabel=[UILabel new];
   // _distenceLabel=[UILabel new];
    _accountLabel=[UILabel new];
   // _phoneLabel=[UILabel new];
//    _view1=[UIView new];
//    _view2=[UIView new];
    
    _leftImage.layer.cornerRadius=5;
    _leftImage.clipsToBounds=YES;
    
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _titleLabel.alpha=.8;
    _titleLabel.textAlignment=0;
    
    _accountLabel.font=[UIFont systemFontOfSize:14];
    _accountLabel.alpha=.6;
    _accountLabel.textAlignment=0;
//
//    _phoneLabel.font=[UIFont systemFontOfSize:14];
//    _phoneLabel.alpha=.6;
//    _phoneLabel.textAlignment=0;
//
//    _distenceLabel.font=[UIFont systemFontOfSize:14];
//    _distenceLabel.alpha=.6;
//    _distenceLabel.textAlignment=0;
    
    
    _zhiChitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_zhiChitBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
     [_zhiChitBtn setImage:[UIImage imageNamed:@"dianzan_click"] forState:UIControlStateSelected];
    [_zhiChitBtn setTitle:@"支持" forState:0];
    
    [_zhiChitBtn setTitleColor:[UIColor colorWithRed:126/255.0 green:126/255.0 blue:112/255.0 alpha:1] forState:0];
    _zhiChitBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView sd_addSubviews:@[_zhiChitBtn]];
    [_zhiChitBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0, 0, -30)];
    [_zhiChitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -20, 0)];
//
//    _numberBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [_numberBtn setImage:[UIImage imageNamed:@"zhichi"] forState:UIControlStateNormal];
//   
//    _numberBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    [_numberBtn setImageEdgeInsets:UIEdgeInsetsMake(0,-5, 0, 0)];
//    [_numberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
//    
//    
//    [_numberBtn setTitleColor:[UIColor blackColor] forState:0];
//    [_zhiChitBtn setTitleColor:[UIColor blackColor] forState:0];
//    _numberBtn.titleLabel.alpha=.6;
//    _zhiChitBtn.titleLabel.alpha=.6;
//    [_view1 sd_addSubviews:@[_numberBtn]];
//    
//
    _zhiChitBtn.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(25)
    .heightIs(40);
    
//
//    _numberBtn.sd_layout
//    .leftSpaceToView(_view1,0)
//    .rightSpaceToView(_view1,0)
//    .topSpaceToView(_view1,0)
//    .bottomSpaceToView(_view1,0);
    
    
    
   // [self.contentView sd_addSubviews:@[_leftImage,_titleLabel,_distenceLabel,_accountLabel,_phoneLabel,_view1,_view2]];
     [self.contentView sd_addSubviews:@[_leftImage,_titleLabel,_accountLabel]];
    
    
    
    
    
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(50)
    .heightIs(50);
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(_leftImage,10)
    .topEqualToView(_leftImage)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    _accountLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .heightIs(20)
    .topSpaceToView(_titleLabel,10);
    [_accountLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
//
//    _phoneLabel.sd_layout
//    .leftEqualToView(_accountLabel)
//    .heightRatioToView(_accountLabel,1)
//    .widthRatioToView(_accountLabel,1)
//    .topSpaceToView(_accountLabel,10);
//    
//    _distenceLabel.sd_layout
//    .rightSpaceToView(self.contentView,15)
//    .centerYEqualToView(_titleLabel)
//    .heightIs(15);
//    [_distenceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    
    
//    _view1.sd_layout
//    .leftSpaceToView(self.contentView,0)
//    .topSpaceToView(_leftImage,20)
//    .widthIs(ScreenWidth/2)
//    .heightIs(30);
//   
//    _view2.sd_layout
//    .rightSpaceToView(self.contentView,0)
//    .topEqualToView(_view1)
//    .widthRatioToView(_view1,1)
//    .heightRatioToView(_view1,1);
    
}
-(void)setModel:(ToApplyForModel *)model
{
    _model=model;
    
    _titleLabel.text=[NSString stringWithFormat:@"小站地址:%@",model.address];   // model.titleName;
    _accountLabel.text=@"这里建个小站不错，取餐更方便了！";//model.account;
    _phoneLabel.text=[NSString stringWithFormat:@"站长账号:%@",model.phoneNumber];//model.phoneNumber;
    _distenceLabel.text=model.distance;
    [_leftImage setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"head_pic"]];
    NSString * zhichi =[NSString stringWithFormat:@"已有%@人支持",model.praiseNumber];
    [_numberBtn setTitle:zhichi forState:0];
    
    if (model.isMyself==YES) {
        _zhiChitBtn.selected=YES;
    }else{
        _zhiChitBtn.selected=NO;
    }
}

#pragma mark -- 重新cell frame
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
@end
