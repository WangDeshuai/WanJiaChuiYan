//
//  OrderViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "FadeStringView.h"

#import "ShoppingView.h"
#import "SettlementViewController.h"
#import "OrderTableViewModel.h"
#import "PhotoFangDaView.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,ShoppingDelegate>
{
    UIView * view1;
    UIImageView * imageview;//图片温馨提示
    UIView * bgView;
    UIButton * dongXi;//加入购物车的小求
    UIButton * shoppingBtn;;//购物车
    NSInteger selectedRow2;//选中pick某一行
    NSInteger selectedSection;//选中pick某一列
    NSInteger selectedRow0;
    NSInteger selectedRow1;
    NSInteger selectedRow;
    BOOL _isOpen;//购物车界面
    BOOL _isOpenTableView;//下拉列表是否展开
    ShoppingView * vcvc;
    UIButton * huiSeView;//出现购物车后去掉的灰色背景
    UIImageView *imageviewHead;//滚筒上面的image
    UIButton * imageWei;//加入购物车的按钮
    NSMutableArray * array1;
    NSMutableArray * array2;
    NSMutableArray * array3;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIPickerView * pickerView;
@property(nonatomic,retain)NSMutableArray * bigArray;
@property(nonatomic,retain)UIScrollView * bgScrollView;
@property(nonatomic,retain)UILabel * lab2;//做动画加入购物车专用
@property(nonatomic,retain)UILabel * lab1;//做动画加入购物车专用
@property(nonatomic,retain)UILabel * lab3;//做动画加入购物车专用
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * firstArray;
@property(nonatomic,retain)NSMutableArray * priceArr;
@end

@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    
   
        //小图标购物车的数量
        [self time2];
   
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"打饭";
  UIButton* tabBar1= [self.tabbarView viewWithTag:1];
  tabBar1.selected=YES;
    
    _priceArr=[[NSMutableArray alloc]initWithCapacity:3];
//    if ([CLLocationManager locationServicesEnabled]) {
//         NSLog(@"定位服务可用");
//    }
//    else
//    {
//        NSLog(@"定位服务不可用aa");
//    }
//    if ([ToolClass kaiQiDingWei]==NO) {
//        NSLog(@"打饭没开启定位");
//         UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请放心开启位置权限，否则无法正常点击打饭页,其它页正常点击" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:actionView animated:YES completion:nil];
//        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [actionView addAction:action1];
//        
//    }else{
        [_pickerView selectRow:(16384 /2) inComponent:1 animated:YES];
        _bgScrollView=[[UIScrollView alloc]init];
        _bgScrollView.backgroundColor=[UIColor clearColor];
        _bgScrollView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
        if (ScreenHeight==480) {
            _bgScrollView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight+49);
        }else{
            _bgScrollView.scrollEnabled=NO;
        }
        [self.view addSubview:_bgScrollView];
        [self tableviewData];//查询附近小站的网络数据
           // [self quiteCaiDan];//查询菜单的网络数据
        [self Creatinit];//初始化第一个cell
        [self CreatArr];//数组初始化
        [self initView1];//第一个Cell
        [self initView2];//图片
        [self CreatPickView];//🎋
        [self CreatBgView];//灰色背景
        [self.view bringSubviewToFront:self.tabbarView];
   // }
    
}

