//
//  CityViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/1.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CityViewController.h"
#import "CityTwoViewController.h"
#import "CityModel.h"
@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>
{
    BMKLocationService * _locService;
     BMKMapManager* _mapManager;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"选取地区";
    [self leftBtn];
    [self ziDongDingWei];
    _dataArray=[NSMutableArray new];
    [self jieXiData];
    [self CreatTableView];
}

-(void)ziDongDingWei{
//    if ([CLLocationManager locationServicesEnabled]) {
//        NSLog(@"定位服务可用");
//    }
//    else
//    {
//        NSLog(@"定位服务不可用aa");
//    }
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        //启动LocationService
        [_locService startUserLocationService];
    
   
//
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    NSString * weidu =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    NSString * jindu =[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:weidu  forKey:@"jingDu"];
    [dic setObject:jindu forKey:@"WeiDu"];
    NSLog(@"精度》》%@ 维度%@",jindu,weidu);
    [XYString savePlist:dic name:@"cityDingWeiZuoBiao"];

    
}

-(void)jieXiData{
    
    [Engine quiteShengFenlieBiaosuccess:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"])
        {
            NSArray * arr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in arr ) {
                CityModel *model =[[CityModel alloc]initWithShengDic:dicc];
                [_dataArray addObject:model];
            }

        }
                [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --表的创建
-(void)CreatTableView{
    if (!_tableView) {
         self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
}
#pragma mark -- 表的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSArray * arr =_nameArray[section];
    return _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CityModel * md =_dataArray[indexPath.row];
    cell.textLabel.text=md.cityname;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.7;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    CityModel * md =_dataArray[indexPath.row];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:md.cityname forKey:@"cityName"];
    [dic setObject:md.provname forKey:@"shengName"];
    [XYString savePlist:dic name:@"cityDingWei"];
    self.cityNameBlock(md.cityname);
    [self.navigationController popViewControllerAnimated:YES];
    
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
