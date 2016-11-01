//
//  BuyTablewareViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BuyTablewareViewController.h"
#import "OrderTableViewCell.h"
#import "OrderTableViewModel.h"
#import "PayStyeDaFan.h"
@interface BuyTablewareViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * imageLeft ;
    UIButton * btnRight;
    CopyiPhoneFadeView *iphoneFade;
    UILabel * nameLabel;
    UIImageView * image1;
    UILabel * distance;
    UILabel * label1;
    UIImageView * image2;
    UILabel * label2;
    UITapGestureRecognizer *mTap;
    UIView * view5;
}
@property(nonatomic,assign)BOOL isOpenTableView;
@property(nonatomic,retain)UIScrollView * bgScrollview;
@property(nonatomic,retain)UIImageView * image11;
@property(nonatomic,retain)UIView * view2;
@property(nonatomic,retain)UIView * view3;
@property(nonatomic,retain)UIView * view4;
@property(nonatomic,retain)UIButton * buyBtn;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * firstArray;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation BuyTablewareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
   // [self.navigationItem setTitle:@"购买餐具"];
    self.title=@"购买餐具";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _firstArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    [self CreatScrellover];
    [self Creatview1];
    [self CreatView2];
    [self CreatView3];
    [self CreatView4];
    [self buyButton];
    [self Creatinit];
    [self tableviewData];
   // [self initView1];
}

-(void)CreatScrellover{
    
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    _bgScrollview.backgroundColor=[UIColor clearColor];
   // _bgScrollview.contentSize=CGSizeMake(ScreenWidth, ScreenHeight);
    [self.view addSubview:_bgScrollview];
    
}
-(void)Creatview1{
    _image11 =[UIImageView new];
    _image11.image=[UIImage imageNamed:@"canjv_banner"];
    [_bgScrollview sd_addSubviews:@[_image11]];
    _image11.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_bgScrollview,10)
    .heightIs(375*327/750);
    
}

-(void)CreatView2
{
    _view2=[[UIView alloc]init];
    _view2.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_image11,10);
    //标题
    UILabel * titleLabel =[UILabel new];
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.alpha=.6;
    titleLabel.text=@"不锈钢(筷子+勺子)组合套装";
    titleLabel.numberOfLines=0;
    [_view2 sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,5)
    .rightSpaceToView(_view2,50)
    .autoHeightRatio(0);
    //价格
    UILabel * priceLabel=[[UILabel alloc]init];
    priceLabel.textColor=[UIColor colorWithRed:82/255.0 green:236/255.0 blue:135/255.0 alpha:1];
    priceLabel.font=[UIFont systemFontOfSize:27];
    priceLabel.text=@"¥5";
    [_view2 sd_addSubviews:@[priceLabel]];
    priceLabel.sd_layout
    .leftEqualToView(titleLabel)
    .topSpaceToView(titleLabel,10)
    .heightIs(30);
    [priceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    //万家春燕专享特价
    UIImageView * image22 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"canjv_bt2-1"]];
    [_view2 sd_addSubviews:@[image22]];
    image22.sd_layout
    .leftSpaceToView(priceLabel,10)
    .centerYEqualToView(priceLabel)
    .widthIs(224/2)
    .heightIs(28/2);
    
    //免费攻略
    UIButton * gongLueBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [gongLueBtn addTarget:self action:@selector(gongbtn) forControlEvents:UIControlEventTouchUpInside];
    [gongLueBtn setImage:[UIImage imageNamed:@"buy_gonglue "] forState:0];
    [_view2 sd_addSubviews:@[gongLueBtn]];
    gongLueBtn.sd_layout
    .rightSpaceToView(_view2,30)
    .topSpaceToView(_view2,0)
    .widthIs(80)
    .heightIs(80);
    
    
    [_view2 setupAutoHeightWithBottomView:gongLueBtn bottomMargin:0];
    
    
}
#pragma mark --免费攻略点击事件
-(void)gongbtn{
    UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"" message:@"新用户注册时填写推广码得3元粮票，\n注册成功后\n以老用户身份推广新用户得2元粮票\n此时粮票余额等于购买餐具余额" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController removeFromParentViewController];
    }];
    [alertController addAction:action];
    
}


