//
//  FoodStampViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FoodStampViewController.h"
#import "BuyTablewareViewController.h"
@interface FoodStampViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * writeView;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation FoodStampViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self liangPiaoYuE];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"我的粮票";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
     _writeView=[[UIView alloc]init];
  //  [self liangPiaoYuE ];
    [self CreatView];
}
#pragma mark --获取粮票余额
-(void)liangPiaoYuE{
    [Engine quiteLiangPiaosuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            
            [_dataArray addObject:content];
            [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"粮票"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
      //  [_tableView reloadData];
        [self CreatTableView];
    } error:^(NSError *error) {
        
    }];
}
#pragma mark -- tableview创建
-(void)CreatTableView{
   
    if (!_tableView) {
         self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
   
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
     self.tableView.scrollEnabled=NO;
    self.tableView.tableHeaderView=[self talbeViewHead];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
#pragma mark --UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }else{
        return 1;
    }
 }
#pragma mark --UITableViewDataSource代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    cell.textLabel.alpha=.8;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    if (indexPath.section==0) {
        cell.textLabel.text=@"购买餐具";
        cell.imageView.image=[UIImage imageNamed:@"canjv"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if (indexPath.row==0) {
            cell.textLabel.text=@"粮票获取方式";
            cell.imageView.image=[UIImage imageNamed:@"huoqu"];
        }else{
            cell.backgroundColor=[UIColor whiteColor];
            cell.textLabel.numberOfLines=0;
            cell.textLabel.text=@"      方式一：推广码分享给新用户\n\n     方式二：参加平台活动获得";
            
        }
        
    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark --表格点击状态
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //购买餐具
        BuyTablewareViewController * vc =[BuyTablewareViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //粮票获取方式
       // if (_isOpen==YES) {
//            [self dissMiss];
             //[self CreatView];
      //  }else{
            // [self CreatView];
      //  }//
       
    }
    
}

#pragma mark --创建下拉View
-(void)CreatView{
    
    //_isOpen=YES;
    //获取1区0行的cell
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //获取某一行Cell坐标
    CGRect rect = [self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    _writeView.backgroundColor=[UIColor whiteColor];
    _writeView.alpha=1;
    _writeView.frame=CGRectMake(0, rect.origin.y+rect.size.height, ScreenWidth, 70);
    [self.tableView addSubview:_writeView];
    UILabel * label1 =[UILabel new];
    label1.tag=1;
    label1.text=@"方式一：推广码分享给新用户";
    label1.textColor=[UIColor blackColor];
    label1.font=[UIFont systemFontOfSize:14];
    [_writeView sd_addSubviews:@[label1]];
    UILabel * label2 =[UILabel new];
    label2.text=@"方式二：参加平台活动获得";
    label2.tag=2;
    label2.textColor=[UIColor blackColor];
    label2.font=[UIFont systemFontOfSize:14];
     [_writeView sd_addSubviews:@[label2]];
    label1.sd_layout
    .leftSpaceToView(_writeView,50)
    .topSpaceToView(_writeView,10)
    .heightIs(20);
    [label1 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    label2.sd_layout
    .leftEqualToView(label1)
    .topSpaceToView(label1,10)
    .heightIs(20);
    [label2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
}
#pragma mark --收起
-(void)dissMiss{
    _isOpen=NO;
    UILabel * label1 =[_writeView viewWithTag:1];
    UILabel * label2 =[_writeView viewWithTag:2];
    [_writeView removeFromSuperview];
    [label1 removeFromSuperview];
    [label2 removeFromSuperview];
}



#pragma mark -- 表头
-(UIView*)talbeViewHead{
    
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor clearColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(150);
    UIImageView * imageHead =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"money_bg"]];
    [headView sd_addSubviews:@[imageHead]];
    imageHead.userInteractionEnabled=YES;
    imageHead.sd_layout
    .centerXEqualToView(headView)
    .centerYEqualToView(headView)
    .widthIs(697/2)
    .heightIs(220/2);
//    //我的余额
    UIImageView * imageYue=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的余额"]];
    [imageHead sd_addSubviews:@[imageYue]];
    imageYue.sd_layout
    .leftSpaceToView(imageHead,70)
    .topSpaceToView(imageHead,30)
    .widthIs(172/2)
    .heightIs(41/2);
//

//    //价格
    UILabel * priceLabel =[UILabel new];
    priceLabel.textColor=[UIColor whiteColor];
    priceLabel.text=_dataArray[0];//@"11";
    priceLabel.font=[UIFont systemFontOfSize:35];
    [imageHead sd_addSubviews:@[priceLabel]];
    priceLabel.sd_layout
    .leftSpaceToView(imageYue,5)
    .topSpaceToView(imageHead,20)
    .heightIs(30);
    [priceLabel setSingleLineAutoResizeWithMaxWidth:130];
        //元
    UIImageView * imageYuan=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"元"]];
    [imageHead sd_addSubviews:@[imageYuan]];
    imageYuan.sd_layout
    .leftSpaceToView(priceLabel,5)
    .topSpaceToView(imageHead,35)
    .widthIs(28/2)
    .heightIs(27/2);
    return headView;
}




#pragma mark -- 区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else{
        return 10;
    }
}
#pragma mark -- 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            return 80;
        }else{
            return 50;
        }
    }else{
       return 50;
    }
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
