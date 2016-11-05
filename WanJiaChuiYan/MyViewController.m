//
//  MyViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyTableViewCell.h"
#import "MyInformationViewController.h"
#import "FoodStampViewController.h"
#import "MyOrderViewController.h"
#import "PeopleActingViewController.h"
#import "PromotionCodeViewController.h"
#import "WanJiaChuFangViewController.h"
#import "MyXiaoZhanViewController.h"
#import "PeopleDaiLingModel.h"
#import "ContactKeFuViewController.h"
#import "RecruitmentViewController.h"
#import "MyQuCanDianVC.h"
#import "JPUSHService.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel * nameLabel;
}
@property(nonatomic,retain)PeopleDaiLingModel * model;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * imageArray;
@property(nonatomic,retain)NSMutableArray * labelArray;
@property(nonatomic,retain)NSMutableArray * btnArray;
@end

@implementation MyViewController


-(void)viewWillAppear:(BOOL)animated{
    [self StarArray];
    [self CreatTableView];
    [self.view bringSubviewToFront:self.tabbarView];
    //是否是登录还是退出
    if([ToolClass isLogin])
    {
        
       [self shenFenGengGai];
    }
    

  
    
    
    
}

#pragma mark --判断身份是否进行了更改
-(void)shenFenGengGai{
    [Engine isLoginTuiChusuccess:^(NSDictionary *dic) {
        //通过返回的数据类型与本地现有类型做比较
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        NSString * type =[ToolClass userType];
        
        if ([content isEqualToString:type]) {
            //相同
            NSLog(@"相同");
            
        }else{
            //不同
             [self tuichul];
            UIAlertController * action =[UIAlertController alertControllerWithTitle:@"提示" message:@"您的身份已被管理人员进行了更改\n请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:action animated:YES completion:nil];
            
            UIAlertAction * act =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self tuichul];
            }];
            
            [action addAction:act];
        }
        
    } error:^(NSError *error) {
        
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"我的";
    
    UIButton* tabBar3= [self.tabbarView viewWithTag:3];
    tabBar3.selected=YES;
    [self.view bringSubviewToFront:self.tabbarView];
}