#pragma mark --解析表的数据
-(void)tableviewData{
   // [LCProgressHUD showLoading:@"数据加载中..."];
    NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    NSMutableDictionary * cityZuoBiao =[XYString duquPlistWenJianPlistName:@"cityDingWeiZuoBiao"];
    //|| cityZuoBiao==nil
    if (cityName==nil ) {
        [LCProgressHUD showMessage:@"请先选择地区"];
        return;
    }

    
    //WeiDu
    [Engine daFanQuCanDianJingDu:[cityZuoBiao objectForKey:@"WeiDu"] WeiDu:[cityZuoBiao objectForKey:@"jingDu"] Sheng:[cityName objectForKey:@"shengName"] City:[cityName objectForKey:@"cityName"] success:^(NSDictionary *dic) {
        
        NSDictionary * dicConten =[dic objectForKey:@"content"];
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [_bigArray removeAllObjects];
            [_pickerView reloadAllComponents];
           [self quiteCaiDan];//查询菜单的网络数据
        }
        
        if ([dicConten objectForKey:@"binded_Station"] ==[NSNull null]) {
            
        }else{
            NSDictionary * bangDic =[dicConten objectForKey:@"binded_Station"];
            OrderTableViewModel * model2 =[[OrderTableViewModel alloc]initWithDic:bangDic];
            [_firstArray addObject:model2];
  
        }
            [self initView1];
        
        if ([dicConten objectForKey:@"near_StationList"] ==[NSNull null]) {
            
        }else{
            NSArray * arrFujin =[dicConten objectForKey:@"near_StationList"];
            for (NSDictionary * dicc in arrFujin) {
                OrderTableViewModel * model =[[OrderTableViewModel alloc]initWithDic:dicc];
                [_dataArray addObject:model];
            }

        }
            [_tableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --数组初始化
-(void)CreatArr{
     number = 1;
    //菜名
//    NSArray * arr1 =@[@"宫爆鸡丁",@"鱼香肉丝",@"宫爆鱼香",@"京酱肉丝",@"肉丝好吃"];
//    NSArray * arr2 =@[@"素炒油麦",@"素炒菠菜",@"素炒白菜",@"白菜好吃",@"菠菜大大",@"大大素炒"];
//    NSArray * arr3 =@[@"米饭",@"炒饼",@"包子",@"面条",@"不点",@"炒面"];
   // _bigArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3,nil];
    _bigArray=[[NSMutableArray alloc]init];
    //价格
     NSArray * priArr1=@[@"12",@"15",@"27",@"13",@"10"];
     NSArray * priArr2=@[@"14",@"17",@"15",@"13",@"9",@"12"];
     NSArray * priArr3=@[@"5",@"7",@"5",@"6",@"0",@"3"];
    _priceArray=[[NSMutableArray alloc]initWithObjects:priArr1,priArr2,priArr3, nil];
    //每个菜的ID
    NSArray * menID1=@[@"1",@"2",@"3",@"4",@"5"];
    NSArray * menID2=@[@"6",@"7",@"8",@"9",@"10",@"11"];
    NSArray * menID3=@[@"12",@"13",@"14",@"15",@"0",@"16"];
    _MenuID=[[NSMutableArray alloc]initWithObjects:menID1,menID2,menID3, nil];
    _dataArray=[NSMutableArray new];
    _firstArray=[NSMutableArray new];
    array1 =[NSMutableArray new];
    array2 =[NSMutableArray new];
    array3 =[NSMutableArray new];
}

#pragma mark --解析菜单的数据
-(void)quiteCaiDan{
    
    NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
   
    
    if (cityName==nil ) {
        [LCProgressHUD showMessage:@"请先选择地区"];
        return;
    }

   
    [Engine quiteMenuDaFanSheng:[cityName objectForKey:@"shengName"] CityName:[cityName objectForKey:@"cityName"] success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            NSArray * leftArray=[contentDic objectForKey:@"main_FoodList"];
            NSArray * centerArray=[contentDic objectForKey:@"vegetable_FoodList"];
            NSArray *rightArray=[contentDic objectForKey:@"meat_FoodList"];
            
            if (rightArray.count==0 ||centerArray.count==0 ) {
                [LCProgressHUD showMessage:@"今日暂无饭菜"];
                return ;
            }
            
            for (NSDictionary * dic1 in leftArray)
            {
                OrderTableViewModel * md1 =[[OrderTableViewModel alloc]initWithMenIDDic:dic1];
                [array1 addObject:md1];
            }
            for (NSDictionary * dic2 in centerArray)
            {
                OrderTableViewModel * md2 =[[OrderTableViewModel alloc]initWithMenIDDic:dic2];
                [array2 addObject:md2];
            }
            for (NSDictionary * dic3 in rightArray)
            {
                OrderTableViewModel * md3 =[[OrderTableViewModel alloc]initWithMenIDDic:dic3];
                [array3 addObject:md3];
            }
            if (array3.count==0 && array2.count==0 && array1.count==0) {
                [LCProgressHUD showMessage:@"今日暂无饭菜"];
                return ;
            }else{
                if (array3.count!=0) {
                     [_bigArray addObject:array3];
                }
                if (array2.count!=0) {
                    [_bigArray addObject:array2];
                }if (array1.count!=0) {
                    [_bigArray addObject:array1];
                }
               
               
               
            }
            [_pickerView reloadAllComponents];
            
            for (int i = 0; i<_bigArray.count; i++) {
                [_pickerView selectRow:[_bigArray[i] count]*900 inComponent:i animated:NO];
            }
            
            
//            [_pickerView selectRow:[_bigArray[0] count]*900 inComponent:0 animated:NO];
//            [_pickerView selectRow:[_bigArray[1] count]*900 inComponent:1 animated:NO];
//            [_pickerView selectRow:[_bigArray[2] count]*900 inComponent:2 animated:NO];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
       
       
        
    } error:^(NSError *error) {
        
    }];
    
    
}

#pragma mark -- 点击下拉列表背景灰色
-(void)CreatBgView{
    bgView=[UIView new];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=.4;
    bgView.hidden=YES;
    [_bgScrollView setContentOffset:CGPointZero animated:NO];
    [_bgScrollView sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(view1,0)
    .bottomSpaceToView(_bgScrollView,0);
    
}
#pragma mark -- 第一个Cell
-(void)Creatinit{
     view1 =[UIView new];
     imageLeft=[UIButton new];
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
    OrderTableViewModel * md;
    if (_firstArray.count!=0) {
        md=_firstArray[0];
    }
    view1.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [_bgScrollView sd_addSubviews:@[view1]];
    view1.sd_layout
    .topSpaceToView(_bgScrollView,10)
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .heightIs(100);
    //左边图片
    //imageLeft.image=[UIImage imageNamed:@"pic1"];//到时候换成网络图片
   // [imageLeft setImageWithURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    [imageLeft addTarget:self action:@selector(lineBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [imageLeft setImageForState:0 withURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"icon1"]];
    [view1 sd_addSubviews:@[imageLeft]];
    imageLeft.sd_layout
    .leftSpaceToView(view1,10)
    .topSpaceToView(view1,10)
    .bottomSpaceToView(view1,10)
    .widthIs(80);
    
    //右边button
   
    
    btnRight.backgroundColor=[UIColor greenColor];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"near2"] forState:0];
    [view1 sd_addSubviews:@[btnRight]];
    [btnRight addTarget:self action:@selector(btnRight:) forControlEvents:UIControlEventTouchUpInside];
    btnRight.sd_layout
    .rightSpaceToView(view1,0)
    .topSpaceToView(view1,0)
    .bottomSpaceToView(view1,0)
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
    nameLabel.text=md.name;//@"皇室生活馆(Jolly Fruit)";//换成网络数据字体
    [view1 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageLeft,15)
    .topEqualToView(imageLeft)
    .heightIs(20)
    .rightSpaceToView(btnRight,5);
   
    //image1（定位）
    
    image1.image=[UIImage imageNamed:@"adress"];
    [view1 sd_addSubviews:@[image1]];
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
    distance.text=md.juLi;//@"1.0km";//换成网络数据
    [view1 sd_addSubviews:@[distance]];
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
    label1.numberOfLines=0;
    label1.text=md.diZhi;//@"广安大街安侨商务";//换成网络数据
     [view1 sd_addSubviews:@[label1]];
    label1.sd_layout
    .leftSpaceToView(image1,5)
    .topEqualToView(image1)
    .rightSpaceToView(distance,5)
    .autoHeightRatio(0);
    
    //image2
    
    image2.image=[UIImage imageNamed:@"shop"];
    [view1 sd_addSubviews:@[image2]];
    image2.sd_layout
    .leftEqualToView(image1)
    .topSpaceToView(label1,10)
    .widthIs(26/2)
    .heightIs(24/2);
    //label2(最近一次用过的取餐点)
  
    label2.text=@"最近一次用过的取餐点";//换成网络数据
    label2.font=[UIFont systemFontOfSize:14];
    label2.alpha=.6;
    label2.textColor=[UIColor blackColor];
    label2.textAlignment=0;
    [view1 sd_addSubviews:@[label2]];
    label2.sd_layout
    .leftSpaceToView(image2,5)
    .topEqualToView(image2)
    .heightRatioToView(image2,1);
    [label2 setSingleLineAutoResizeWithMaxWidth:150];
    
    
    
    
}

#pragma mark -- 图片（温馨提示）
-(void)initView2{
    imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"warning"]];
    imageview.userInteractionEnabled=YES;
    [_bgScrollView sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(view1,20)
    .heightIs(ScreenWidth/7.5);//图片的宽高比是7.5
    
   
    [Engine xiaDanCloseTimesuccess:^(NSDictionary *dic) {
        //NSLog(@"输出%@",[ToolClass getNowTime]);
        NSDictionary * dicc =[dic objectForKey:@"content"];
        NSString  * tim =[dicc objectForKey:@"order_close_time"];
       NSString* time=  [tim substringToIndex:5];
        UILabel * nameLabel2 =[[UILabel alloc]init];
        //哪个字边颜色 numberStr就是哪个字
        NSString *numberStr = [NSString stringWithFormat:@"【%@】",time];
         nameLabel2.textColor= [UIColor colorWithRed:82/255.0 green:236/255.0 blue:135/255.0 alpha:1];
       /*
        nameLabel2为创建的Label,
        numberStr为要变色的字符串
        */
        [nameLabel2 setAttributedText:[self attrStrFrom:[NSString stringWithFormat:@"请先选定取餐地点在选择菜品，如果取餐地点变\n更需要重新选菜。订餐结束时间【%@】",time] numberStr:numberStr]];
        nameLabel2.numberOfLines=2;
        nameLabel2.font=[UIFont systemFontOfSize:13];
       
        
        [imageview sd_addSubviews:@[nameLabel2]];
        nameLabel2.sd_layout
        .rightSpaceToView(imageview,20)
        .centerYEqualToView(imageview)
        .autoHeightRatio(0);
        [nameLabel2 setSingleLineAutoResizeWithMaxWidth:300];
       
       
        
        
        
//        UILabel * timeLabel =[UILabel new];
//        timeLabel.font=[UIFont systemFontOfSize:13];
//        timeLabel.text=[NSString stringWithFormat:@"[%@]",time];
//        timeLabel.textColor=[UIColor redColor];
//        [nameLabel2 sd_addSubviews:@[timeLabel]];
//        timeLabel.sd_layout
//        .rightSpaceToView(nameLabel2,15)
//        .centerYEqualToView(nameLabel2)
//        .autoHeightRatio(0);
//        [timeLabel setSingleLineAutoResizeWithMaxWidth:200];
        
    } error:^(NSError *error) {
        
    }];
    

    
//    UILabel * timeLable =[[UILabel alloc]init];
    
    
    
}
- (NSMutableAttributedString *)attrStrFrom:(NSString *)titleStr numberStr:(NSString *)numberStr
{
    NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:titleStr];
    // 设置前面几个字串的格式:红色 13.0f字号
    [arrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSForegroundColorAttributeName:[UIColor redColor]}range:[titleStr rangeOfString:numberStr]];
   
    return arrString;
}
#pragma mark --UIPickView创建
-(void)CreatPickView
{
    //title抬头
    imageviewHead=[[UIImageView alloc]init];
    
    imageviewHead.image=[UIImage imageNamed:@"head-bg"];
    imageviewHead.userInteractionEnabled=YES;
    [_bgScrollView sd_addSubviews:@[imageviewHead]];
    imageviewHead.sd_layout
    .leftSpaceToView(_bgScrollView,10)
    .rightSpaceToView(_bgScrollView,10)
    .topSpaceToView(imageview,20)
    .heightIs((ScreenWidth-20)*3/35);
   
    
    leftLable =[UILabel new];
    leftLable.textColor=[UIColor colorWithRed:80/255.0 green:231/255.0 blue:132/255.0 alpha:1];
   //您的午餐所需金额%@元
    leftLable.text=@"送到价:0元";
    leftLable.font=[UIFont systemFontOfSize:16];
    [imageviewHead sd_addSubviews:@[leftLable]];
//    centerLable =[UILabel new];
//    centerLable.textColor=[UIColor colorWithRed:80/255.0 green:231/255.0 blue:132/255.0 alpha:1];
//    centerLable.text=@"0元";
//    centerLable.font=[UIFont systemFontOfSize:16];
//    [imageviewHead sd_addSubviews:@[centerLable]];
//    rightLable =[UILabel new];
//    rightLable.textColor=[UIColor colorWithRed:80/255.0 green:231/255.0 blue:132/255.0 alpha:1];
//    rightLable.text=@"0元";
//    rightLable.font=[UIFont systemFontOfSize:16];
//    [imageviewHead sd_addSubviews:@[rightLable]];

    leftLable.textAlignment=1;
     centerLable.textAlignment=1;
     rightLable.textAlignment=1;
    
//    centerLable.sd_layout
//    .centerXEqualToView(imageviewHead)
//    .topSpaceToView(imageviewHead,0)
//    .bottomSpaceToView(imageviewHead,0)
//    .widthIs(_bgScrollView.frame.size.width/3.5);
    
    leftLable.sd_layout
    .topSpaceToView(imageviewHead,0)
    .bottomSpaceToView(imageviewHead,0)
    .centerXEqualToView(imageviewHead);
    [leftLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //.widthIs(_bgScrollView.frame.size.width/3.5);
//    
//    rightLable.sd_layout
//    .topSpaceToView(imageviewHead,0)
//    .bottomSpaceToView(imageviewHead,0)
//    .leftSpaceToView(centerLable,0)
//    .widthIs(_bgScrollView.frame.size.width/3.5);

    
    
    //背景主颜色
    UIImageView * imageViewzhu=[[UIImageView alloc]init];
    imageViewzhu.image=[UIImage imageNamed:@"big-bg-1"];
    imageViewzhu.userInteractionEnabled=YES;
    [_bgScrollView sd_addSubviews:@[imageViewzhu]];
    imageViewzhu.sd_layout
    .leftEqualToView(imageviewHead)
    .rightEqualToView(imageviewHead)
    .topSpaceToView(imageviewHead,5)//5
    .heightIs((ScreenWidth-20)/2);
    
   
    
    //pickView
    _pickerView=[[UIPickerView alloc]init];
    _pickerView.backgroundColor = [UIColor clearColor];
    _pickerView.dataSource = self;
    _pickerView.delegate =self;
 
    
    
   [imageViewzhu sd_addSubviews:@[_pickerView]];
    _pickerView.sd_layout
    .leftSpaceToView(imageViewzhu,0)
    .rightSpaceToView(imageViewzhu,0)
    .topSpaceToView(imageViewzhu,0)
    .bottomSpaceToView(imageViewzhu,0);
    
    
    //加入购物车
    imageWei=[UIButton buttonWithType:UIButtonTypeCustom];
    [imageWei setBackgroundImage:[UIImage imageNamed:@"head-bg"] forState:0];
    imageWei.adjustsImageWhenHighlighted=NO;
    [imageWei addTarget:self action:@selector(addShopping) forControlEvents:UIControlEventTouchUpInside];
    [imageWei setTitle:@"加入购物车" forState:0];
    imageWei.titleLabel.font=[UIFont systemFontOfSize:15];
    [imageWei setTitleColor:[UIColor colorWithRed:80/255.0 green:231/255.0 blue:132/255.0 alpha:1] forState:0];
    
    
    [_bgScrollView sd_addSubviews:@[imageWei]];
    imageWei.sd_layout
    .leftSpaceToView(_bgScrollView,10)
    .rightSpaceToView(_bgScrollView,10)
    .topSpaceToView(imageViewzhu,10)
    .heightIs((ScreenWidth-20)*3/35);
   
    
    
    
    
    //购物车按钮
    shoppingBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [shoppingBtn setBackgroundImage:[UIImage imageNamed:@"dafan_button"] forState:0];
    [shoppingBtn addTarget:self action:@selector(gouWuChe) forControlEvents:UIControlEventTouchUpInside];
    [shoppingBtn setTitleColor:[UIColor redColor] forState:0];
    [self.view sd_addSubviews:@[shoppingBtn]];
    shoppingBtn.sd_layout
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.view,49+10)
    .widthIs(85/2)
    .heightIs(76/2);
    
    numberBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [numberBtn setBackgroundImage:[UIImage imageNamed:@"dafan_samll_button"] forState:0];
    [numberBtn setTitle:@"0" forState:0];
    numberBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [shoppingBtn sd_addSubviews:@[numberBtn]];
    numberBtn.sd_layout
    .topSpaceToView(shoppingBtn,-5)
    .rightSpaceToView(shoppingBtn,-5)
    .widthIs(18)
    .heightIs(18);
    
}

