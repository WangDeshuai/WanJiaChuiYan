//
//  YeJiViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YeJiViewController.h"
#import "YeJiTableViewCell.h"
#import "YeJiModel.h"
@interface YeJiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation YeJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"查看业绩";
    _dataArray=[NSMutableArray new];
   
    [self getTableViewData:_urlName Url2:_urlName2];
      //station
    [self leftBtn];
    [self CreatTableView];
}

#pragma mark --获取网络数据源
-(void)getTableViewData:(NSString*)url Url2:(NSString*)url2{
    [Engine ChaKanYeJiUrl:url UrlTwo:url2 success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            if ([[dic objectForKey:@"content"] count]==0 || [dic objectForKey:@"content"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"没有业绩"];
            }else{
                NSArray * contentArr =[dic objectForKey:@"content"];
                for (NSDictionary * dicc  in contentArr)
                {
                    YeJiModel * model =[[YeJiModel alloc]initWithDic:dicc];
                    [_dataArray addObject:model];
                }
            }
        
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        [_tableView reloadData];
        
    
    } error:^(NSError *error) {
        
    }];
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
    return _dataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *cellid = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    YeJiTableViewCell * cell =[YeJiTableViewCell cellWithTableView:tableView CellID:cellid indexp:indexPath];
    YeJiModel * model =_dataArray[indexPath.row];
    cell.model=model;
    if (_tagg==2) {
        cell.taoCanShu.hidden=NO;
        cell.totleLable.hidden=YES;
    }else{
        cell.taoCanShu.hidden=YES;
        cell.totleLable.hidden=NO;
    }
   // cell.textLabel.text=@"asfa";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[YeJiTableViewCell class] contentViewWidth:[self  cellContentViewWith]];
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
