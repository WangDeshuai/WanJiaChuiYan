//
//  LingQuTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LingQuTableViewCell.h"
@interface LingQuTableViewCell()
{

    NSMutableArray * _tucaoArray;
    NSMutableArray * _tuijianArray;
    NSMutableArray * _fenShuArray;
    NSMutableArray * _manyiArray;
}
@property(nonatomic,retain)UILabel * label1;
@property(nonatomic,retain)UILabel * label2;
@property(nonatomic,retain)UILabel * label3;

@property(nonatomic,retain)UILabel * bianHao;
@property(nonatomic,retain)UILabel * address;
@property(nonatomic,retain)UILabel *xiangQing;
@property(nonatomic,retain)UILabel * totalLabel;

@property(nonatomic,retain)UIView * lineView1;

@property(nonatomic,retain)UIView  * contentviews;
@property(nonatomic,retain)UILabel * tishi;

@end
@implementation LingQuTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID index:(NSIndexPath*)indepath{
    LingQuTableViewCell * cell =[tableView cellForRowAtIndexPath:indepath];
    if (!cell) {
        cell=[[LingQuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _label1=[UILabel new];
    _label2=[UILabel new];
    _label3=[UILabel new];
    _lineView1=[UIView new];
    _label1.font=[UIFont systemFontOfSize:15];
    _label2.font=[UIFont systemFontOfSize:15];
    _label3.font=[UIFont systemFontOfSize:15];
    _label1.alpha=.7;
    _label2.alpha=.7;
    _label3.alpha=.7;
    _label1.text=@"订单编号";
    _label2.text=@"取餐地点";
    _label3.text=@"订单详情";
    
    [self.contentView sd_addSubviews:@[_label1,_label2,_label3,_lineView1]];
    
    _tucaoArray=[NSMutableArray new];
    _tuijianArray=[NSMutableArray new];
    _fenShuArray=[NSMutableArray new];
    _manyiArray=[NSMutableArray new];
    
    
    _label1.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [_label1 setSingleLineAutoResizeWithMaxWidth:100];
    
    _label2.sd_layout
    .leftEqualToView(_label1)
    .widthRatioToView(_label1,1)
    .heightRatioToView(_label1,1)
    .topSpaceToView(_label1,15);
    
    _label3.sd_layout
    .leftEqualToView(_label1)
    .widthRatioToView(_label1,1)
    .heightRatioToView(_label1,1)
    .topSpaceToView(_label2,15);
  //编号、地点、详情
    _bianHao=[UILabel new];
    _address=[UILabel new];
    _xiangQing=[UILabel new];
    _totalLabel=[UILabel new];
     _tishi=[UILabel new];
    _bianHao.alpha=.5;
    _address.alpha=.5;
    _xiangQing.alpha=.5;
    _bianHao.font=[UIFont systemFontOfSize:14];
    _address.font=[UIFont systemFontOfSize:14];
    _xiangQing.font=[UIFont systemFontOfSize:14];
    
    _totalLabel.font=[UIFont systemFontOfSize:15];
    _totalLabel.alpha=.6;
    _contentviews=[UIView new];
    
   
    
   

  
    NSString * text=@"温馨提示:\n我们把满意键设计的特别小，其它键设计大点希望您提出宝贵的意见";
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _tishi.attributedText=string;
    _tishi.numberOfLines=0;
    _tishi.font=[UIFont systemFontOfSize:15];
    _tishi.alpha=.5;
    _tishi.textAlignment=1;
    _tishi.isAttributedContent = YES;
  
    [self.contentView sd_addSubviews:@[_bianHao,_address,_xiangQing,_totalLabel,_contentviews,_tishi]];
    
    
    _bianHao.sd_layout
    .centerYEqualToView(_label1)
    .heightRatioToView(_label1,1)
    .leftSpaceToView(_label1,15);
    [_bianHao setSingleLineAutoResizeWithMaxWidth:300];
    
    _address.sd_layout
    .centerYEqualToView(_label2)
    .heightRatioToView(_label2,1)
    .leftEqualToView(_bianHao);
    [_address setSingleLineAutoResizeWithMaxWidth:300];
    
    _xiangQing.sd_layout
    .centerYEqualToView(_label3)
    .heightRatioToView(_label3,1)
    .leftEqualToView(_address);
    [_xiangQing setSingleLineAutoResizeWithMaxWidth:300];
    
    _totalLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_label3)
    .heightRatioToView(_label3,1);
    [_totalLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    _lineView1.backgroundColor=[UIColor blackColor];
    _lineView1.alpha=.5;
    _lineView1.sd_layout
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15)
    .heightIs(1)
    .topSpaceToView(_totalLabel,5);
    
    _contentviews.sd_layout
    .leftEqualToView(_label1)
    .heightIs(100)
    .topSpaceToView(_xiangQing,10)
    .rightSpaceToView(self.contentView,10);
    
    _tishi.sd_layout
    .topSpaceToView(_contentviews,0)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .autoHeightRatio(0);
    
    
    [self setupAutoHeightWithBottomView:_tishi bottomMargin:10];
    
    
    
}
-(void)setModel:(MyOrderModel *)model
{
    _model=model;
    _bianHao.text=model.Ybianhao;
    _address.text=model.Yaddress;
    _xiangQing.text=model.Yxiangqing;
    _totalLabel.text=[NSString stringWithFormat:@"总计:%@元",model.Ypaymoney];
//   _contentviews.backgroundColor=[UIColor redColor];
    for (int i = 0; i<model.Ymenuarray.count; i++) {
        NSDictionary * dic =model.Ymenuarray[i];
        /*
         1.满意
         2.份量少
         3.价格贵
         4.味道差
         0,没有
         */
        NSString * tujianMa =[NSString stringWithFormat:@"%@",[dic objectForKey:@"grade_status"]];//   ;
        UILabel *  nameLabel =[UILabel new];
       [self Label:nameLabel];
        
        UIView * lineView =[UIView new];
        UIButton * jiagegui =[UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * weidaocha   =[UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * manyi =[UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * fenshu =[UIButton buttonWithType:UIButtonTypeCustom];
        [_contentviews sd_addSubviews:@[lineView,nameLabel,jiagegui,weidaocha,manyi,fenshu]];
        //菜名
        nameLabel.sd_layout
        .centerXEqualToView(_contentviews)
        .heightIs(15)
        .topSpaceToView(_contentviews,(10+25+30)*i);
        [nameLabel setSingleLineAutoResizeWithMaxWidth:200];

        if ([tujianMa isEqualToString:@"0"]) {
            jiagegui.selected=NO;
            weidaocha.selected=NO;
            fenshu.selected=NO;
            manyi.selected=NO;
        }else if ([tujianMa isEqualToString:@"1"]){
            //满意
            manyi.selected=YES;
        }else  if ([tujianMa isEqualToString:@"2"]){
            fenshu.selected=YES;
        }else  if ([tujianMa isEqualToString:@"3"]){
            jiagegui.selected=YES;
        }else{
            weidaocha.selected=YES;
        }
       //满意
        manyi.sd_layout
        .leftSpaceToView(_contentviews,15)
        .centerYEqualToView(weidaocha)
        .widthIs(45)
        .heightIs(20);
        //味道差
        weidaocha.sd_layout
        .topSpaceToView(nameLabel,15)
        .widthIs(157/2)
        .heightIs(40/2)
        .rightSpaceToView(_contentviews,0);
        //价格贵
        jiagegui.sd_layout
        .centerYEqualToView(weidaocha)
        .widthIs(157/2)
        .heightIs(40/2)
       .rightSpaceToView(weidaocha,10);
        //份数少
        fenshu.sd_layout
        .rightSpaceToView(jiagegui,10)
        .centerYEqualToView(jiagegui)
        .widthIs(157/2)
        .heightIs(20);
       
        //线条
        lineView.backgroundColor=[UIColor blackColor];
        lineView.alpha=.5;
        lineView.sd_layout
        .topSpaceToView(fenshu,10)
        .leftSpaceToView(_contentviews,0)
        .rightSpaceToView(_contentviews,0)
        .heightIs(1);
        
        
        
        //味道差
        [weidaocha setImage:[UIImage imageNamed:@"weidaocha"] forState:0];
        [weidaocha setImage:[UIImage imageNamed:@"weidaochas"] forState:UIControlStateSelected];
        //价格贵
        [jiagegui setImage:[UIImage imageNamed:@"jiagegui"] forState:0];
        [jiagegui setImage:[UIImage imageNamed:@"jiageguis"] forState:UIControlStateSelected];
        //份数少
        [fenshu setImage:[UIImage imageNamed:@"fenliangshao"] forState:0];
        [fenshu setImage:[UIImage imageNamed:@"fenliangshaos"] forState:UIControlStateSelected];
        //满意
        [manyi setImage:[UIImage imageNamed:@"manyi"] forState:0];
        [manyi setImage:[UIImage imageNamed:@"manyis"] forState:UIControlStateSelected];
        
        jiagegui.tag=i;
        weidaocha.tag=i;
        fenshu.tag=i;
        manyi.tag=i;
        [jiagegui addTarget:self action:@selector(tuijian:) forControlEvents:UIControlEventTouchUpInside];
        [weidaocha addTarget:self action:@selector(tucao:) forControlEvents:UIControlEventTouchUpInside];
        [fenshu addTarget:self action:@selector(fenshus:) forControlEvents:UIControlEventTouchUpInside];
        [manyi addTarget:self action:@selector(manyis:) forControlEvents:UIControlEventTouchUpInside];
        
        
        nameLabel.text=[NSString stringWithFormat:@"%@/%@份",[dic objectForKey:@"menu_name"],[dic objectForKey:@"send_number_sum"]];

       
        [_tuijianArray addObject:jiagegui];
        [_tucaoArray addObject:weidaocha];
        [_fenShuArray addObject:fenshu];
        [_manyiArray addObject:manyi];
        _contentviews.sd_layout.heightIs( (0+35+60)*i+10);
    }
       
}
 //价格贵
-(void)tuijian:(UIButton*)btn{
   // NSLog(@"小站ID>>%@",_model.YxiaoZhanID);
    UIButton* weidao=  _tucaoArray[btn.tag];
    weidao.selected=NO;
    UIButton* fenshu=  _fenShuArray[btn.tag];
    fenshu.selected=NO;
    UIButton* manyi=  _manyiArray[btn.tag];
    manyi.selected=NO;
    btn.selected=YES;
    NSDictionary * dic =_model.Ymenuarray[btn.tag];
    [Engine pingjiaMenuDingDanHao:_bianHao.text ChuID:[dic objectForKey:@"kitchen_id"] XiaoZhanID:_model.YxiaoZhanID MenuID:[dic objectForKey:@"menu_id"] tuiJian:@"3" success:^(NSDictionary *dic) {
        
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        
    } error:^(NSError *error) {
        
    }];
    
}
 //味道差
-(void)tucao:(UIButton*)btn{
  
   
    UIButton* jiage=  _tuijianArray[btn.tag];
    jiage.selected=NO;
    UIButton* fenshu=  _fenShuArray[btn.tag];
    fenshu.selected=NO;
    UIButton* manyi=  _manyiArray[btn.tag];
    manyi.selected=NO;
    
    NSDictionary * dic =_model.Ymenuarray[btn.tag];
    btn.selected=YES;
    [Engine pingjiaMenuDingDanHao:_bianHao.text ChuID:[dic objectForKey:@"kitchen_id"] XiaoZhanID:_model.YxiaoZhanID MenuID:[dic objectForKey:@"menu_id"] tuiJian:@"4" success:^(NSDictionary *dic) {
         [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
    } error:^(NSError *error) {
        
    }];
    
    
    
}
//份数少
-(void)fenshus:(UIButton*)btn{
    UIButton* jiage=  _tuijianArray[btn.tag];
    jiage.selected=NO;
    UIButton* weidao=  _tucaoArray[btn.tag];
    weidao.selected=NO;
    UIButton* manyi=  _manyiArray[btn.tag];
    manyi.selected=NO;
    btn.selected=YES;
    NSDictionary * dic =_model.Ymenuarray[btn.tag];
    [Engine pingjiaMenuDingDanHao:_bianHao.text ChuID:[dic objectForKey:@"kitchen_id"] XiaoZhanID:_model.YxiaoZhanID MenuID:[dic objectForKey:@"menu_id"] tuiJian:@"2" success:^(NSDictionary *dic) {
        
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        
    } error:^(NSError *error) {
        
    }];
    
}
//满意
-(void)manyis:(UIButton*)btn{
    UIButton* jiage=  _tuijianArray[btn.tag];
    jiage.selected=NO;
    UIButton* weidao=  _tucaoArray[btn.tag];
    weidao.selected=NO;
    UIButton* fenshu=  _fenShuArray[btn.tag];
    fenshu.selected=NO;
    btn.selected=YES;
    NSDictionary * dic =_model.Ymenuarray[btn.tag];
    [Engine pingjiaMenuDingDanHao:_bianHao.text ChuID:[dic objectForKey:@"kitchen_id"] XiaoZhanID:_model.YxiaoZhanID MenuID:[dic objectForKey:@"menu_id"] tuiJian:@"1" success:^(NSDictionary *dic) {
        
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        
    } error:^(NSError *error) {
        
    }];
    
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
-(void)Label:(UILabel*)lab{
    
    lab.font=[UIFont systemFontOfSize:14];
    lab.textAlignment=1;
    lab.alpha=.6;
    lab.textColor=[UIColor blackColor];
    
}
@end