-(void)CreatView3{
    _view3=[[UIView alloc]init];
    _view3.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view3]];
    _view3.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .heightIs(44)
    .topSpaceToView(_view2,5);
    //领取
    UIImageView * image4 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"canjv_bt3"]];
    [_view3 sd_addSubviews:@[image4]];
    image4.sd_layout
    .leftSpaceToView(_view3,10)
    .widthIs(64/2)
    .heightIs(28/2)
    .centerYEqualToView(_view3);
    //温馨提示
    UILabel * tishi=[[UILabel alloc]init];
    tishi.font=[UIFont systemFontOfSize:14];
    tishi.alpha=.6;
    tishi.text=@"温馨提示：从以下附近站点选择您最近的取餐点";
    [_view3 sd_addSubviews:@[tishi]];
    
    tishi.sd_layout
    .leftSpaceToView(image4,10)
    .centerYEqualToView(image4)
    .heightRatioToView(image4,1);
    [tishi setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
}
-(void)CreatView4{
    _view4=[[UIView alloc]init];
    _view4.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view4]];
    _view4.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .heightIs(44)
    .topSpaceToView(_view3,10);
    
    UILabel * labeAddress =[[UILabel alloc]init];
    labeAddress.text=@"请选择您的领取地点";
    labeAddress.font=[UIFont systemFontOfSize:16];
    labeAddress.alpha=.7;
    [_view4 sd_addSubviews:@[labeAddress]];
    labeAddress.sd_layout
    .leftSpaceToView(_view4,15)
    .centerYEqualToView(_view4)
    .heightIs(20);
    [labeAddress setSingleLineAutoResizeWithMaxWidth:ScreenWidth-150];
    
}
#pragma mark --立即购买按钮创建
-(void)buyButton{
    _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buyBtn setBackgroundImage:[UIImage imageNamed:@"canjv_buy"] forState:0];
    [_buyBtn addTarget:self action:@selector(gouMai) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[_buyBtn]];//75 10
    _buyBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50);
    [_bgScrollview bringSubviewToFront:_buyBtn];
}

