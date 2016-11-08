//
//  MyXiaoZhanViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyXiaoZhanViewController.h"
#import "WanJiaChuFangTableViewCell.h"
#import "MyXiaoZhanMessage.h"
#import "ChuFangMessageModel.h"
#import "ShouFanCaiViewController.h"
#import "UsetQuCanViewController.h"
#import "FuZhanZhangViewController.h"
#import "FuZhanZhangModel.h"
#import "TableWareVC.h"
#import "UserQuCanModel.h"
#import "YeJiViewController.h"
#import "TextFiledOneVC.h"
@interface MyXiaoZhanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ChuFangMessageModel * model;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray *nameArray;
@property(nonatomic,retain)NSMutableArray *imageView;
@property(nonatomic,retain)FuZhanZhangModel * model2;
@property(nonatomic,retain)UserQuCanModel * model3;
@end

@implementation MyXiaoZhanViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self quiteFuZhanZhang];
    [self userQucan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"我是饮烟小站";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatArray];
    [self quiteXiaoZhanData];
    [self CreatTableView];
}
#pragma mark --查询小站信息
-(void)quiteXiaoZhanData{
    [Engine quiteXiaoZhanMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            model=[[ChuFangMessageModel alloc]initWithXiaoZhanMessageDic:[dic objectForKey:@"content"]];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --查询副站长开关
-(void)quiteFuZhanZhang{
    [Engine quiteFuZhanZhangSwitchsuccess:^(NSDictionary *dic) {
        _model2 =[[FuZhanZhangModel alloc]initWithFuDic:dic];
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark --查询开启用户取餐
-(void)userQucan{
    [Engine quiteSwithXiaoZhansuccess:^(NSDictionary *dic) {
        _model3=[[UserQuCanModel alloc]initWithUserDic:dic];
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
}


-(void)CreatArray{
    NSArray * arr1 =@[@"小站编号",@"小站自编辑广告语"];
    NSArray * arr2 =@[@"小站信息",@"收饭收菜",@"餐具订单"];
    NSArray * arr3 =@[@"开启用户取餐",@"启用备用站长",@"查看业绩"];
    NSArray * image1 =@[@"kitchen_bianhao",@"kitchen_guanggao"];
    NSArray * image2=@[@"kitchen_message",@"kitchen_dingdan ",@"kitchen_today12"];
    NSArray * image3=@[@"kitchen_message",@"kitchen_dingdan ",@"yeji"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];
    _imageView=[[NSMutableArray alloc]initWithObjects:image1,image2,image3,nil];
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
        if (indexPath.row==0) {
            cell.arrowImage.hidden=YES;
            cell.dingDanLab.hidden=NO;
            cell.dingDanLab.text=model.BianHaoName;
        }else{
              cell.arrowImage.hidden=NO;
        }
       
    }else if(indexPath.section==1){
        
    }else{
       
        if (indexPath.row==0) {
            //用户取餐
             cell.rightImage.hidden=NO;
            if (_model3.isOpen==YES) {
                 cell.rightImage.selected=YES;
            }else{
                 cell.rightImage.selected=NO;
            }
            
        }
        else if (indexPath.row==1) {
            //备用站长
             cell.rightImage.hidden=NO;
            if (_model2.isOpen==YES) {
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
    if (indexPath.section==0) {
        if (indexPath.row==1)
        {
           //小站自编辑广告语
            TextFiledOneVC * textStr =[TextFiledOneVC new];
            [self.navigationController pushViewController:textStr animated:YES];
        }
    }
    
   else if (indexPath.section==1){
         if (indexPath.row==0) {
             //小站信息
             MyXiaoZhanMessage * vc =[MyXiaoZhanMessage new];
             vc.model=model;
             [self.navigationController pushViewController:vc animated:YES];
         }else if(indexPath.row==1){
             //收饭收菜
             ShouFanCaiViewController * vc =[ShouFanCaiViewController new];
             [self.navigationController pushViewController:vc animated:YES];
         }else{
             //餐具订单
             TableWareVC * vc =[TableWareVC new];
             [self.navigationController pushViewController:vc animated:YES];
         }
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            //开启用户取餐
             UsetQuCanViewController * vc =[UsetQuCanViewController new];
             vc.model=_model3;
             [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //启用备用站长
            if ([_model2.code isEqualToString:@"1"]) {
                FuZhanZhangViewController * vc =[FuZhanZhangViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                 [LCProgressHUD showMessage:_model2.msg];
            }
           
            
        }else{
            //查看业绩
            YeJiViewController * vc =[YeJiViewController new];
            vc.urlName=@"station";//这是小站的参数
            vc.urlName2=@"Station";//在接口拼接参数的时候用的
            vc.tagg=2;
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