#pragma mark --pickViewDeleagte
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   
   
    
    // 通过返回值设置picker的区域个数
    return _bigArray.count;
}
//每列的个数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * arr =_bigArray[component];
    return arr.count*1000;
}
#pragma mark --pickview标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
     NSArray * dataList =_bigArray[component];
    OrderTableViewModel * md =dataList[row%dataList.count];
    NSString * str =md.menu_name;//dataList[row%dataList.count];
    return str;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view) {
        view=[[UIView alloc]init];
    }
    UILabel * text =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3.5, 40)];
    text.textAlignment=1;
   // text.backgroundColor=[UIColor redColor];
    text.tag=11;
    NSArray * arr =_bigArray[component];
    OrderTableViewModel * md=arr[row%arr.count];
    NSString * str =md.menu_name;
    text.textColor=[UIColor whiteColor];
    text.text=str;
 
    [view addSubview:text];
    return  text;
}
#pragma mark --点击pickView选中的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   // [self quiteCaiDan];
     UILabel * view =(UILabel*)[_pickerView viewForRow:row forComponent:component];
   // UILabel * label=[view viewWithTag:11];
     NSArray * arra =_bigArray[component];
    OrderTableViewModel * mdd=arra[row%arra.count];
    NSLog(@"滑动的时候我看看%@",mdd.number);
    if ([mdd.number isEqualToString:@"0"]) {
       view.textColor=[UIColor grayColor];
    }else{
        view.textColor=[UIColor greenColor];
    }
   
    
    selectedSection=component;
    selectedRow=row;
    
    if (component==0) {
        selectedRow0=row;
        NSArray * arr =_bigArray[component];
         OrderTableViewModel * md=arr[row%arr.count];
        //最左边显示的单价 取消
       // leftLable.text=[NSString stringWithFormat:@"%@元",md.price];
        if (_priceArr.count>1) {
             [_priceArr replaceObjectAtIndex:0 withObject:md.price];
        }else{
            [_priceArr addObject:md.price];
        }
       
    }else if (component==1){
        selectedRow1=row;
        NSArray * arr =_bigArray[component];
        OrderTableViewModel * md=arr[row%arr.count];
         //中间显示的单价 取消
   // centerLable.text=[NSString stringWithFormat:@"%@元",md.price];
        if (_priceArr.count>2) {
            [_priceArr replaceObjectAtIndex:1 withObject:md.price];
        }else{
            [_priceArr addObject:md.price];
        }
        
    }else{
        selectedRow2=row;
        NSArray * arr =_bigArray[component];
        OrderTableViewModel * md=arr[row%arr.count];
        //最右边显示的单价 取消
      //  rightLable.text=[NSString stringWithFormat:@"%@元",md.price];
        if (_priceArr.count>=3) {
           // NSLog(@"我看一下价格%@",md.price);
            [_priceArr replaceObjectAtIndex:2 withObject:md.price];
        }else{
            [_priceArr addObject:md.price];
        }
    }
    
    [self zidongjisuanArray];
    
  
 //  [self pickerViewLoaded:component];
}