#pragma mark --解析表的数据
-(void)tableviewData{
    // [LCProgressHUD showLoading:@"数据加载中..."];
    
    NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    NSMutableDictionary * cityZuoBiao =[XYString duquPlistWenJianPlistName:@"cityDingWeiZuoBiao"];
    
    if (cityName==nil || cityZuoBiao==nil) {
        [LCProgressHUD showMessage:@"请先选择地区"];
        return;
    }
    
   
    [Engine daFanQuCanDianJingDu:[cityZuoBiao objectForKey:@"jingDu"] WeiDu:[cityZuoBiao objectForKey:@"WeiDu"] Sheng:[cityName objectForKey:@"shengName"] City:[cityName objectForKey:@"cityName"] success:^(NSDictionary *dic) {
        
        if ([dic objectForKey:@"content"]==[NSNull null]) {
            
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            return ;
        }
        NSDictionary * dicConten =[dic objectForKey:@"content"];
        if ([dicConten objectForKey:@"binded_Station"]==[NSNull null]||[[dicConten objectForKey:@"binded_Station"] count]==0 ) {
            
        }else{
            NSDictionary * bangDic =[dicConten objectForKey:@"binded_Station"];
            OrderTableViewModel * model2 =[[OrderTableViewModel alloc]initWithDic:bangDic];
            [_firstArray addObject:model2];
            
        }
        [self initView1];
        if ([dicConten objectForKey:@"near_StationList"]==[NSNull null] ||[[dicConten objectForKey:@"near_StationList"] count]==0 ) {
            NSLog(@"2222223121");
        }else{
            NSLog(@"adfadfdaf");
            NSArray * arrFujin =[dicConten objectForKey:@"near_StationList"];
            for (NSDictionary * dicc in arrFujin) {
                OrderTableViewModel * model =[[OrderTableViewModel alloc]initWithDic:dicc];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
        
        
    } error:^(NSError *error) {
        
    }];
}




#pragma mark --创建表的第一行
-(void)Creatinit{
    view5 =[UIView new];
    imageLeft=[UIImageView new];
    btnRight=[UIButton buttonWithType:UIButtonTypeCustom];
    iphoneFade =[[CopyiPhoneFadeView alloc]initWithFrame:CGRectMake((100*103/196-100*103/196/2)/2, 1, 100*103/196/2, 80)];
    nameLabel =[UILabel new];
    image1 =[[UIImageView alloc]init];
    distance=[UILabel new];
    label1=[UILabel new];;
    image2 =[UIImageView new];
    label2 =[UILabel new];
    mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressImage:)];
}
-(void)initView1{
   
    
    NSLog(@"有没有%lu",_firstArray.count);
    if (_firstArray.count==0 || _firstArray==nil) {
        
        [LCProgressHUD showMessage:@"请先选取您的取餐点"];
        view5.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [_bgScrollview sd_addSubviews:@[view5]];
        view5.sd_layout
        .topSpaceToView(_view4,0)
        .leftSpaceToView(_bgScrollview,0)
        .rightSpaceToView(_bgScrollview,0)
        .heightIs(100); btnRight.backgroundColor=[UIColor greenColor];
        [btnRight setBackgroundImage:[UIImage imageNamed:@"near2"] forState:0];
        [view5 sd_addSubviews:@[btnRight]];
        [btnRight addTarget:self action:@selector(btnRight:) forControlEvents:UIControlEventTouchUpInside];
        btnRight.sd_layout
        .rightSpaceToView(view5,0)
        .topSpaceToView(view5,0)
        .bottomSpaceToView(view5,0)
        .widthIs(100*103/196);//图片的宽高比是103/196
        
        
        
        
        
        // iphoneFade.backgroundColor=[UIColor yellowColor];
        iphoneFade.userInteractionEnabled=YES;
        iphoneFade.text = @"附近站点";
        iphoneFade.foreColor = [UIColor redColor];//[UIColor colorWithRed:120/255.0 green:228/255.0 blue:236/255.0 alpha:1];
        iphoneFade.backColor = [UIColor whiteColor];
        iphoneFade.font = [UIFont systemFontOfSize:16];
        iphoneFade.alignment = NSTextAlignmentCenter;
        [btnRight addSubview:iphoneFade];
        [iphoneFade iPhoneFadeWithDuration:4];
        
        //imageview1添加手势
        
        [iphoneFade addGestureRecognizer:mTap];

        
        return;
    }
    
    OrderTableViewModel * md=_firstArray[0];
    
    view5.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [_bgScrollview sd_addSubviews:@[view5]];
    view5.sd_layout
    .topSpaceToView(_view4,0)
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .heightIs(100);
    //左边图片
   // imageLeft.image=[UIImage imageNamed:@"pic1"];//到时候换成网络图片
   [imageLeft setImageWithURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"pic1"]];
    [view5 sd_addSubviews:@[imageLeft]];
    imageLeft.sd_layout
    .leftSpaceToView(view5,10)
    .topSpaceToView(view5,10)
    .bottomSpaceToView(view5,10)
    .widthIs(80);
    
    //右边button
    
    
    btnRight.backgroundColor=[UIColor greenColor];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"near2"] forState:0];
    [view5 sd_addSubviews:@[btnRight]];
    [btnRight addTarget:self action:@selector(btnRight:) forControlEvents:UIControlEventTouchUpInside];
    btnRight.sd_layout
    .rightSpaceToView(view5,0)
    .topSpaceToView(view5,0)
    .bottomSpaceToView(view5,0)
    .widthIs(100*103/196);//图片的宽高比是103/196
    
    
    
    
    
    // iphoneFade.backgroundColor=[UIColor yellowColor];
    iphoneFade.userInteractionEnabled=YES;
    iphoneFade.text = @"附近站点";
    iphoneFade.foreColor = [UIColor redColor];//[UIColor colorWithRed:120/255.0 green:228/255.0 blue:236/255.0 alpha:1];
    iphoneFade.backColor = [UIColor whiteColor];
    iphoneFade.font = [UIFont systemFontOfSize:16];
    iphoneFade.alignment = NSTextAlignmentCenter;
    [btnRight addSubview:iphoneFade];
    [iphoneFade iPhoneFadeWithDuration:4];
    
    //imageview1添加手势
    
    [iphoneFade addGestureRecognizer:mTap];
    
    
    //Name
    
    nameLabel.font=[UIFont systemFontOfSize:16];
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.textAlignment=0;
    //    if (_firstArray.count!=0) {
    //        OrderTableViewModel * model=_firstArray[0];
    //       // NSLog(@"%@",model.name);
    //        nameLabel.text=model.name;
    //    }
    nameLabel.text=md.name;;//换成网络数据字体
    [view5 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageLeft,15)
    .topEqualToView(imageLeft)
    .heightIs(20)
    .rightSpaceToView(btnRight,5);
    
    //image1（定位）
    
    image1.image=[UIImage imageNamed:@"adress"];
    [view5 sd_addSubviews:@[image1]];
    image1.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,10)
    .widthIs(26/2)
    .heightIs(34/2);
    
    //距离distance
    
    distance.font=[UIFont systemFontOfSize:14];
    distance.textColor=[UIColor blackColor];
    distance.textAlignment=0;
    distance.alpha=.7;
    distance.text=md.juLi;;//换成网络数据
    [view5 sd_addSubviews:@[distance]];
    distance.sd_layout
    .rightSpaceToView(btnRight,5)
    .centerYEqualToView(image1)
    .heightRatioToView(image1,1);
    [distance setSingleLineAutoResizeWithMaxWidth:70];
    
    //label1（定位的具体城市）
    
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor blackColor];
    label1.textAlignment=0;
    label1.alpha=.7;
    label1.text=md.diZhi;//换成网络数据
    [view5 sd_addSubviews:@[label1]];
    label1.sd_layout
    .leftSpaceToView(image1,5)
    .topEqualToView(image1)
    .heightRatioToView(image1,1)
    .rightSpaceToView(distance,5);
    
    //image2
    
    image2.image=[UIImage imageNamed:@"shop"];
    [view5 sd_addSubviews:@[image2]];
    image2.sd_layout
    .leftEqualToView(image1)
    .topSpaceToView(image1,10)
    .widthIs(26/2)
    .heightIs(24/2);
    //label2(最近一次用过的取餐点)
    
    label2.text=@"最近一次用过的取餐点";//换成网络数据
    label2.font=[UIFont systemFontOfSize:14];
    label2.alpha=.6;
    label2.textColor=[UIColor blackColor];
    label2.textAlignment=0;
    [view5 sd_addSubviews:@[label2]];
    label2.sd_layout
    .leftSpaceToView(image2,5)
    .topEqualToView(image2)
    .heightRatioToView(image2,1);
    [label2 setSingleLineAutoResizeWithMaxWidth:150];
    
    
    
    
}
#pragma mark--收拾点击
-(void)tapPressImage:(UIGestureRecognizer*)tap{
    if (_isOpenTableView==YES) {
        
        [self dissMiss];
    }else{
        [self according];
    }
    
}
#pragma mark --附近站点点击
-(void)btnRight:(UIButton*)btn{
    
   
    if (_isOpenTableView==YES) {
       
        [self dissMiss];
    }else{
        [self according];
    }
    
   
   

}
#pragma mark--表的展开
-(void)according{
    
    
    _view4.didFinishAutoLayoutBlock=^(CGRect aaa){
        int a =(int)aaa.origin.y;
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",a] forKey:@"originy"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    };
    
    CGPoint point;
    NSString * yy =[[NSUserDefaults standardUserDefaults]objectForKey:@"originy"];
    if (yy==nil) {
        NSLog(@"死坐标");
        point =CGPointMake(0, 284+44+10);
    }else{
        NSLog(@"活坐标");
        int y =[yy intValue];
        point =CGPointMake(0,y);
    }
    if (_isOpenTableView==NO) {
        [_bgScrollview setContentOffset:point animated:YES];
        _isOpenTableView=YES;
        [self CreatTableView];
    }
    _bgScrollview.scrollEnabled=NO;
    
    
    
    
    
    
}
#pragma mark --表的闭合
-(void)dissMiss{
    if (_isOpenTableView==YES) {
        [_bgScrollview setContentOffset:CGPointZero animated:YES];
        _bgScrollview.scrollEnabled=YES;
        _isOpenTableView=NO;
        [self.tableView removeFromSuperview];
    }
   
}


#pragma mark -- 创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_bgScrollview sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(view5,0)
    .heightIs(ScreenHeight-64-200);
    
}

