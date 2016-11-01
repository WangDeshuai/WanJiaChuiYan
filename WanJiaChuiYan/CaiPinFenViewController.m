//
//  CaiPinFenViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CaiPinFenViewController.h"
#import "XiaoZhanFenTableViewCell.h"
#import "ChuFangOrderModel.h"
@interface CaiPinFenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UIView * view1;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * dateArray;
@end

@implementation CaiPinFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    _dateArray=[NSMutableArray new];
  
    [self intenetData];
   
}

#pragma mark --网络数据
-(void)intenetData{
    
    [LCProgressHUD showLoading:@"请稍后..."];
    
    [Engine WanJiaChuFangCaiPinFensuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            if ([[contentDic objectForKey:@"allMenuOrderInfo"] count]==0||[contentDic objectForKey:@"allMenuOrderInfo"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"暂无订单"];
                return ;
            }
            [_dateArray addObject:[contentDic objectForKey:@"orderDate"]];
            [LCProgressHUD hide];
            NSArray * array =[contentDic objectForKey:@"allMenuOrderInfo"];
            for (NSDictionary * dicc  in array)
            {
                ChuFangOrderModel * model =[[ChuFangOrderModel alloc]initWithCaiFenDic:dicc];
                [_dataArray addObject:model];
            }
            
        }
       // [_tableView reloadData];
        [self CreatView1];
        [self CreatTableView];
        
    } error:^(NSError *error) {
        
    }];
    
}


#pragma mark --创建view1
-(void)CreatView1{
    _view1=[[UIView alloc]init];
    _view1.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,45)
    .heightIs(44);
    
    UILabel * dateLabel =[UILabel new];
    UILabel * timeLabel =[UILabel new];
    dateLabel.text=@"订单日期  ";
    timeLabel.text=_dateArray[0];//@"2016-08-22";
    
    dateLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.font=[UIFont systemFontOfSize:15];
    dateLabel.alpha=.7;
    timeLabel.alpha=.6;
    
    [_view1 sd_addSubviews:@[dateLabel,timeLabel]];
    
    dateLabel.sd_layout
    .leftSpaceToView(_view1,15)
    .centerYEqualToView(_view1)
    .heightIs(20);
    [dateLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    timeLabel.sd_layout
    .centerYEqualToView(dateLabel)
    .heightRatioToView(dateLabel,1)
    .leftSpaceToView(dateLabel,10);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:220];
    
}
#pragma mark --创建表
-(void)CreatTableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(_view1,0)
    .rightSpaceToView(self.view,0)
    .heightIs(ScreenHeight-64-45-44);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
    XiaoZhanFenTableViewCell * cell =[XiaoZhanFenTableViewCell cellWithTableView:tableView CellID:cellid  indexp:indexPath];
    
    cell.model=_dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[XiaoZhanFenTableViewCell class] contentViewWidth:[self  cellContentViewWith]];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