#pragma mark --自动计算价格
-(void)zidongjisuanArray{
    //自动计算价格
    NSNumber * sum = [_priceArr valueForKeyPath:@"@sum.floatValue"];
    NSString * price=[NSString stringWithFormat:@"%@",sum];
    NSLog(@"首页总共的价格是%@",price);
    leftLable.text=[NSString stringWithFormat:@"送到价:%@元",price];
}



-(void)pickerViewLoaded: (NSInteger)component {
    
    
    NSArray *dataList =_bigArray[component];
    NSUInteger max = 0;
    NSUInteger base10 = 0;
    max=[dataList count]*100;
    base10=(max/2)-(max/2)%[dataList count];
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % [dataList count] + base10 inComponent:component animated:NO];

    
    
}



//返回指定列行的高度，就是自定义行的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
//返回列的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component==0) {
        return self.view.frame.size.width/3.5;
    }else if (component==1){
        return self.view.frame.size.width/3.5;
    }else{
        return self.view.frame.size.width/3.5;
    }
    
}
#pragma mark --点击购物车(图表)
-(void)gouWuChe{
 

    [self DianJiGouWuChe];
    
}
#pragma mark -- 加载出view购物车
-(void)DianJiGouWuChe{
    ZYData * dao =[[ZYData alloc]init];
    [dao connectSqlite];
    
    NSArray * aray =[dao searchAllPeople];
    
    if(![ToolClass isLogin])
    {
        
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }else if(aray.count==0){
        [LCProgressHUD showMessage:@"购物车是空的"];
        return;
    }
    
    
    
    
    
    
    if (_isOpen==NO) {
         _isOpen=YES;
        huiSeView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        huiSeView.backgroundColor=[UIColor blackColor];
        huiSeView.alpha=0;
        [huiSeView addTarget:self action:@selector(huise:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:huiSeView];
        vcvc =[[ShoppingView alloc]initWithFrame:CGRectMake(0, 700, ScreenWidth, ScreenHeight/2)];
        vcvc.delegate=self;
       
        [self.view addSubview:vcvc];
        [self.tabbarView bringSubviewToFront:vcvc];
        [UIView animateWithDuration:1 animations:^{
            huiSeView.alpha=0.5;
            vcvc.frame=CGRectMake(0, ScreenHeight-ScreenHeight/2-64, ScreenWidth, ScreenHeight/2);
            
        }];
    }
  
}

#pragma mark --ShoppingDelegate（去结算）
-(void)clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        NSLog(@"删除");
    }else{
      //  NSLog(@"结算");
        ZYData * dao =[[ZYData alloc]init];
        [dao connectSqlite];
        NSArray * arr=[dao searchAllPeople];
        if (arr.count==0) {
            [LCProgressHUD showMessage:@"购物车是空的"];
            return;
        }
        
        
        [Engine xiaDanCloseTimesuccess:^(NSDictionary *dic) {
            //NSLog(@"输出%@",[ToolClass getNowTime]);
            NSDictionary * dicc =[dic objectForKey:@"content"];
            NSString  * time =[dicc objectForKey:@"order_close_time"];
            NSLog(@"输出看看本地时间%@",[ToolClass getNowTime]);
            NSLog(@"后台时间%@",time);
            BOOL  cai=  [ToolClass getTimeDifferentWith:time DataNow:[ToolClass getNowTime]];
            if (cai==YES) {
                //过10点了
                NSString * timeTishi =[NSString stringWithFormat:@"超过%@不能结算",time];
                [LCProgressHUD showMessage:timeTishi];
                return;
            }else{
                
                SettlementViewController * vc =[SettlementViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                [self performSelector:@selector(shouqi) withObject:nil afterDelay:1];
                
            }
        } error:^(NSError *error) {
            
        }];
        
       

    }
        
}