#pragma mark --找人带领开关状态
-(void)switchStyeOn{
    [Engine PeopleDaiLingSwitchOnsuccess:^(NSDictionary *dic) {
        
        _model=[[PeopleDaiLingModel alloc]initWithZhaoRenDic:dic];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
    
}

#pragma mark -- 数组初始化
-(void)StarArray{
    NSArray * arr1 =@[@"kitchenmy"];
    NSArray * arr11 =@[@"housemy"];
    NSArray * arr2 =@[@"qucandian",@"foodmy"];
    NSArray * arr3 =@[@"dailingmy",@"ping",@"phonemy"];
    NSArray * arr4 =@[@"111"];
    
    NSArray * label1 =@[@"我是万家厨房"];
    NSArray * label11 =@[@"我是炊烟小站"];
    NSArray * label2 =@[@"我的取餐点",@"我的粮票/餐具"];
    NSArray * label3=@[@"找人代领",@"招兵买马",@"联系客服"];
    NSArray * label4=@[@"退出登录"];
   //_imageArray rem
    _imageArray =nil;
    _labelArray=nil;
    
    if (!_imageArray) {
         _imageArray=[NSMutableArray new];
         _labelArray=[NSMutableArray new];
    }
   
    NSString * type =[ToolClass userType];
    NSLog(@"我看看现在type=%@",type);
    if ([type isEqualToString:@"1"]) {
        //普通用户
        [_imageArray addObject:arr2];
        [_imageArray addObject:arr3];
        [_imageArray addObject:arr4];
        [_labelArray addObject:label2];
        [_labelArray addObject:label3];
        [_labelArray addObject:label4];
        
        
    }else if ([type isEqualToString:@"2"]){
        //厨房
        [_imageArray addObject:arr1];
        [_imageArray addObject:arr2];
        [_imageArray addObject:arr3];
        [_imageArray addObject:arr4];
        [_labelArray addObject:label1];
        [_labelArray addObject:label2];
        [_labelArray addObject:label3];
        [_labelArray addObject:label4];
    }else {
        //小站  //副站长
        [_imageArray addObject:arr11];
        [_imageArray addObject:arr2];
        [_imageArray addObject:arr3];
        [_imageArray addObject:arr4];
        [_labelArray addObject:label11];
        [_labelArray addObject:label2];
        [_labelArray addObject:label3];
        [_labelArray addObject:label4];
        
    }

   
    [_tableView reloadData];
    
}
#pragma mark -- CreatTableView
-(void)CreatTableView{
    if (!_tableView) {
      _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    }
  
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView=[self TableViewHeadView];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _imageArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray * arr =_imageArray[section];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    MyTableViewCell * cell =[MyTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    [cell.imageBtn setImage:[UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]] forState:0];
     cell.nameLabel.text =_labelArray[indexPath.section][indexPath.row];
    
   
    
    
    

    return cell;
}

#pragma mark -- 表头
-(UIView*)TableViewHeadView{
    UIView * headView =[[UIView alloc]init];
    headView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    //美工不给图，为了适配 只能写多个坐标
    if (ScreenHeight==480) {
        headView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.view,0)
        .heightIs(ScreenHeight/3);
    }else{
        headView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.view,0)
        .heightIs(ScreenHeight/3-20);
    }
    
    //大的背景图
    UIImageView * imageviewHead=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bghead"]];
    imageviewHead.userInteractionEnabled=YES;
    [headView sd_addSubviews:@[imageviewHead]];
    imageviewHead.sd_layout
    .leftSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .heightIs(ScreenWidth*127/375);
    //白圈
    UIImageView * writeImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"whitemy"]];
    writeImage.userInteractionEnabled=YES;
    [imageviewHead sd_addSubviews:@[writeImage]];
   
    if (ScreenHeight==480) {
        writeImage.sd_layout
        .centerXEqualToView(imageviewHead)
        .topSpaceToView(imageviewHead,0)
        .widthIs(154/2.5)
        .heightIs(154/2.5);
    }else{
        writeImage.sd_layout
        .centerXEqualToView(imageviewHead)
        .topSpaceToView(imageviewHead,10)
        .widthIs(154/2)
        .heightIs(154/2);
    }
    
    //头像
  UIButton* headImage =[[UIButton alloc]init];
    
    headImage.sd_cornerRadius=@(38);
    //int aaLine=0;
    if (lineImage==nil ) {
        NSDictionary* dicc= [XYString duquPlistWenJianPlistName:@"base"];
        NSString * url =[dicc objectForKey:@"headimgurl"];
      //  NSLog(@"输出头像%@",url);
        [headImage setImageForState:0 withURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photomy"]];
    }else{
      [headImage setBackgroundImage:lineImage forState:0];
       
       // lineImage=nil;
    }
   
    [headImage addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [writeImage sd_addSubviews:@[headImage]];
    if (ScreenHeight==480) {
        headImage.sd_layout
        .centerXEqualToView(writeImage)
        .centerYEqualToView(writeImage)
        .widthIs(150/2.5)
        .heightIs(150/2.5);
    }else{
        headImage.sd_layout
        .centerXEqualToView(writeImage)
        .centerYEqualToView(writeImage)
        .widthIs(150/2)
        .heightIs(150/2);
    }
    
   
//
    //name(名字)
    nameLabel=[[UILabel alloc]init];
    if ([ToolClass isLogin]==YES) {
        nameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    }else{
        nameLabel.text=@"登录/注册";
    }
    nameLabel.textColor=[UIColor colorWithRed:82/255.0 green:236/255.0 blue:135/255.0 alpha:1];
    nameLabel.font=[UIFont systemFontOfSize:18];
    [imageviewHead sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .centerXEqualToView(imageviewHead)
    .bottomSpaceToView(imageviewHead,10)
    .heightIs(25);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    
    //个人资料Btn
    UIButton * btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"personmy"] forState:0];
    btn1.tag=10;
    [btn1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[btn1]];
    btn1.sd_layout
    .leftSpaceToView(headView,0)
    .topSpaceToView(imageviewHead,0)
    .widthIs(ScreenWidth/3)
    .bottomSpaceToView(headView,0);
    //我的推广码
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"minemy"] forState:0];
    btn2.tag=20;
   [btn2 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[btn2]];
    btn2.sd_layout
    .leftSpaceToView(btn1,0)
    .topEqualToView(btn1)
    .widthRatioToView(btn1,1)
    .heightRatioToView(btn1,1);
    //我的订单
    UIButton * btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setImage:[UIImage imageNamed:@"dingdanmy"] forState:0];
    btn3.tag=30;
   [btn3 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[btn3]];
    btn3.sd_layout
    .leftSpaceToView(btn2,0)
    .topEqualToView(btn2)
    .widthRatioToView(btn2,1)
    .heightRatioToView(btn2,1);
    
    return headView;
}

