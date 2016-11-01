//
//  ToApplyForViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ToApplyForViewController.h"
#import "ToApplyForTableViewCell.h"
#import "ToApplyForModel.h"
@interface ToApplyForViewController ()<UITableViewDelegate,UITableViewDataSource>
{
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation ToApplyForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"申请中";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatArray];
    [self shenQingData];
    [self CreatTableView];
}
-(void)CreatArray{
    _dataArray=[[NSMutableArray alloc]init];
}
#pragma mark --申请中的数据
-(void)shenQingData{
    
    NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    NSMutableDictionary * cityZuoBiao =[XYString duquPlistWenJianPlistName:@"cityDingWeiZuoBiao"];
    //|| cityZuoBiao==nil
    if (cityName==nil ) {
        [LCProgressHUD showMessage:@"请先选择地区"];
        return;
    }
//    NSLog(@">>>%@",[cityZuoBiao objectForKey:@"WeiDu"]);
//    NSLog(@">>>%@",[cityZuoBiao objectForKey:@"jingDu"]);
//    NSLog(@">>>>%@",[cityName objectForKey:@"shengName"]);
//     NSLog(@">>>>%@",[cityName objectForKey:@"cityName"]);
    
    [Engine shenQingZhongProvName:[cityName objectForKey:@"shengName"] CityName:[cityName objectForKey:@"cityName"] JingDu:[cityZuoBiao objectForKey:@"WeiDu"] WeiDu:[cityZuoBiao objectForKey:@"jingDu"] success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            if ([[dic objectForKey:@"content"] count]==0 ||[dic objectForKey:@"content"]==[NSNull null]) {
                NSLog(@"请求到数据了但是数组是空的");
            }else{
                
                NSArray * contentArr =[dic objectForKey:@"content"];
                for (NSDictionary * dicc  in contentArr)
                {
                   ToApplyForModel * model =[[ToApplyForModel alloc]initWithReviewDic:dicc];
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

#pragma mark -- 表的创建CreatTableView
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
#pragma mark --tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _dataArray.count;
}
#pragma mark --tableViewDataSoure
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    ToApplyForTableViewCell * cell =[ToApplyForTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    ToApplyForModel * md =_dataArray[indexPath.row];
    cell.model=md;
    cell.zhiChitBtn.tag=indexPath.row;
    [cell.zhiChitBtn addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}
#pragma mark --点赞
-(void)zan:(UIButton*)btn{
     btn.selected=!btn.selected;
     ToApplyForTableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    ToApplyForModel * md =_dataArray[btn.tag];
   
    if (btn.selected==YES) {
        
        
        //添加到网络数据
        [Engine shenqingZhiChiStaticID:md.idd success:^(NSDictionary *dic) {
            NSDictionary * content =[dic objectForKey:@"content"];
            NSString * str =[NSString stringWithFormat:@"%@",[content objectForKey:@"praise_number" ]];
             [cell.numberBtn setTitle:[NSString stringWithFormat:@"已有%@人点赞",str]forState:0];
        } error:^(NSError *error) {
            
        }];
        
       
    }else{
        
        [Engine shenqingZhiChiStaticID:md.idd success:^(NSDictionary *dic) {
            NSDictionary * content =[dic objectForKey:@"content"];
            NSString * str =[NSString stringWithFormat:@"%@",[content objectForKey:@"praise_number" ]];
            
             [cell.numberBtn setTitle:[NSString stringWithFormat:@"已有%@人点赞",str]forState:0];
            
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
