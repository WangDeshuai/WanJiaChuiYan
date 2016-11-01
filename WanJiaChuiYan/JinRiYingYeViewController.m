//
//  JinRiYingYeViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "JinRiYingYeViewController.h"
#import "TodayBusineTableViewCell.h"
#import "TodatModel.h"
@interface JinRiYingYeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
//    BOOL  _flag[13];
//    int  _geshu[13];
//    int _section[13];//在上报那用
//    UISwitch * _lastswith;
    NSInteger tagg;
}
@property(nonatomic,retain)UIView * viewToday;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * nameArray;
@property(nonatomic,assign)BOOL isInsert;
@property(nonatomic,copy)NSString * timeDate;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation JinRiYingYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"今日营业";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatArray];
   // [self rigthBtn];
//    [self CreatView];
    [self quiteToday];
}
-(void)rigthBtn{
    
    UIButton * fabu =[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
    [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(shangBao) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(0,0, 104/2, 57/2);
    
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    
}
-(void)CreatArray{
    _nameArray=[[NSMutableArray alloc]init];
    _isInsert=NO;
    _dataArray=[NSMutableArray new];
   
}

#pragma mark --查询今日营业详情
-(void)quiteToday
{
    
    [Engine quiteTodayXiangQingsuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            NSArray * array =[contentDic objectForKey:@"reportList"];
            
            _timeDate=[contentDic objectForKey:@"cook_time"];
            for (NSDictionary * reportListDic in array)
            {
                TodatModel *  modelToday=[[TodatModel alloc]initWithMenuDic:reportListDic];
                [_dataArray addObject:modelToday];
            }
//            for (int i =0; i<_dataArray.count; i++)
//            {
//                TodatModel *  modelToday=_dataArray[i];
//                _geshu[i] = [modelToday.number intValue];
//                if (modelToday.isopen==YES)
//                {
//                  _flag[i]=YES;
//                }
//            }
             [self CreatView];
            [_tableView reloadData];
        }
        
        
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark --view1
-(void)CreatView{
    _viewToday=[[UIView alloc]init];
    _viewToday.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[_viewToday]];
    _viewToday.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,5)
    .heightIs(50);
    UILabel * nameLable =[UILabel new];
    nameLable.alpha=.7;
    nameLable.font=[UIFont systemFontOfSize:15];
    nameLable.text=@"今日营业";
    [_viewToday sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(_viewToday,15)
    .heightIs(20)
    .centerYEqualToView(_viewToday);
    [nameLable setSingleLineAutoResizeWithMaxWidth:100];
    
    UISwitch * swich =[UISwitch new];
    swich.transform = CGAffineTransformMakeScale(0.75, 0.75);
    if (_isopen==YES) {
        [swich setOn:YES animated:YES];
         [self CreatTableView];
    }else{
        [swich setOn:NO animated:YES];
    }
   
    [swich addTarget:self action:@selector(getValue:) forControlEvents:UIControlEventValueChanged];
    [_viewToday sd_addSubviews:@[swich]];
    swich.sd_layout
    .rightSpaceToView(_viewToday,10)
    .centerYEqualToView(_viewToday);
    
  
}
#pragma mark --最上面的开关
-(void)getValue:(UISwitch*)swi2{
    
    if (swi2.isOn) {
        NSLog(@"On");
        [Engine todayTijiaoStyle:@"1" success:^(NSDictionary *dic)
         {
             NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];//;
             if ([code isEqualToString:@"1"])
             {
                  [self CreatTableView];
                 [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                 //[self.navigationController popViewControllerAnimated:YES];
             }
         } error:^(NSError *error) {
             
         }];
       
        
    }else{
        NSLog(@"Off");
        [_tableView removeFromSuperview];
        [Engine todayTijiaoStyle:@"0" success:^(NSDictionary *dic)
         {
             NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];//;
             if ([code isEqualToString:@"1"])
             {
                 [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         } error:^(NSError *error) {
             
         }];
//        [Engine closeTodayYingYesuccess:^(NSDictionary *dic) {
//            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
//            
//            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//            if ([code isEqualToString:@"1"]) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            
//            
//        } error:^(NSError *error) {
//            
//        }];
        
    }
}

-(void)CreatTableView{
    
    
    if (!_tableView) {
    _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 55, ScreenWidth , ScreenHeight-64-55);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.backgroundColor=[UIColor clearColor];
     _tableView.tableHeaderView=[self tablViewHead];
    [self.view addSubview:_tableView];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
   
}
#pragma mark --表头
-(UIView *)tablViewHead{
    
    
    UIView * timeView=[UIView new];
    timeView.backgroundColor=[UIColor clearColor];
    
    timeView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,55)
    .heightIs(50);
    
    UILabel * timeLabl =[UILabel new];
    timeLabl.textAlignment=0;
    timeLabl.text=_timeDate;//@"2016-08-20";
    timeLabl.alpha=.7;
    timeLabl.font=[UIFont systemFontOfSize:15];
    [timeView sd_addSubviews:@[timeLabl]];
    timeLabl.sd_layout
    .leftSpaceToView(timeView,15)
    .centerYEqualToView(timeView)
    .heightIs(20);
    [timeLabl setSingleLineAutoResizeWithMaxWidth:200];
    
    return timeView;
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _dataArray.count;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_flag[section]==NO)
//    {
//        return 0;
//    }else{
//        return 1;
//    }
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
   // TodayBusineTableViewCell * cell =[TodayBusineTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    TodatModel *  modelToday=_dataArray[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    cell.textLabel.text=modelToday.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@份",modelToday.number];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.alpha=.7;
    
    
    
    //    cell.textfiled.tag=indexPath.section;
//    cell.textfiled.delegate=self;
//    TodatModel *  modelToday=_dataArray[indexPath.section];
//    _section[indexPath.section]=(int)indexPath.section+10;
//  //  _geshu[indexPath.section] = [modelToday.number intValue];
//    
//    if ([cell.textfiled.text isEqualToString:@"0"]) {
//        [cell.swich setOn:NO animated:YES];
//      
//    }
//    
//   else if (modelToday.isopen==YES) {
//        cell.textfiled.text=modelToday.number;
//    }
    
    return cell;
}

//////设置区头按钮
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView * bgview =[UIView new];
//    bgview.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
//   TodatModel * md =_dataArray[section];
//
//    UILabel * menLable =[UILabel new];
//    menLable.textColor=[UIColor blackColor];
//    menLable.font=[UIFont systemFontOfSize:15];
//    menLable.alpha=.6;
//    menLable.text=md.name;
//    [bgview sd_addSubviews:@[menLable]];
//    menLable.sd_layout
//    .leftSpaceToView(bgview,15)
//    .topSpaceToView(bgview,0)
//    .bottomSpaceToView(bgview,0);
//    [menLable setSingleLineAutoResizeWithMaxWidth:160];
//    
//    
//    UISwitch * swith =[[UISwitch alloc]init];
//    swith.transform = CGAffineTransformMakeScale(0.75, 0.75);
//    swith.on=_flag[section];
//    [bgview sd_addSubviews:@[swith]];
//    swith.tag=section;
//    [swith addTarget:self action:@selector(kaiGuan:) forControlEvents:UIControlEventValueChanged];
//    swith.sd_layout
//    .rightSpaceToView(bgview,10)
//    .centerYEqualToView(bgview);
//    return bgview;
//    
//}
//#pragma mark --区头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}


//#pragma mark --点击区头按钮
//-(void)kaiGuan:(UISwitch*)swith{
//    TodayBusineTableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:swith.tag]];
//    
//    if (swith.isOn) {
//    }else{
//      
//        cell1.textfiled.text=@"0";
//       // NSLog(@"输出%@",cell1.textfiled.text);
//        
//        for (int i =0; i<_dataArray.count; i++)
//        {
//            if (i==swith.tag) {
//               _geshu[i] = 0;
//            }
//           
//        }
//    }
//    _flag[swith.tag]=!_flag[swith.tag];
//    //索引集合
//    //把区号放到索引集合中,NSIndexSet代表索引集合
//    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:swith.tag];
//   // 刷新某一个区
//    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//  
//    _geshu[textField.tag] = [textField.text intValue];
//}
//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark --上报
-(void)shangBao{
    
    if (!_tableView) {
        NSLog(@"表隐藏，是关闭的");
        [LCProgressHUD showMessage:@"这就是关闭状态"];
//        [Engine todayTijiaoStyle:@"0" success:^(NSDictionary *dic) {
//            
//        } error:^(NSError *error) {
//            
//        }];
    }else  {
        NSLog(@"表显示，是打开的的");
        [Engine todayTijiaoStyle:@"1" success:^(NSDictionary *dic)
        {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];//;
            if ([code isEqualToString:@"1"])
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
    
        //TodatModel * md =_dataArray[section];
   
    
//    UIAlertController * actionview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认上报" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        NSMutableArray * shuZuArr =[NSMutableArray new];
//        for (int j = 0; j<_dataArray.count; j++)
//        {
//            if (_section[j]!=0) {
//                NSMutableDictionary * dic =[NSMutableDictionary new];
//                TodatModel * md =_dataArray[_section[j]-10];
//                [dic setObject:md.menu_id forKey:@"menu_id"];
//                NSLog(@"我看看%d",_geshu[j]);
//                [dic setObject:[NSString stringWithFormat:@"%d",_geshu[j]] forKey:@"number"];
//                [shuZuArr addObject:dic];
//            }
//            
//        }
//        NSString * jsonStr =[XYString jsonString:shuZuArr];
//        //    NSLog(@"输出%@",jsonStr);
//        [Engine todayShangBao:jsonStr success:^(NSDictionary *dic) {
//            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
//            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//            if ([code isEqualToString:@"1"])
//            {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            
//            
//        } error:^(NSError *error) {
//            
//        }];
//        
//
//        
//    }];
//    [actionview addAction:action1];
//    [actionview addAction:action];
//    [self presentViewController:actionview animated:YES completion:nil];
//    
    
    
}

- (void) hideKeyboard {
    // [_tableView resignFirstResponder];
    [_tableView endEditing:YES];
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
