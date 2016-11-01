//
//  SettlementViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SettlementViewController.h"
#import "SettlementTableViewCell.h"
#import "SettlementModel.h"
#import "PayStyeDaFan.h"
@interface SettlementViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isOpen;
    MenData * dao;
    ZYData * daozy;
    NSString * priceJiaGe;
}
@property(nonatomic,retain)NSMutableArray * nameArray;
@property(nonatomic,retain)NSMutableArray * addArray;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)SettlementModel * model;
@property(nonatomic,retain)NSMutableArray * menuIdArray;
@end

@implementation SettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"确认订单";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self StarArray];
    [self getOrderMessage];//获取订单基本信息
    [self getMySqliteData];
   
   
    //[self submitOrder];
}
#pragma mark --价格
-(NSString * )jiage{
    daozy=[[ZYData alloc]init];
    [daozy connectSqlite];
    NSMutableArray * zongArray=[NSMutableArray new];
    NSArray * arr =[daozy searchAllPeople];
    NSEnumerator *enumerator = [arr reverseObjectEnumerator];
    arr =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    for (The_Menu * men  in arr) {
        float a= [men.price1 floatValue]+[men.price2 floatValue]+[men.price3 floatValue];
        float b=a*[men.fenShu floatValue];
        NSString * bb =[NSString stringWithFormat:@"%f",b];
        [zongArray addObject:bb];
    }
    NSNumber * sum = [zongArray valueForKeyPath:@"@sum.floatValue"];
    //priceJiaGe=[NSString stringWithFormat:@"%@元",sum];
    
    return [NSString stringWithFormat:@"%@",sum];
}
#pragma mark --数组初始化
-(void)StarArray{
    NSArray * arr1 =@[@"订单编号",@"订单金额",@"订单饭菜"];
    NSArray * arr2 =@[@"取餐时间",@"取餐地点"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,nil];
    _addArray=[[NSMutableArray alloc]init];
    _menuIdArray=[[NSMutableArray alloc]init];
}
#pragma mark --获取订单信息
-(void)getOrderMessage
{
    [Engine getOrderMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            _model=[[SettlementModel alloc]initWithOrderDic:[dic objectForKey:@"content"]];
        }
       // [_tableView reloadData];
         [self CreatTableView];
    } error:^(NSError *error) {
        
    }];
    
}


#pragma mark --读取数据库中数据
-(void)getMySqliteData{
    dao=[[MenData alloc]init];
    [dao connectSqlite];
    
    
   
//    NSMutableArray * name1=nil;
//    NSMutableArray * name2=nil;
//    NSMutableArray *name3=nil;
//    for (The_Menu * menu in arr) {
//        //NSLog(@"%@-%@-%@",menu.name1,menu.name2,menu.name3);
//       
//    }
//    NSLog(@"%lu>>>%lu>>>%lu",name1.count,name2.count,name3.count);
    
}



#pragma mark -- CreatTableView
-(void)CreatTableView{
    if (!_tableView) {
         _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _isOpen=YES;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray * ar =_nameArray[section];
    return ar.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    SettlementTableViewCell * cell =[SettlementTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLable.text=_nameArray[indexPath.section][indexPath.row];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.contentLabel.text=_model.bianHao;
        }else if (indexPath.row==1){
            //自动计算价格
            cell.contentLabel.text=[NSString stringWithFormat:@"%@元",[self jiage]];//;
            cell.contentLabel.font=[UIFont systemFontOfSize:18];
        }
    }else{
        if (indexPath.row==0) {
            cell.contentLabel.text=[NSString stringWithFormat:@"%@后自取",_model.time];//_model.bianHao;
        }else{
             cell.contentLabel.text=[NSString stringWithFormat:@"%@自取",_model.address];
        }
        
        
        
    }
    
    
    
    return cell;
}

#pragma mark --点击表格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            if (_isOpen==YES) {
                 _isOpen=NO;
            }else{
                 _isOpen=YES;
            }
           
            [_tableView reloadData];
        }
    }
    
}


