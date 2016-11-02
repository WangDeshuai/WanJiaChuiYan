//
//  MyQuCanDianVC.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyQuCanDianVC.h"
#import "OrderTableViewModel.h"
#import "OrderTableViewCell.h"
@interface MyQuCanDianVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * imageLeft ;
   
  
    UILabel * nameLabel;
    UIImageView * image1;
    UILabel * distance;
    UILabel * label1;
    UIImageView * image2;
    UILabel * label2;
    UILabel * label3;//没有取餐点用来提示的
    UIView * view5;
}
@property(nonatomic,retain)NSMutableArray * firstArray;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation MyQuCanDianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"选择取餐点";
    [self leftBtn];
    _firstArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
   
    [self tableviewData];
     [self Creatinit];
    [self CreatTableView];
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
    
    
    [Engine daFanQuCanDianJingDu:[cityZuoBiao objectForKey:@"WeiDu"] WeiDu:[cityZuoBiao objectForKey:@"jingDu"] Sheng:[cityName objectForKey:@"shengName"] City:[cityName objectForKey:@"cityName"] success:^(NSDictionary *dic) {
        
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

#pragma mark --创建cell1
-(void)Creatinit{
    view5 =[UIView new];
    imageLeft=[UIImageView new];
    nameLabel =[UILabel new];
    image1 =[[UIImageView alloc]init];
    distance=[UILabel new];
    label1=[UILabel new];;
    image2 =[UIImageView new];
    label2 =[UILabel new];
    label3=[UILabel new];
}

-(void)initView1{
    
    
    
    if(_firstArray.count==0 || _firstArray==nil){
        [LCProgressHUD showMessage:@"请选择取餐点"];
        view5.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self.view sd_addSubviews:@[view5]];
        view5.sd_layout
        .topSpaceToView(self.view,0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightIs(100);
        
        [view5 sd_addSubviews:@[label3]];
        label3.numberOfLines=0;
        label3.text=@"请在以下列表选取您的取餐点";
        label3.sd_layout
        .centerXEqualToView(view5)
        .centerYEqualToView(view5)
        .heightIs(50);
        [label3 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        return;
    }
    
    label3.hidden=YES;
    OrderTableViewModel * md=_firstArray[0];
    view5.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[view5]];
    view5.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(100);
    //左边图片
    [imageLeft setImageWithURL:[NSURL URLWithString:md.imageName] placeholderImage:[UIImage imageNamed:@"icon1"]];
    [view5 sd_addSubviews:@[imageLeft]];
    imageLeft.sd_layout
    .leftSpaceToView(view5,10)
    .topSpaceToView(view5,10)
    .bottomSpaceToView(view5,10)
    .widthIs(80);
    
   
    
    
    //Name
    
    nameLabel.font=[UIFont systemFontOfSize:16];
    nameLabel.textColor=[UIColor redColor];
    nameLabel.textAlignment=0;
    nameLabel.text=md.name;;//换成网络数据字体
    [view5 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageLeft,15)
    .topEqualToView(imageLeft)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
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
    distance.textColor=[UIColor redColor];
    distance.textAlignment=0;
    distance.alpha=.7;
    distance.text=md.juLi;;//换成网络数据
    [view5 sd_addSubviews:@[distance]];
    distance.sd_layout
    .rightSpaceToView(view5,5)
    .centerYEqualToView(image1)
    .heightRatioToView(image1,1);
    [distance setSingleLineAutoResizeWithMaxWidth:70];
    
    //label1（定位的具体城市）
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor redColor];
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
    label2.textColor=[UIColor redColor];
    label2.textAlignment=0;
    [view5 sd_addSubviews:@[label2]];
    label2.sd_layout
    .leftSpaceToView(image2,5)
    .topEqualToView(image2)
    .heightRatioToView(image2,1);
    [label2 setSingleLineAutoResizeWithMaxWidth:150];
    
    
    
    
}


#pragma mark -- CreatTableView
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight-64-105) style:UITableViewStylePlain];
    }
    
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}
#pragma mark --立即更换取餐点
-(void)changeBtn:(UIButton*)btn
{
    OrderTableViewModel * md =_dataArray[btn.tag];
    [Engine gengHuanQuCanDianstation_id:md.quCanID success:^(NSDictionary *dic) {
        [_firstArray removeAllObjects];
        [_dataArray removeAllObjects];
        [self deleateGouWuChe];
        [self tableviewData];
    } error:^(NSError *error) {
        
    }];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
@end
