//
//  ShouFanCaiViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShouFanCaiViewController.h"
#import "ShouCaiTableViewCell.h"
#import "ShiShouViewController.h"
#import "ShouFanCaiModel.h"
@interface ShouFanCaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * view1;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * dateArray;
@end

@implementation ShouFanCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"收饭收菜";
    
   
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    _dateArray=[NSMutableArray new];
    [self rightBtn];
    [self leftBtn];
    [self tableViewData];
    [self CreatTableView];
}

#pragma mark --解析网络数据
-(void)tableViewData{
    [Engine shouCaiFanCaisuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            
            [_dateArray addObject:[contentDic objectForKey:@"orderDate"]];
            NSArray * allKitchenOrderInfo =[contentDic objectForKey:@"allKitchenOrderInfo"];
            if (allKitchenOrderInfo.count==0) {
                //今日无订单
                [LCProgressHUD showMessage:@"今日无订单"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                for (NSDictionary * menDic in allKitchenOrderInfo)
                {
                    ShouFanCaiModel * md =[[ShouFanCaiModel alloc]initWithDic:menDic];
                    [_dataArray addObject:md];
                }
            }
            [_tableView reloadData];
            [self CreaDate];//表在里面
        }
        
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"刷新" forState:0];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(reladbtn) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
-(void)CreaDate{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(44)
    .topSpaceToView(self.view,5);
    
    UILabel * dateLable =[UILabel new];
    dateLable.text=@"订单日期";
    dateLable.alpha=.7;
    dateLable.font=[UIFont systemFontOfSize:15];
    [_view1 sd_addSubviews:@[dateLable]];
    dateLable.sd_layout
    .leftSpaceToView(_view1,15)
    .centerYEqualToView(_view1)
    .heightIs(20);
    [dateLable setSingleLineAutoResizeWithMaxWidth:100];
    
    UILabel * timeLable =[UILabel new];
    timeLable.text=_dateArray[0];//@"2016-08-22";
    timeLable.alpha=.5;
    timeLable.font=[UIFont systemFontOfSize:15];
    [_view1 sd_addSubviews:@[timeLable]];
    timeLable.sd_layout
    .leftSpaceToView(dateLable,20)
    .centerYEqualToView(_view1)
    .heightIs(20);
    [timeLable setSingleLineAutoResizeWithMaxWidth:100];
  
    
}
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-50);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    ShouCaiTableViewCell * cell =[ShouCaiTableViewCell cellWithTableView:tableView CellID:CellIdentifier index:indexPath];
    ShouFanCaiModel * md =_dataArray[indexPath.row];
    cell.model=md;
    cell.shiShouBtn.tag=indexPath.row;
    [cell.shiShouBtn addTarget:self action:@selector(shiShou:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[ShouCaiTableViewCell class] contentViewWidth:[self  cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --点击实收界面
-(void)shiShou:(UIButton*)btn{
    ShouFanCaiModel * md =_dataArray[btn.tag];
    ShiShouViewController * vc =[ShiShouViewController new];
    vc.chuID=md.chuID;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//刷新
-(void)reladbtn{
    [_tableView reloadData];
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

@end