#pragma mark -- 区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 10;
    }else{
        return 15;
    }
}
#pragma mark -- 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

#pragma mark --区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (_isOpen==YES) {
            return 150;
        }else{
            return 0;
        }
        
        
    }else{
        return 0;
    }
    
}
#pragma mark --区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        UIScrollView * view =[UIScrollView new];
        view.backgroundColor=[UIColor whiteColor];
        view.contentSize=CGSizeMake(ScreenWidth, ScreenHeight);
        NSMutableArray * menArr =[dao allMenName];
        
        for (int i =0; i<menArr.count; i++)
        {
            //NSLog(@">>>看看%lu",menArr.count);
            
            NSMutableArray * ar =menArr[i];
            UILabel * label =[UILabel new];
            [self LableShuXing:label];
            label.frame=CGRectMake(10, 10+(20+10)*i, 120, 20);
            label.text=ar[0];
            [view addSubview:label];
           
           
            
            UILabel * numberLable =[UILabel new];
            [self LableShuXing:numberLable];
            //数组的个数也就是每个菜的份数
            NSString * str =[NSString stringWithFormat:@"x%lu份",ar.count];
            /*
               本来应该显示的是份数
               现在隐藏了，把价格改成了份数
             */
            
           // numberLable.text=str;
            numberLable.frame=CGRectMake(ScreenWidth-120, 10+(20+10)*i, 50, 20);
            [view addSubview:numberLable];
            
            
            UILabel * priceLabel =[UILabel new];
            [self LableShuXing:priceLabel];
          //根据菜名去查询相应的价格ar[0]，每一个菜名，，然后在转换为float类型
           float aa =[[dao searNameWithMenuName:ar[0]] floatValue];
            //份数 * 价格=总价格
            NSString * price =[NSString stringWithFormat:@"%.2f",ar.count* aa];
         /*
          本来应该显示的是价格，但是价格隐藏了，改成份数了，显示多少份
          */
            priceLabel.text=str;//[NSString stringWithFormat:@"¥%@",price];
            priceLabel.frame=CGRectMake(ScreenWidth-60,  10+(20+10)*i, 60, 20);
            [_addArray addObject:price];
            [view addSubview:priceLabel];
            /*
             根据菜名去查询ID caiNameWithMenuNam
             如果ID=0，说明是不点，那就直接过滤掉
             */
            NSString * menuidd =[NSString stringWithFormat:@"%@",[dao caiNameWithMenuNam:ar[0]]];
            
            if (![menuidd isEqualToString:@"0"]) {
                 [_menuIdArray addObject:menuidd];
            }
           
           
            
            
             view.contentSize=CGSizeMake(ScreenWidth, 10+(20+10)*i+20);
            //过滤不点
            if ([ar[0] isEqualToString:@"不点"]) {
                label.hidden=YES;
                numberLable.hidden=YES;
                priceLabel.hidden=YES;
                view.contentSize=CGSizeMake(ScreenWidth, 10+(20+10)*(i-1)+20);
            }
            
            
        }
        [self submitOrder];
        return view;
    }else{
     return nil;
    }
}

#pragma mark --lable属性
-(void)LableShuXing:(UILabel *)label{
    label.font=[UIFont systemFontOfSize:15];
    label.alpha=.6;
    label.textColor=[UIColor blackColor];
}




#pragma mark --底部提交订单
-(void)submitOrder{
    
    
   
    
    //自动计算价格
    NSNumber * sum = [_addArray valueForKeyPath:@"@sum.floatValue"];
    NSString * price=[NSString stringWithFormat:@"%@",sum];
    //NSLog(@"总共的价格是%@",price);
    
    
    
    UIImageView * suView=[UIImageView new];
    suView.image=[UIImage imageNamed:@"sure_bg(1)"];
    suView.backgroundColor=[UIColor whiteColor];
    suView.userInteractionEnabled=YES;
    suView.frame=CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50);
    [self.view addSubview:suView];
