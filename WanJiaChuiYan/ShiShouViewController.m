//
//  ShiShouViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShiShouViewController.h"
#import "ShiShouTableViewCell.h"
#import "ShouFanCaiModel.h"
@interface ShiShouViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * biaoTiView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation ShiShouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"实收";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    [self rightBtn];
    [self getInterNetData];
    [self CreatBiaoTiView];
}

-(void)getInterNetData{
    [Engine shiShouMenTableViewChuFangID:_chuID success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"])
        {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            if ([[contentDic objectForKey:@"dataList"] count]==0) {
                [LCProgressHUD  showMessage:@"无信息"];
                return ;
            }else{
                NSArray *  array =[contentDic objectForKey:@"dataList"];
                for (NSDictionary * dicc in array)
                {
                    ShouFanCaiModel * model =[[ShouFanCaiModel alloc]initWithShiShouDic:dicc];
                    [_dataArray addObject:model];
                }
                
            }
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(reladbtn) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}

-(void)CreatBiaoTiView{
    
    UIView * bgView =[UIView new];
    bgView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(40);
    
    UIImageView * imageview =[[UIImageView alloc]init];
    NSString * st =[[NSUserDefaults standardUserDefaults]objectForKey:@"shishou"];
    if (st==nil) {
        imageview.image=[UIImage imageNamed:@"weitijiao"];
    }else{
        imageview.image=[UIImage imageNamed:@"yitijiao"];
    }
    [bgView sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .centerXEqualToView(bgView)
    .centerYEqualToView(bgView)
    .widthIs(169/2)
    .heightIs(58/2);
    
    
    _biaoTiView=[UIView new];
    _biaoTiView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[_biaoTiView]];
    _biaoTiView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(50)
    .topSpaceToView(self.view,50);
    
    UILabel * leftLab =[UILabel new];
    UILabel * centerLab =[UILabel new];
    UILabel * rightLab =[UILabel new];
    [self shuXingLable:leftLab];
    [self shuXingLable:centerLab];
    [self shuXingLable:rightLab];
    leftLab.text=@"菜品";
    centerLab.text=@"应收(份)";
    rightLab.text=@"实收(份)";
    [_biaoTiView sd_addSubviews:@[leftLab,centerLab,rightLab]];
    leftLab.sd_layout
    .leftSpaceToView(_biaoTiView,0)
    .topSpaceToView(_biaoTiView,0)
    .bottomSpaceToView(_biaoTiView,0)
    .widthIs(ScreenWidth/3);
    centerLab.sd_layout
    .leftSpaceToView(leftLab,0)
    .topEqualToView(leftLab)
    .widthRatioToView(leftLab,1)
    .heightRatioToView(leftLab,1);
    rightLab.sd_layout
    .rightSpaceToView(_biaoTiView,0)
    .topEqualToView(leftLab)
    .widthRatioToView(leftLab,1)
    .heightRatioToView(leftLab,1);
    [self CreatTableView];
}
#pragma mark --Lable的属性
-(void)shuXingLable:(UILabel*)lab{
    lab.textColor=[UIColor blackColor];
    lab.alpha=.6;
    lab.textAlignment=1;
    lab.font=[UIFont systemFontOfSize:15];
}

-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 60+40, ScreenWidth, ScreenHeight/2);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    ShiShouTableViewCell * cell =[ShiShouTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    
    cell.model=_dataArray[indexPath.row];
    cell.addBtn.tag=indexPath.row;
    cell.jianBtn.tag=indexPath.row;
    [cell.addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [cell.jianBtn addTarget:self action:@selector(jian:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --加号
-(void)add:(UIButton*)btn{
    ShouFanCaiModel * md =_dataArray[btn.tag];
    md.shiShou=[NSString stringWithFormat:@"%d",[md.shiShou intValue]+1];
    if ([md.shiShou intValue]>[md.yingShou intValue])
    {
        [LCProgressHUD showMessage:@"达到最高限制"];
        md.shiShou=[NSString stringWithFormat:@"%@",md.yingShou];
    }
    [_dataArray replaceObjectAtIndex:btn.tag withObject:md];
    [_tableView reloadData];

}
#pragma mark --减号
-(void)jian:(UIButton*)btn{
    ShouFanCaiModel * md =_dataArray[btn.tag];
    if ([md.shiShou intValue]==0) {
        [LCProgressHUD showMessage:@"达到最低限制"];
        return;
    }else{
        md.shiShou=[NSString stringWithFormat:@"%d",[md.shiShou intValue]-1];
        [_dataArray replaceObjectAtIndex:btn.tag withObject:md];
        [_tableView reloadData];
    }
    
    
}


#pragma mark --提交
-(void)reladbtn{
    NSMutableArray * dataArr =[NSMutableArray new];
    
    for (ShouFanCaiModel * md in _dataArray) {
        NSMutableDictionary * dic =[NSMutableDictionary new];
//        NSLog(@"输出id=%@",md.iddMenu);
//        NSLog(@"输出个数=%@",md.shiShou);
        [dic setObject:md.iddMenu forKey:@"menu_id"];
        [dic setObject:md.shiShou forKey:@"number_practical"];
        [dataArr addObject:dic];
    }
    NSString * josn =[XYString jsonString:dataArr];
  //  NSLog(@"输出%@",josn);
    
    [Engine shangBaoShiShouFanCaiChuFangID:_chuID JsonStr:josn success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        [[NSUserDefaults standardUserDefaults] setObject:@"实收饭菜" forKey:@"shishou"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([code isEqualToString:@"1"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
    
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
