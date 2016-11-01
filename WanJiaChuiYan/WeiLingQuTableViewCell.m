//
//  WeiLingQuTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WeiLingQuTableViewCell.h"
#import "CopyiPhoneFadeView.h"

@interface WeiLingQuTableViewCell()
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    UILabel * labelText;
    CopyiPhoneFadeView *iphoneFade;//闪动字体
}
@property(nonatomic,retain)UILabel * bianHaoLabel;//订单编号
@property(nonatomic,retain)UIImageView * daiLingImage;//替人领取

@property(nonatomic,retain)UIImageView * headImage;//头像
@property(nonatomic,retain)UILabel * addressLab;//地址
@property(nonatomic,retain)UIView * contenttview;//饭菜数组
@property(nonatomic,retain)UILabel * totalLabel;//共多少分
@property(nonatomic,retain)UILabel * payMoney;//支付多少钱
@property(nonatomic,retain)NSMutableArray * buttonArray;
@property(nonatomic,retain)NSMutableArray * fenshuArray;
@property(nonatomic,retain)NSMutableArray * priceArray;
@property(nonatomic,retain)UIImageView * weiLingDao;
@end
@implementation WeiLingQuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID  indexp:(NSIndexPath*)indepaxth{
   WeiLingQuTableViewCell * cell =[tableView cellForRowAtIndexPath:indepaxth];
   // WeiLingQuTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[WeiLingQuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    
    _buttonArray=[NSMutableArray new];
    _priceArray=[NSMutableArray new];
    _fenshuArray=[NSMutableArray new];
    _mTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressImage:)];
    _bianHaoLabel=[UILabel new];
    [self Label:_bianHaoLabel];
    //红色滚动
    _fadeStringView = [[FadeStringView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _fadeStringView.text = @"确认领取";
    _fadeStringView.foreColor = [UIColor whiteColor];
    _fadeStringView.backColor = [UIColor redColor];
    _fadeStringView.font = [UIFont systemFontOfSize:16];
    _fadeStringView.alignment = NSTextAlignmentCenter;
    [_fadeStringView fadeRightWithDuration:2];
    
    
    
    
    _daiLingImage=[[UIImageView alloc]init];
   
    _immediatelyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    _headImage=[[UIImageView alloc]init];
    
    _queRenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _weiLingQuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _weiLingDao=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weilingdao"]];
    _addressLab=[[UILabel alloc]init];
    _addressLab.font=[UIFont systemFontOfSize:16];
    _addressLab.alpha=.7;
    _contenttview=[[UIView alloc]init];
    _queRenBtn.backgroundColor=[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136 /255.0 alpha:1];
    _weiLingQuBtn.backgroundColor=[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136 /255.0 alpha:1];
    _fafangImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"发放凭证"]];
    
    _queRenBtn.hidden=YES;
     _weiLingQuBtn.hidden=YES;
    _totalLabel=[[UILabel alloc]init];
    [self Label:_totalLabel];
    _payMoney=[[UILabel alloc]init];
    [self Label:_payMoney];
    _queRenBtn.layer.cornerRadius=15;
    _queRenBtn.clipsToBounds=YES;
    _queRenBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_queRenBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_queRenBtn setTitle:@"已领到" forState:0];
    
    _weiLingQuBtn.layer.cornerRadius=15;
    _weiLingQuBtn.clipsToBounds=YES;
    _weiLingQuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_weiLingQuBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_weiLingQuBtn setTitle:@"未领到" forState:0];
    
    [self.contentView sd_addSubviews:@[_bianHaoLabel,_daiLingImage,_immediatelyBtn,_weiLingDao]];
  
    [self.contentView sd_addSubviews:@[_headImage,_addressLab,_contenttview]];
    
    [self.contentView sd_addSubviews:@[_totalLabel,_payMoney,_queRenBtn,_weiLingQuBtn,_fafangImage]];
  
    
  //   [_queRenBtn addSubview:_fadeStringView];
    //[_fadeStringView addGestureRecognizer:_mTap];
    
    [self frameZuoBiao];
    
}
-(void)setTagg:(NSInteger)tagg
{
    _tagg=tagg;
    _mTap.view.tag=tagg;
}
-(void)tapPressImage:(UITapGestureRecognizer*)tap{
    //[_delegate  tapChange:tap.view.tag];
    
    
}
-(void)frameZuoBiao{
   //订单编号
    _bianHaoLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,25)
    .heightIs(15);
    [_bianHaoLabel setSingleLineAutoResizeWithMaxWidth:300];
   //让人带领
    _daiLingImage.sd_layout
    .centerYEqualToView(_bianHaoLabel)
    .leftSpaceToView(_bianHaoLabel,10)
    .widthIs(122/2)
    .heightIs(32/2);
    //立即领取
    _immediatelyBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_bianHaoLabel)
    .widthIs(100)
    .heightIs(40);
    //头像
    _headImage.sd_layout
    .leftEqualToView(_bianHaoLabel)
    .topSpaceToView(_bianHaoLabel,20)
    .widthIs(60)
    .heightIs(60);
    //地址
    _addressLab.sd_layout
    .leftSpaceToView(_headImage,10)
    .topEqualToView(_headImage)
    .heightIs(15);
    [_addressLab setSingleLineAutoResizeWithMaxWidth:ScreenWidth-70-15];
   
    //contentView
    _contenttview.sd_layout
    .leftEqualToView(_addressLab)
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_addressLab,15);
//    //应付多少钱
    _payMoney.sd_layout
    .rightEqualToView(_contenttview)
    .topSpaceToView(_contenttview,15)
    .heightIs(20);
    [_payMoney setSingleLineAutoResizeWithMaxWidth:150];
    //共多少分
    _totalLabel.sd_layout
    .centerYEqualToView(_payMoney)
    .heightRatioToView(_payMoney,1)
    .rightSpaceToView(_payMoney,10);
     [_totalLabel setSingleLineAutoResizeWithMaxWidth:150];
    //已经领取到
    _queRenBtn.sd_layout
    .rightSpaceToView(self.contentView,30)
    .topSpaceToView(_totalLabel,15)
    .widthIs(220)
    .heightIs(30);
    //没有领到
    _weiLingQuBtn.sd_layout
    .centerYEqualToView(_queRenBtn)
    .widthIs(70)
    .heightIs(30)
    .rightSpaceToView(_queRenBtn,20);
    //发放凭证
    _fafangImage.hidden=YES;
    _fafangImage.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_bianHaoLabel)
    .widthIs(137/2)
    .heightIs(96/2);
    //未领到的标识符
    _weiLingDao.hidden=YES;
    _weiLingDao.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_bianHaoLabel)
    .widthIs(120/2)
    .heightIs(48/2);
    

    
    
    [self setupAutoHeightWithBottomView:_queRenBtn bottomMargin:15];

    
   
}