#pragma mark --点击表的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
    
    
    if(![ToolClass isLogin])
    {
      
        LoginViewController * vc =[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }

    [Engine isLoginTuiChusuccess:^(NSDictionary *dic) {
        //通过返回的数据类型与本地现有类型做比较
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        NSString * type =[ToolClass userType];
        
        if ([content isEqualToString:type]) {
            //相同
            NSLog(@"相同");
            NSString * type =[ToolClass userType];
            if ([type isEqualToString:@"1"]) {
                //普通用户
                [self ordinaryUserName:indexPath section:0];
            }else{
                //万家厨房或者
                [self WanJiaChuFang:indexPath];
            }
            
        }else{
            //不同
            [self tuichul];
            UIAlertController * action =[UIAlertController alertControllerWithTitle:@"提示" message:@"您的身份管理人员已进行了更改\n请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:action animated:YES completion:nil];
            
            UIAlertAction * act =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self tuichul];
            }];
            
            [action addAction:act];
        }
        
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
}
#pragma mark --没有登录挑战登录界面
-(void)logine{
    if(![ToolClass isLogin])
    {
        LoginViewController * vc =[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
}
#pragma mark --普通用户点击表格
-(void)ordinaryUserName:(NSIndexPath*)indexPath section:(int)section{
    
    
//    if(![ToolClass isLogin])
//    {
//        LoginViewController * vc =[[LoginViewController alloc]init];
//        [self presentViewController:vc animated:YES completion:nil];
//        return;
//    }
    
    
    if (indexPath.section==section)
    {
        //[self logine];
        if (indexPath.row==0) {
            //我的取餐点
            //我的取餐点
            MyQuCanDianVC * vc =[MyQuCanDianVC new] ;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //我的粮票
        FoodStampViewController * vc =[FoodStampViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section==section+1){
        // [self logine];
        if (indexPath.row==0) {
            // 找人代领
        PeopleActingViewController * vc =[PeopleActingViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //招兵买马
//
            RecruitmentViewController * vc =[RecruitmentViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //联系客服
            ContactKeFuViewController * vc =[ContactKeFuViewController new];
             [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section==section+2){
        //退出
        if ([ToolClass isLogin]) {
           [self TuiChu];
        }
        
    }
    
        


}

#pragma mark --退出登录
-(void)TuiChu{
    
    UIAlertController * action =[UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认退出" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:action animated:YES completion:nil];
    
    UIAlertAction * act =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self tuichul];
    }];
    UIAlertAction * act2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [action addAction:act2];
    [action addAction:act];
    
}

#pragma mark --确认退出
-(void)tuichul{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"zhuceid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [XYString deleagtePlistName:@"base"];
    [XYString deleagtePlistName:@"regist"];
    
    _tableView.tableHeaderView= [self TableViewHeadView];
    [_tableView reloadData];
    [self StarArray];//掉这个的目的是 退出后返回1个区，及最原始状态
    
    [JPUSHService setTags:[NSSet set] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];

}

#pragma mark --万家厨房或者小站
-(void)WanJiaChuFang:(NSIndexPath*)indexPath{
    
    if(![ToolClass isLogin])
    {
        LoginViewController * vc =[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    if (indexPath.section==0) {
         NSString * type =[ToolClass userType];
        if ([type isEqualToString:@"2"]) {
        //万家厨房
        WanJiaChuFangViewController * vc =[WanJiaChuFangViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            
          
        //小站或者副站长
        MyXiaoZhanViewController * vc =[MyXiaoZhanViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
         [self ordinaryUserName:indexPath section:1];
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


#pragma mark --登录按钮
-(void)loginBtn{
   
    if (![ToolClass isLogin]) {
         //没有登录
        LoginViewController * vc =[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        //登录后就可以选择头像了
        [self dioayongXiangCe];
        
    }
    
}
#pragma mark --调用系统相册
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    lineImage=image;
    _tableView.tableHeaderView=[self TableViewHeadView];
    [_tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
    [LCProgressHUD showLoading:@"正在上传头像..."];
    CGSize size =CGSizeMake(image.size.width,image.size.height );
    NSData *imgData=[XYString imageWithImage:image scaledToSize:size];
    [self shangChuanImage:imgData];
    
}

#pragma mark --在上传图片获取地址呢
-(void)shangChuanImage:(NSData*)data{
    
    [Engine shangChuanData:data success:^(NSDictionary *dic) {
        [LCProgressHUD showInfoMsg:[dic objectForKey:@"msg"]];
        
        NSString * url =[dic objectForKey:@"content"];
        [self imageShangChuanSearchUrl:url];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --把图片地址传到服务器
-(void)imageShangChuanSearchUrl:(NSString*)url{
    [LCProgressHUD showLoading:@"正在保存头像..."];
    [Engine upDataMessageValue:url filedName:@"headimgurl" success:^(NSDictionary *dic) {
       
        [LCProgressHUD showInfoMsg:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * content =[dic objectForKey:@"content"];
            [XYString savePlist:content name:@"base"];
        }
        
        
    } error:^(NSError *error) {
        
    }];
    
    
}




#pragma mark --三个按钮的点击
-(void)button1:(UIButton*)btn{
    if(![ToolClass isLogin]){
        LoginViewController * vc =[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    if (btn.tag==10) {
        NSLog(@"个人资料");
        MyInformationViewController * vc =[MyInformationViewController new];
        vc.lastOn=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==20){
        NSLog(@"我的推广码");
        PromotionCodeViewController * vc =[PromotionCodeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (btn.tag==30){
        NSLog(@"我的订单");
        MyOrderViewController * vc =[MyOrderViewController new];
        [self.navigationController pushViewController:vc animated:YES];
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

@end
