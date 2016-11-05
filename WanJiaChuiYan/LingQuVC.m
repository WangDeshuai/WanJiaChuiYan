//
//  LingQuVC.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LingQuVC.h"
#import "LingQuTableViewCell.h"
#import "MyOrderModel.h"
@interface LingQuVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UIView * view1;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * dateArray;
@end

@implementation LingQuVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabbarView.hidden=YES;
     _dataArray =[NSMutableArray new];
    _dateArray=[NSMutableArray new];
    // Do any additional setup after loading the view.
   
    [self getInterNetData];
    [self CreatTableView];
}

#pragma mark --获取网络数据
-(void)getInterNetData{
    [Engine MyOrderLingQuLesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            [_dateArray addObject:[contentDic objectForKey:@"orderDate"]];
            if ([[contentDic objectForKey:@"orderList"] count]==0||[contentDic objectForKey:@"orderList"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"暂无订单"];
                return ;
            }
            NSArray * array =[contentDic objectForKey:@"orderList"];
            for (NSDictionary * dicc in array)
            {
                MyOrderModel * model=[[MyOrderModel alloc]initWithYiLingQuDic:dicc];//   c
                [_dataArray addObject:model];
            }
           
        }
         [self CreatView1];
        [_tableView reloadData];
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
    [self.view sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(_view1,44+45)
    .rightSpaceToView(self.view,0)
    .heightIs(ScreenHeight-64-44-45);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
    LingQuTableViewCell * cell =[LingQuTableViewCell cellWithTableView:tableView CellID:cellid index:indexPath];
    MyOrderModel * md=_dataArray[indexPath.row];
    cell.model=md;
    //满意
    cell.manyiBlock=^(NSDictionary*dic){
        if ([dic objectForKey:@"content"]==[NSNull null]) {
            
        }else{
            UIAlertController * actionView=[UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:actionView animated:YES completion:nil];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [actionView addAction:action1];
            [actionView addAction:action2];
        }
    };
    //味道差
    cell.weidaochaBlock=^(NSDictionary*dic){
        NSLog(@"来味道差了");
        if ([dic objectForKey:@"content"]==[NSNull null]) {
            
        }else{
            UIAlertController * actionView=[UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:actionView animated:YES completion:nil];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [actionView addAction:action1];
            [actionView addAction:action2];
        }

    };
    //价格贵
    cell.jiageguiBlock=^(NSDictionary*dic){
        NSLog(@"价格贵了");
        if ([dic objectForKey:@"content"]==[NSNull null]) {
            
        }else{
            UIAlertController * actionView=[UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:actionView animated:YES completion:nil];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [actionView addAction:action1];
            [actionView addAction:action2];
        }

    };
    //分量少
    cell.fenliangshaoBlock=^(NSDictionary*dic){
        NSLog(@"分量少");
        if ([dic objectForKey:@"content"]==[NSNull null]) {
            
        }else{
            UIAlertController * actionView=[UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:actionView animated:YES completion:nil];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [actionView addAction:action1];
            [actionView addAction:action2];
        }

    };

   
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[LingQuTableViewCell class] contentViewWidth:[self  cellContentViewWith]];

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