#pragma mark --收起view购物车
-(void)shouqi{
    _isOpen=NO;
    //收起
    huiSeView.alpha=.5;
    vcvc.frame=CGRectMake(0, ScreenHeight-ScreenHeight/2-64, ScreenWidth, ScreenHeight/2);
    [UIView animateWithDuration:1 animations:^{
        vcvc.frame=CGRectMake(0, 700, ScreenWidth, ScreenHeight/2);
        huiSeView.alpha=0;
        self.tabbarView.alpha=1;
        [self time2];
    }];

}
-(void)huise:(UIButton*)btn{
    if (_isOpen==YES) {
        [self shouqi];
    }
}

#pragma mark --点击加入购物车（数据库存入）
-(void)addShopping{
    
    
//    if ([ToolClass getBenDiTime]==YES) {
//        //过10点了
//        imageWei.enabled=NO;
//        [imageWei setTitleColor:[UIColor grayColor] forState:0];
//        [LCProgressHUD showMessage:@"超过10点不许点菜"];
//        return;
//    }else{
//        imageWei.enabled=YES;
//    }
//    if (_bigArray.count==0) {
//        [LCProgressHUD showMessage:@"今日暂无饭菜"];
//        return;
//    }
    
    if(![ToolClass isLogin])
    {
        
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
   
    [Engine xiaDanCloseTimesuccess:^(NSDictionary *dic) {
        //NSLog(@"输出%@",[ToolClass getNowTime]);
        NSDictionary * dicc =[dic objectForKey:@"content"];
        NSString  * time =[dicc objectForKey:@"order_close_time"];
        NSLog(@"输出看看本地时间%@",[ToolClass getNowTime]);
        NSLog(@"后台时间%@",time);
       BOOL  cai=  [ToolClass getTimeDifferentWith:time DataNow:[ToolClass getNowTime]];
        if (cai==YES) {
            //过10点了
            imageWei.enabled=NO;
            [imageWei setTitleColor:[UIColor grayColor] forState:0];
            NSString * timeTishi =[NSString stringWithFormat:@"超过%@不许点菜",time];
            [LCProgressHUD showMessage:timeTishi];
            return;
        }else{
           // imageWei.enabled=YES;
            [self fengZhuang];
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
  

    
}
-(void)fengZhuang{
    if (_bigArray.count==0) {
        [LCProgressHUD showMessage:@"今日暂无饭菜"];
        return;
    }
    
    
        NSArray * ar1=_bigArray[0];
        NSArray * ar2=_bigArray[1];
        NSArray * ar3=_bigArray[2];
    
    
        OrderTableViewModel * s =_bigArray[0][selectedRow0%ar1.count];
        OrderTableViewModel * ss =_bigArray[1][selectedRow1%ar2.count];
        OrderTableViewModel * sss =_bigArray[2][selectedRow2%ar3.count];
    NSLog(@"输出看一下%@",s.number);
    NSLog(@"输出看一下%@",ss.number);
    NSLog(@"输出看一下%@",sss.number);
    if ([s.number isEqualToString:@"0"]) {
        [LCProgressHUD showMessage:[NSString stringWithFormat:@"%@已售完",s.menu_name]];
        return;
    }else if ([ss.number isEqualToString:@"0"]){
        [LCProgressHUD showMessage:[NSString stringWithFormat:@"%@已售完",ss.menu_name]];
        return;
    }else if ([sss.number isEqualToString:@"0"] &&![sss.menu_name isEqualToString:@"不点"] ){
        [LCProgressHUD showMessage:[NSString stringWithFormat:@"%@已售完",sss.menu_name]];
        return;
    }else{
        NSLog(@"%@>>%@>>>%@",s.menu_name,ss.menu_name,sss.menu_name);
        addNumber++;
        //进行动画
        [self CreatAnimation:s.menu_name Str:ss.menu_name Rstr:sss.menu_name];
        
        //接收返回的model
        OrderTableViewModel * md1 =[self MenuNameAndPricID:_bigArray];
        OrderTableViewModel * md2=[self MenuNameAndPricID2:_bigArray];
        OrderTableViewModel * md3=[self MenuNameAndPricID3:_bigArray];
        
        
        MenData * mendata =[[MenData alloc]init];
        [mendata connectSqlite];
        
        //套餐ID
        NSString * taoCanID =[NSString stringWithFormat:@"%@-%@-%@",md1.menu_id,md2.menu_id,md3.menu_id];
        //把菜存到数据库
        ZYData * dao =[[ZYData alloc]init];
        [dao connectSqlite];
        /*
         把菜存储到数据库之前需要现在数据库查询一次有没有这种菜
         */
        //查询
        BOOL isHave= [dao searchTaoCanID:taoCanID];
        if (isHave==YES) {
            The_Menu*fenShua=[dao taoCanIDsearchFenShu:taoCanID];
            //number++;
            int numbera=[fenShua.fenShu intValue];
            numbera++;
            NSString * fenshu =[NSString stringWithFormat:@"%d",numbera];
            NSLog(@"有了,份数可以+1>>>%@",fenshu);
            The_Menu * p=[dao taoCanIDsearchFenShu:taoCanID];
            p.fenShu=fenshu;
            
            [dao updateWithPeople:p];
            
            
            
            //The_Menu*fenShua= [dao taoCanIDsearchFenShu:taoCanID];
            
            
            //第二个表
            //再次添加到数据库(把所有的菜全弄进去，不区分)
            NSString * menuidd =[NSString stringWithFormat:@"%@-%@",taoCanID,fenshu];
            [mendata insertPeopleWithName:md1.menu_name menu:md1.price menid:menuidd CaiId:md1.menu_id XuHao:@"" QiTa:@""];
            [mendata insertPeopleWithName:md2.menu_name menu:md2.price menid:menuidd CaiId:md2.menu_id XuHao:@"" QiTa:@""];
            [mendata insertPeopleWithName:md3.menu_name menu:md3.price menid:menuidd CaiId:md3.menu_id XuHao:@"" QiTa:@""];
            
            
        }else{
            NSLog(@"没有，需要存储");
            //存储
            number=1;
            NSString * fenshu =[NSString stringWithFormat:@"%d",number];
            [dao insertPeopleWithName:md1.menu_name Name2:md2.menu_name Name3:md3.menu_name Price1:md1.price Price2:md2.price Price3:md3.price FenShu:fenshu MenID:taoCanID MenID1:md1.menu_id MenID2:md2.menu_id MenID3:md3.menu_id];
            
            //再次添加到数据库(把所有的菜全弄进去，不区分)
            NSLog(@"第二个表没有%@",md1.menu_name);
            [mendata insertPeopleWithName:md1.menu_name menu:md1.price menid:taoCanID CaiId:md1.menu_id XuHao:@"" QiTa:@""];
            [mendata insertPeopleWithName:md2.menu_name menu:md2.price menid:taoCanID CaiId:md2.menu_id XuHao:@"" QiTa:@""];
            [mendata insertPeopleWithName:md3.menu_name menu:md3.price menid:taoCanID CaiId:md3.menu_id XuHao:@"" QiTa:@""];
        }
   
    }
    
    
    
       
    
}

//菜名1
-(OrderTableViewModel*)MenuNameAndPricID:(NSMutableArray*)arr{
    NSArray * ar1=arr[0];
    OrderTableViewModel * s =arr[0][selectedRow0%ar1.count];
    return s;
}
//菜名2
-(OrderTableViewModel*)MenuNameAndPricID2:(NSMutableArray*)arr{
   NSArray * ar2=arr[1];
    OrderTableViewModel * ss =arr[1][selectedRow1%ar2.count];
    return ss;
}
//菜名3
-(OrderTableViewModel*)MenuNameAndPricID3:(NSMutableArray*)arr{
    NSArray * ar3=arr[2];
    OrderTableViewModel * sss =arr[2][selectedRow2%ar3.count];
    
//    if ([sss isEqualToString:@"不点"]) {
//        return nil;
//    }
    return sss;
}


#pragma mark --点击加入购物车创建动画效果
-(void)CreatAnimation:(NSString*)leftStr Str:(NSString*)centerStr Rstr:(NSString*)rightStr{
    if (_lab2==nil) {
        _lab2=[[UILabel alloc]init];
        _lab1=[[UILabel alloc]init];
        _lab3=[[UILabel alloc]init];
    }
    _lab2.text=centerStr;
    _lab2.textAlignment=1;
    _lab2.textColor=[UIColor redColor];
    _lab2.font=[UIFont boldSystemFontOfSize:18];
    _lab2.backgroundColor=[UIColor clearColor];
    _lab2.alpha=0;
    _lab2.frame=CGRectMake(ScreenWidth/2-ScreenHeight/4/2, imageviewHead.origin.y+imageviewHead.size.height+(ScreenWidth-20)/4-35/2+5, ScreenHeight/4, 35);
    [self.view addSubview:_lab2];
    
    _lab1.text=leftStr;
    _lab1.textAlignment=2;
    _lab1.textColor=[UIColor redColor];
    _lab1.font=[UIFont boldSystemFontOfSize:18];
    _lab1.backgroundColor=[UIColor clearColor];
    _lab1.alpha=0;
    _lab1.frame=CGRectMake(_lab2.frame.origin.x-ScreenHeight/5.5, imageviewHead.origin.y+imageviewHead.size.height+(ScreenWidth-20)/4-35/2+5, ScreenHeight/5.5, 35);
    [self.view addSubview:_lab1];
    
    _lab3.text=rightStr;
    _lab3.textAlignment=0;
    _lab3.textColor=[UIColor redColor];
    _lab3.font=[UIFont boldSystemFontOfSize:18];
    _lab3.backgroundColor=[UIColor clearColor];
    _lab3.alpha=0;
    _lab3.frame=CGRectMake(_lab2.frame.origin.x+_lab2.frame.size.width+10, imageviewHead.origin.y+imageviewHead.size.height+(ScreenWidth-20)/4-35/2+5, ScreenHeight/5.5, 35);
    if ([rightStr isEqualToString:@"不点"]) {
        _lab3.hidden=YES;
    }else{
        _lab3.hidden=NO;
    }
    [self.view addSubview:_lab3];
    
    
    imageWei.enabled=NO;
    [UIView animateWithDuration:1.5 animations:^{
        _lab2.alpha=1;
        _lab1.alpha=1;
        _lab3.alpha=1;
        imageWei.enabled=NO;
        [self performSelector:@selector(time) withObject:nil afterDelay:1];
        
    }];
}

#pragma mark --加入购物车动画过程
-(void)time{
  imageWei.enabled=NO;
    [UIView animateWithDuration:1.5 animations:^{
      _lab2.alpha=0;
      _lab1.alpha=0;
      _lab3.alpha=0;
      _lab3.frame=shoppingBtn.frame;
      _lab2.frame=shoppingBtn.frame;
      _lab1.frame=shoppingBtn.frame;
         imageWei.enabled=NO;
     [self performSelector:@selector(time2) withObject:nil afterDelay:1];
        
    }];
   
}
#pragma mark --加入购物车过后恢复button点击状态
-(void)time2{
     imageWei.enabled=YES;
    //小图标购物车的数量
    ZYData * dao=nil;
    if (dao==nil) {
         dao =[[ZYData alloc]init];
    }
 
    [dao connectSqlite];
    NSArray * arr= [dao searchAllPeople];
    [numberBtn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)arr.count] forState:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_bgScrollView sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(_bgScrollView,0)
    .rightSpaceToView(_bgScrollView,0)
    .topSpaceToView(view1,0)
    .heightIs(ScreenHeight-64-110);

}

#pragma mark --收起dissMiss
-(void)dissMiss{
    if (_isOpenTableView==YES) {
        bgView.hidden=YES;
        self.tabbarView.hidden=NO;
        [_tableView removeFromSuperview];
        _bgScrollView.scrollEnabled=YES;
         shoppingBtn.hidden=NO;
        _tableView=nil;
        _isOpenTableView=NO;
    }
   
}
#pragma mark -- 展开According
-(void)according{
    
    if (_isOpenTableView==NO) {
        bgView.hidden=NO;
        _bgScrollView.scrollEnabled=NO;
        self.tabbarView.hidden=YES;
         shoppingBtn.hidden=YES;
        [self CreatTableView];
        _isOpenTableView=YES;
    }
   
}
#pragma mark -- btnRight下拉列表展开
-(void)btnRight:(UIButton*)btn{
    
    if (_isOpenTableView==YES) {
        [self dissMiss];
    }else{
        [self according];
    }
    

}
-(void)tapPressImage:(UIGestureRecognizer*)tap{
    if (_isOpenTableView==YES) {
        [self dissMiss];
    }else{
        [self according];
    }
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
    cell.imageLeft.tag=indexPath.row;
    [cell.imageLeft addTarget:self action:@selector(lineBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewModel * md =_dataArray[indexPath.row];
    [Engine gengHuanQuCanDianstation_id:md.quCanID success:^(NSDictionary *dic) {
        [_firstArray removeAllObjects];
        [_dataArray removeAllObjects];
        [self deleateGouWuChe];//切换取餐点购物车会清空
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
        [self deleateGouWuChe];//切换取餐点购物车会清空
        [self tableviewData];
    } error:^(NSError *error) {
        
    }];
    [self dissMiss];
    
}

#pragma mark --头像点击放大
-(void)lineBtn2:(UIButton*)btn{
    if(![ToolClass isLogin])
    {
        
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    OrderTableViewModel * md= _firstArray[0];
    UIButton * viewbg =[UIButton new];
    viewbg.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    viewbg.backgroundColor=[UIColor blackColor];
    viewbg.alpha=1;
    viewbg.tag=10;
    [viewbg addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * bbtnn =[UIButton buttonWithType:UIButtonTypeCustom];
    bbtnn.adjustsImageWhenHighlighted=NO;
    bbtnn.tag=11;
    
    [bbtnn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"pic1"]];
    
    bbtnn.center=CGPointMake(viewbg.center.x, viewbg.center.y);
    bbtnn.bounds=CGRectMake(0, 0, ScreenWidth, ScreenWidth*bbtnn.imageView.image.size.height/bbtnn.imageView.image.size.width);
    [bbtnn.imageView removeFromSuperview];
    
    
    [bbtnn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:md.imageName]];
    
    
    [bbtnn addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewbg addSubview:bbtnn];
    [WINDOW addSubview:viewbg];
}
-(void)lineBtn:(UIButton*)btn{
    [self dissMiss];
    
    OrderTableViewModel * md= _dataArray[btn.tag];
        UIButton * viewbg =[UIButton new];
        viewbg.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        viewbg.backgroundColor=[UIColor blackColor];
        viewbg.alpha=1;
        viewbg.tag=10;
        [viewbg addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * bbtnn =[UIButton buttonWithType:UIButtonTypeCustom];
        bbtnn.adjustsImageWhenHighlighted=NO;
        bbtnn.tag=11;
        
        [bbtnn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"pic1"]];
        
        bbtnn.center=CGPointMake(viewbg.center.x, viewbg.center.y);
        bbtnn.bounds=CGRectMake(0, 0, ScreenWidth, ScreenWidth*bbtnn.imageView.image.size.height/bbtnn.imageView.image.size.width);
        [bbtnn.imageView removeFromSuperview];
        
        
        [bbtnn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:md.imageName]];
        
        
        [bbtnn addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
        
        [viewbg addSubview:bbtnn];
        [WINDOW addSubview:viewbg];

    

  
}
-(void)quxiao:(UIButton*)btn
{
    if (btn.tag==10) {
        [btn removeFromSuperview];
    }else{
        UIButton * btnn =(UIButton*)[btn superview];
        [btn removeFromSuperview];
        [btnn removeFromSuperview];
    }
    
    
    
}


#pragma mark --清空购物车所有菜品
-(void)deleateGouWuChe
{
    //清空第一个表
    ZYData * data =[[ZYData alloc]init];
    [data connectSqlite];
    NSArray * array =[data searchAllPeople];
    for (The_Menu * menu in array) {
        [data deleteWithPeople:menu];
    }
    
    MenData * menDao=[[MenData alloc]init];
    [menDao connectSqlite];
    //把第二个表也删除
    for (TheMenuTwo * menuTwo in [menDao searchAllPeople]) {
        [menDao deleteWithPeople:menuTwo];
    }
    
    
    
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
