//
//  WeiLingQuVC.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WeiLingQuVC.h"
#import "WeiLingQuTableViewCell.h"
#import "MyOrderModel.h"

@interface WeiLingQuVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UIView * view1;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dateArray;
@end

@implementation WeiLingQuVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabbarView.hidden=YES;
    _dataArray =[NSMutableArray new];
    _dateArray=[NSMutableArray new];
   
    [self getInterNet];
    [self CreatTableView];
}

#pragma mark --获取网络数据
-(void)getInterNet{
   
    
    [Engine MyOrderWeiLingQusuccess:^(NSDictionary *dic) {
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
                MyOrderModel * model =[[MyOrderModel alloc]initWithWeiLingDic:dicc];
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
    timeLabel.text=_dateArray[0];

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
-(void)tapPressImage:(UIGestureRecognizer*)tap{

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *cellid = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
  WeiLingQuTableViewCell * cell =[WeiLingQuTableViewCell cellWithTableView:tableView CellID:cellid indexp:indexPath];
    MyOrderModel * md =_dataArray[indexPath.row];
    cell.model=md;
    cell.immediatelyBtn.tag=indexPath.row;
    cell.tagg=indexPath.row;
   
        //领餐中的那个
    [cell.immediatelyBtn addTarget:self action:@selector(liji:) forControlEvents:UIControlEventTouchUpInside];
       
    cell.queRenBtn.tag=indexPath.row;
    [cell.queRenBtn addTarget:self action:@selector(quren:) forControlEvents:UIControlEventTouchUpInside];
    cell.weiLingQuBtn.tag=indexPath.row;
     [cell.weiLingQuBtn addTarget:self action:@selector(weiquren:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//
      return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[WeiLingQuTableViewCell class] contentViewWidth:[self  cellContentViewWith]];
    
    
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
#pragma mark --领餐中取那个按钮点击
-(void)liji:(UIButton*)btn{
  
    
        UIAlertController * actionview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"没到取餐地点请不要继续下一步操作，\n随意点击会导致您取不到餐" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];//[没到取餐地点][到达取餐地点]
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MyOrderModel * md =_dataArray[btn.tag];
            WeiLingQuTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
            
            [Engine lijiLingQuOrder:md.bianHao success:^(NSDictionary *dic) {
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                if ([code isEqualToString:@"1"]) {
                    cell.backgroundColor=[UIColor whiteColor];
                    btn.enabled=NO;
                    btn.selected=YES;
                    cell.queRenBtn.hidden=NO;
                    cell.weiLingQuBtn.hidden=NO;
                    cell.immediatelyBtn.hidden=YES;
                    cell.fafangImage.hidden=NO;
                    
                }
                
            } error:^(NSError *error) {
                [LCProgressHUD showMessage:@"网络错误"];
            }];
            
            
        }];
        
        [actionview addAction:action1];
        [actionview addAction:action2];
        [self presentViewController:actionview animated:YES completion:nil];



    
    
}

#pragma mark --未领取到
-(void)weiquren:(UIButton*)btn{
    MyOrderModel * md =_dataArray[btn.tag];
    
    UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"敬请谅解" message:@"工作人员会和您联系,双倍返还给您" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Engine querenlingquDanHao:md.bianHao nsnumber:@"0" success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"])
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } error:^(NSError *error) {
            
        }];

    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [actionView addAction:action1];
    [actionView addAction:action2];
    [self presentViewController:actionView animated:YES completion:nil];
    
   
}

#pragma mark --立即领取确认领取
-(void)quren:(UIButton*)btn{
     MyOrderModel * md =_dataArray[btn.tag];
    [Engine querenlingquDanHao:md.bianHao nsnumber:@"1" success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [_dataArray removeObject:md];
            [_tableView reloadData];
        }
        
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark --倒计时
-(void)timeBtn:(UIButton*)btn{
    //设置倒计时总时长
    secondsCountDown = 60*10;//60秒倒计时
    //开始倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    //设置倒计时显示的时间
    NSString * timee=[NSString stringWithFormat:@"距离确认还有%@秒",[self timeFormatted:secondsCountDown]];
    labelText =[UILabel new];
    labelText.text=timee;//@"支付剩余时间:6分30秒";
    labelText.textAlignment=1;
    labelText.frame=CGRectMake(0, 0, 150, 20);
    labelText.backgroundColor=[UIColor whiteColor];
    labelText.font=[UIFont systemFontOfSize:13];
    labelText.textColor=[UIColor redColor];
    labelText.alpha=.6;
    [btn addSubview:labelText];
    

}
-(void)timeFireMethod{
    
    //倒计时-1
    secondsCountDown--;
    NSString * timee=[NSString stringWithFormat:@"距离确认还有%@秒",[self timeFormatted:secondsCountDown]];
    //修改倒计时标签现实内容
    labelText.text=timee;
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [labelText removeFromSuperview];
    }
    
}
//转换成时分秒
- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    //  int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}


-(void)TanKuang:(UIButton*)btn{
    
    UIAlertController * alertController;
    alertController=nil;
    if (!alertController) {
         alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"点击立即领取后订单将在十分钟后\n自动确认领取成功!" preferredStyle:UIAlertControllerStyleAlert];
    }
   
   [self presentViewController:alertController animated:YES completion:nil];
    
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         btn.selected=YES;
        [alertController removeFromParentViewController];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [alertController removeFromParentViewController];
    }];
    
    
   
    [alertController addAction:action2];
     [alertController addAction:action1];
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
