//
//  WanJiaChuFangViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WanJiaChuFangViewController.h"
#import "WanJiaChuFangTableViewCell.h"
#import "ChuFangMessageViewController.h"
#import "ChuFangMessageModel.h"
#import "ChuFangDingDanViewController.h"
#import "JinRiYingYeViewController.h"
#import "YeJiViewController.h"
@interface WanJiaChuFangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ChuFangMessageModel * model;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * nameArray;
@property(nonatomic,retain)NSMutableArray * imageView;
@property(nonatomic,assign)BOOL isOpen;//是否开启营业状态
@end

@implementation WanJiaChuFangViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self ChaXunStarStye];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"我是万家厨房";
   
    // Do any additional setup after loading the view.
    [self quiteChuFangMessage];
    [self leftBtn];
    [self CreatArray];
    [self CreatTableView];
}
#pragma mark --查询厨房信息
-(void)quiteChuFangMessage{
    [Engine querChuFangMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            model=[[ChuFangMessageModel alloc]initWithMessageDic:[dic objectForKey:@"content"]];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --查询今日营业开启关闭状态
-(void)ChaXunStarStye{
    [Engine quiteTodayYingYeStyesuccess:^(NSDictionary *dic) {
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];//;
        if ([content isEqualToString:@"1"]) {
            _isOpen=YES;
        }else{
            _isOpen=NO;
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
    
}

-(void)CreatArray{
    NSArray * arr1 =@[@"厨房编号"];
    NSArray * arr2 =@[@"厨房信息",@"厨房订单",@"今日营业",@"查看业绩"];
    NSArray * image1 =@[@"kitchen_bianhao"];
    NSArray * image2=@[@"kitchen_message",@"kitchen_dingdan ",@"kitchen_today",@"yeji"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    _imageView=[[NSMutableArray alloc]initWithObjects:image1,image2, nil];
}

-(void)CreatTableView{
    if (!_tableView) {
    _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * aa =_nameArray[section];
    return aa.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    WanJiaChuFangTableViewCell * cell =[WanJiaChuFangTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    if (indexPath.section==0) {
        cell.arrowImage.hidden=YES;
        cell.dingDanLab.hidden=NO;
        cell.dingDanLab.text=model.BianHaoName;
    }else{
        if (indexPath.row==2) {
            cell.rightImage.hidden=NO;
            if (_isOpen==YES) {
                cell.rightImage.selected=YES;
            }else{
                cell.rightImage.selected=NO;
            }
            
        }
    }
    cell.nameLable.text=_nameArray[indexPath.section][indexPath.row];
    cell.leftImage.image=[UIImage imageNamed:_imageView[indexPath.section][indexPath.row]];
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            //厨房信息
            ChuFangMessageViewController * vc =[ChuFangMessageViewController new];
            vc.modelMessage=model;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //厨房订单
            ChuFangDingDanViewController * vc =[ChuFangDingDanViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            //今日营业
            JinRiYingYeViewController * vc =[JinRiYingYeViewController new];
            vc.isopen=_isOpen;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //查看业绩
            YeJiViewController * vc =[YeJiViewController new];
            vc.urlName=@"kitchen";//这是厨房的业绩
            vc.urlName2=@"Kitchen";
            vc.tagg=1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark --区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
#pragma mark --表的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark -- 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
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