#pragma mark -- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderTableViewCell * cell =[OrderTableViewCell cellWithTableView:tableView];
    cell.model=_dataArray[indexPath.row];
    [cell.changeBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.changeBtn.tag=indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewModel * md =_dataArray[indexPath.row];
    [Engine gengHuanQuCanDianstation_id:md.quCanID success:^(NSDictionary *dic) {
        [_firstArray removeAllObjects];
        [_dataArray removeAllObjects];
        [self tableviewData];
    } error:^(NSError *error) {
        
    }];
    [self dissMiss];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}
-(void)changeBtn:(UIButton*)btn
{
    OrderTableViewModel * md =_dataArray[btn.tag];
    [Engine gengHuanQuCanDianstation_id:md.quCanID success:^(NSDictionary *dic) {
        [_firstArray removeAllObjects];
        [_dataArray removeAllObjects];
        [self tableviewData];
    } error:^(NSError *error) {
        
    }];
    [self dissMiss];
    
}
#pragma mark --购买按钮
-(void)gouMai{
    PayStyeDaFan * vc =[PayStyeDaFan new];
    vc.number=2;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --左上角的保存
-(void)leftBtn
{
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    left.titleLabel.font=[UIFont systemFontOfSize:16];
    [left setTitleColor:[UIColor blackColor] forState:0];
    [left addTarget:self action:@selector(dingwei) forControlEvents:UIControlEventTouchUpInside];
    [left setImage:[UIImage imageNamed:@"arrow_left"] forState:0];
    left.frame=CGRectMake(0,0, 70, 40);
    [left setImageEdgeInsets:UIEdgeInsetsMake(0,-50, 0, 0)];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:left];
    
    self.navigationItem.leftBarButtonItem=rightBtn;
    
}
-(void)dingwei{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
