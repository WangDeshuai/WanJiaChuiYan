//
//  TableWareVC.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TableWareVC.h"
#import "TableWareTableViewCell.h"
#import "TableWareModel.h"
@interface TableWareVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation TableWareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"餐具订单";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    [self CreatTableView];
    [self tableViewData];
}

#pragma mark --餐具订单
-(void)tableViewData{
    
    [Engine quiteCanJuOrdersuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            if ([[dic objectForKey:@"content"] count]==0||[dic objectForKey:@"content"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"暂无订单信息"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc  in contentArr)
            {
                TableWareModel * model =[[TableWareModel alloc]initWithCanJuDic:dicc];
                [_dataArray addObject:model];
            }
        }
        
        [_tableView reloadData];
    } error:
     ^(NSError *error) {
         
     }];
    
    
}

-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
    TableWareTableViewCell * cell =[TableWareTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.model=_dataArray[indexPath.row];
    cell.faFangBtn.tag=indexPath.row;
    [cell.faFangBtn addTarget:self action:@selector(fafang:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[TableWareTableViewCell class] contentViewWidth:[self  cellContentViewWith]];//120;
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
#pragma mark --餐具发放
-(void)fafang:(UIButton*)fabtn{
    TableWareModel * md =_dataArray[fabtn.tag];
    //获取1区0行的cell
    TableWareTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:fabtn.tag inSection:0]];
    [Engine fafangCanJuDingDanHao:md.bianHao success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            fabtn.selected=YES;
            cell.fafang.selected=YES;
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
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