//    suView.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .bottomSpaceToView(self.view,0)
//    .heightIs(50);
   // 待支付
    UILabel * payLable =[UILabel new];
    payLable.text=[NSString stringWithFormat:@"待支付%@元",price];//@"待支付¥105元";
    payLable.alpha=.8;
    payLable.font=[UIFont systemFontOfSize:17];
    [suView sd_addSubviews:@[payLable]];
    payLable.sd_layout
    .leftSpaceToView(suView,80)
    .centerYEqualToView(suView)
    .heightRatioToView(suView,1);
    [payLable setSingleLineAutoResizeWithMaxWidth:150];
    
    
    UIButton * tijiaoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    tijiaoBtn.backgroundColor=[UIColor clearColor];
    [tijiaoBtn addTarget:self action:@selector(tijiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [suView sd_addSubviews:@[tijiaoBtn]];
    
    tijiaoBtn.sd_layout
    .rightSpaceToView(suView,0)
    .bottomSpaceToView(suView,0)
    .topSpaceToView(suView,0)
    .widthIs(150);
    
}
#pragma mark --提交订单
-(void)tijiaoBtn{
    
    NSLog(@"点击了提交订单");
    //编号
  //  NSLog(@"%@",_model.bianHao);
    //省市县
    //总金额
    
    ZYData * daoo =[[ZYData alloc]init];
    [daoo connectSqlite];
    NSArray * aray =[daoo searchAllPeople];
    
    if(![ToolClass isLogin])
    {
        
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }else if(aray.count==0){
        [LCProgressHUD showMessage:@"购物车是空的"];
        return;
    }

    
    NSNumber * sum = [_addArray valueForKeyPath:@"@sum.floatValue"];
    NSString * price=[NSString stringWithFormat:@"%@",sum];
    
    NSMutableArray * menArr =[dao allMenName];
    NSMutableArray * array=[NSMutableArray new];
  //  NSLog(@"判断一下%lu",_menuIdArray.count);
    for (int i =0; i<_menuIdArray.count; i++) {
        NSMutableDictionary * dic =[NSMutableDictionary new];
        NSArray * arr =menArr[i];
        NSString * menID =_menuIdArray[i];
      //  NSLog(@"kank%@",menID);
        [dic setObject:menID forKey:@"menu_id"];
        [dic setObject:[NSString stringWithFormat:@"%lu",arr.count] forKey:@"number"];
        
        [array addObject:dic];
    }
 //   NSLog(@"%@",[XYString jsonString:array]);
    NSDictionary * dic =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    if (dic==nil) {
        [LCProgressHUD showMessage:@"您还没有选择地区和取餐点"];
        return;
    }
    
    
    [Engine TiJiaoDaFanMenuOrderBianHao:_model.bianHao Provname:[dic objectForKey:@"shengName"] CityName:[dic objectForKey:@"cityName"] TotalMoney:price Order:[XYString jsonString:array] success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
         [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        if ([code isEqualToString:@"501"] || [code isEqualToString:@"502"]) {
            //501菜品售空
            //502份数不足
           // [self.navigationController popViewControllerAnimated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else if ([code isEqualToString:@"503"]){
            //订单超时可以情况数据库所有内容
            [self deleateGouWuChe];
        }else if([code isEqualToString:@"1"]){
            PayStyeDaFan * vc =[PayStyeDaFan new];
            vc.number=1;
            vc.dingDan=_model.bianHao;
            vc.jiage=[self jiage];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
       
    } error:^(NSError *error) {
        
    }];
    
}

#pragma mark --清空购物车所有菜品
-(void)deleateGouWuChe
{
    //清空第一个表
    ZYData * data =[[ZYData alloc]init];
    [data connectSqlite];
    NSArray * array =[data searchAllPeople];
    for (The_Menu * menu in array) {
        [data deleteWithPeople:menu];
    }
    
    MenData * menDao=[[MenData alloc]init];
    [menDao connectSqlite];
    //把第二个表也删除
    for (TheMenuTwo * menuTwo in [menDao searchAllPeople]) {
        [menDao deleteWithPeople:menuTwo];
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