-(void)Label:(UILabel*)lab{
    
    lab.font=[UIFont systemFontOfSize:14];
    lab.textAlignment=1;
    lab.alpha=.5;
    lab.textColor=[UIColor blackColor];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(MyOrderModel *)model
{
    _model=model;
   // _contenttview.backgroundColor=[UIColor redColor];

    _bianHaoLabel.text=[NSString stringWithFormat:@"订单编号  %@",model.bianHao];
    [_headImage setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"head_pic"]];
    _addressLab.text=[NSString stringWithFormat:@"取餐点  %@",model.address];
   

    
    
    for (int i = 0; i<model.menuArray.count; i++) {
        NSDictionary * dic =model.menuArray[i];
        UILabel *  nameLabel =[UILabel new];//_buttonArray[i];
        UILabel * fenShuLabel=[UILabel new];//_fenshuArray[i];
        UILabel * priceLabel=[UILabel new];//_priceArray[i];;
        [self Label:nameLabel];
        [self Label:fenShuLabel];
        [self Label:priceLabel];
        
        nameLabel.frame=CGRectMake(0, (0+15+10)*i, 120, 15);
        fenShuLabel.frame=CGRectMake(120, (0+15+10)*i, 70, 15);
        priceLabel.frame=CGRectMake(200, (0+15+10)*i, 70, 15);
       
        
//        nameLabel.backgroundColor=[UIColor greenColor];
//        priceLabel.backgroundColor=[UIColor yellowColor];
//        fenShuLabel.backgroundColor=[UIColor blueColor];
        
        nameLabel.textAlignment=0;
        priceLabel.textAlignment=2;
        fenShuLabel.textAlignment=2;
       
        nameLabel.text=[dic objectForKey:@"menu_name"];
        fenShuLabel.text=[NSString stringWithFormat:@"x%@份",[dic objectForKey:@"send_number_sum"]];
        priceLabel.text=[NSString stringWithFormat:@"%@元",[dic objectForKey:@"price"]];
        
        [_contenttview addSubview:nameLabel];
        [_contenttview addSubview:fenShuLabel];
       // [_contenttview addSubview:priceLabel];每份的价格注释了
        _contenttview.sd_layout.heightIs( (0+15+10)*i+20);
    }

    _totalLabel.text=[NSString stringWithFormat:@"共%@份",model.fenshu];
    _payMoney.text=[NSString stringWithFormat:@"实付¥%@",model.payMoney];
//谁的饭
    if ([model.lingquStyle isEqualToString:@"1"]) {
        //自己的饭
        _daiLingImage.image=[UIImage imageNamed:@"ziji(1)"];
    }else if ([model.lingquStyle isEqualToString:@"2"]){
        //已让人带领
        _daiLingImage.image=[UIImage imageNamed:@"dingdan_bt_zi"];
        _immediatelyBtn.hidden=YES;
    }else if ([model.lingquStyle isEqualToString:@"3"]){
        //别人的饭
        _daiLingImage.image=[UIImage imageNamed:@"tirendailing"];
    }
//领取的状态
    if ([model.jieShouStyle isEqualToString:@"0"]) {
        // 0.未点击立即领取
         [_immediatelyBtn setImage:[UIImage imageNamed:@"lijilingqu_green"] forState:0];
         [_immediatelyBtn setImage:[UIImage imageNamed:@"lingcanzhong"] forState:UIControlStateSelected];
         self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    }else if ([model.jieShouStyle isEqualToString:@"1"]){
        // 1.领取中
         [_immediatelyBtn setImage:[UIImage imageNamed:@"lingcanzhong"] forState:0];
         [_immediatelyBtn setImage:[UIImage imageNamed:@"lingcanzhong"] forState:UIControlStateSelected];
        _immediatelyBtn.enabled=NO;
        _immediatelyBtn.hidden=YES;
        _fafangImage.hidden=NO;
        self.backgroundColor=[UIColor whiteColor];
        _queRenBtn.hidden=NO;
        _weiLingQuBtn.hidden=NO;
    }else if ([model.jieShouStyle isEqualToString:@"2"]){
        //2.已领取
        _immediatelyBtn.hidden=YES;
    }else if ([model.jieShouStyle isEqualToString:@"3"]){
        //3.未领到
        _weiLingDao.hidden=NO;
        _daiLingImage.image=[UIImage imageNamed:@"ziji(1)"];
    }
    
    
   
    
}
-(void)timeBtnn:(UIButton*)btn{
//    secondsCountDown = 60*10;//60秒倒计时
//    //开始倒计时
//    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    //设置倒计时显示的时间
   // NSString * timee=[NSString stringWithFormat:@"支付剩余时间%@秒",[self timeFormatted:secondsCountDown]];
    
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}

@end
