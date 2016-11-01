//
//  PeopleActingViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleActingViewController.h"
#import "PeopleActingTableViewCell.h"
#import "AddPeopleViewController.h"
#import "PeopleDaiLingModel.h"
@interface PeopleActingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UISwitch * _lastSwith;
    NSInteger tagg;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation PeopleActingViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self getWangLuoData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"找人代领";

    [self leftBtn];
    // Do any additional setup after loading the view.
   // [self rightBtn];
    _dataArray=[NSMutableArray new];
    [self CreatTableView];
}
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}

#pragma mark --网络获取数据
-(void)getWangLuoData{
    [_dataArray removeAllObjects];
    [Engine zhaoRenDaiLingXiangXisuccess:^(NSDictionary *dic) {
        if ([dic objectForKey:@"content"] ==[NSNull null]) {
            return ;
        }
        NSArray * contentArr =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in contentArr)
        {
        PeopleDaiLingModel * model =[[PeopleDaiLingModel alloc]initWithZhaoRenDaiLingDic:dicc];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --创建表格
-(void)CreatTableView{
    _tableView=[[UITableView alloc]init];
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.frame=CGRectMake(0, 10, ScreenWidth, ScreenHeight-64-50);
    [self.view addSubview:_tableView];
    
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor=[UIColor redColor];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"dailing_add"] forState:0];
    [sureBtn addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[sureBtn]];
    sureBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50);
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
    PeopleActingTableViewCell * cell =[PeopleActingTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
   
    PeopleDaiLingModel * md =_dataArray[indexPath.row];
    cell.model=md;
    if (md.isSwitch==YES) {
        _lastSwith=cell.switchbtn;
    }
     cell.switchbtn.tag=indexPath.row;
    [cell.switchbtn addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
    return cell;
    
}
#pragma mark --开关 展开闭合状态
-(void)getValue1:(UISwitch*)swi2{
    
    if (_lastSwith==swi2) {
        _lastSwith=nil;
    }
    _lastSwith.on=NO;
    _lastSwith=swi2;
    tagg=swi2.tag+1;
    if (swi2.on) {
       NSLog(@"打开了");
        PeopleDaiLingModel * md =_dataArray[tagg-1];
        [Engine kaiQiDaiLingRenAccount:md.account Name:md.name success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
        } error:^(NSError *error) {
            
        }];

    }else{
        NSLog(@"关闭了");
        //关闭找人带领
        [Engine ShutDownDaiLingRensuccess:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            
        }];

        tagg=0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
#pragma mark --侧滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleDaiLingModel * md =_dataArray[indexPath.row];
    [_dataArray removeObject:md];
    [Engine deleagteDaiLingRenPhone:md.account success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
    } error:^(NSError *error) {
        
    }];
    [_tableView reloadData];
}

#pragma mark --添加
-(void)sureBtn:(UIButton*)btn{
    AddPeopleViewController * vc =[AddPeopleViewController new];
    vc.number=1;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --右上角保存
-(void)save{
   
    if (tagg==0) {
        //关闭找人带领
        [Engine ShutDownDaiLingRensuccess:^(NSDictionary *dic) {
           [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            
        }];
        return;
    }else{
          //开启找人带领
        PeopleDaiLingModel * md =_dataArray[tagg-1];
        [Engine kaiQiDaiLingRenAccount:md.account Name:md.name success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
        } error:^(NSError *error) {
            
        }];
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
