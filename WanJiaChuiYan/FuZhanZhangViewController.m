//
//  FuZhanZhangViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuZhanZhangViewController.h"
#import "PeopleActingTableViewCell.h"
#import "AddPeopleViewController.h"
#import "FuZhanZhangModel.h"
@interface FuZhanZhangViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UISwitch * _lastSwith;
    NSInteger tagg;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation FuZhanZhangViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self quitelieBiaoData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"使用副站长";
    [self leftBtn];
       // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    [self rightBtn];
    [self CreatTableView];
}
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    [fabu setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
#pragma mark --查询副站长详情
-(void)quitelieBiaoData{
    [_dataArray removeAllObjects];
    [Engine quiteFuZhanZhangXiangQingsuccess:^(NSDictionary *dic) {
        NSString * code=[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            if ([dic objectForKey:@"content"]==[NSNull null] ||[[dic objectForKey:@"content"] count]==0 ) {
                return ;
            }
            NSArray * contenArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc  in contenArr)
            {
                FuZhanZhangModel * model =[[FuZhanZhangModel alloc]initWithFuZhanZhangDic:dicc];
                [_dataArray addObject:model];
            }
        
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
    
    FuZhanZhangModel * md =_dataArray[indexPath.row];
    cell.switchbtn.tag=indexPath.row;
    
   
    if (md.isSwitch==YES) {
        _lastSwith=cell.switchbtn;
    }
    
    cell.model2=md;
    [cell.switchbtn addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
    return cell;
    
}
-(void)getValue1:(UISwitch*)swi2{
    
    if (_lastSwith==swi2) {
        _lastSwith=nil;
    }
    _lastSwith.on=NO;
    _lastSwith=swi2;
    tagg=swi2.tag+1;
    if (swi2.on) {
        // NSLog(@"打开了");
    }else{
        //NSLog(@"关闭了");
        tagg=0;
    }

   
    
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(void)sureBtn:(UIButton*)btn{
    AddPeopleViewController * vc =[AddPeopleViewController new];
    vc.number=2;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --侧滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuZhanZhangModel * md =_dataArray[indexPath.row];
    [_dataArray removeObject:md];
    [Engine deleagteFuZhanZhangAccount:md.phoneNumber success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
    } error:^(NSError *error) {
        
    }];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --副站长提交
-(void)save{
    if (tagg==0) {
        [Engine guanBiZhanZhangsuccess:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        FuZhanZhangModel * md =_dataArray[tagg-1];
        [Engine kaiQiFuZhanZhangAccount:md.phoneNumber Name:md.name success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } error:^(NSError *error) {
            
        }];
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
