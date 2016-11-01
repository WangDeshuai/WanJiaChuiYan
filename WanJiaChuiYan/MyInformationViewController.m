//
//  MyInformationViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyInformationTableViewCell.h"
#import "QrCodeViewController.h"
#import "CityViewController.h"
@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * nameText;
}
@property(nonatomic,retain)UITableView*tableView;
@property(nonatomic,retain)NSMutableArray*nameArray;
@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"个人资料";
    [self leftBtn];
    [self rightBtn];
    [self CreatArray];
    [self CreatTableView];
    
    
   
}

#pragma mark -- 数组初始化
-(void)CreatArray{
    NSArray * arr1 =@[@"头像",@"昵称",@"账号"];
    NSArray * arr2 =@[@"扫描下载"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    
    NSDictionary * dic=[XYString duquPlistWenJianPlistName:@"base"];
    nameText=[dic objectForKey:@"name"];
}



#pragma mark --表的创建
-(void)CreatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
}
#pragma mark -- 表的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr =_nameArray[section];
    return arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyInformationTableViewCell * cell =[MyInformationTableViewCell cellWithTableView:tableView];
   cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.lineImageView.hidden=NO;
            NSDictionary* dicc= [XYString duquPlistWenJianPlistName:@"base"];
            NSString * url =[dicc objectForKey:@"headimgurl"];
            [cell.lineImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photomy"]];

        }else if (indexPath.row==1){
            cell.nameText.hidden=NO;
            cell.nameText.text=[self stringText:nameText Text2:nil];//nil;//@"快乐小厨房";
        }else{
            cell.nameText.hidden=NO;
            cell.nameText.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            cell.nameText.enabled=NO;

        }
        
    }else{
        
            cell.lineImageView.hidden=NO;
            cell.lineImageView.image=[UIImage imageNamed:@"erweima1"];
            [cell sd_addSubviews:@[cell.lineImageView]];
             cell.lineImageView.sd_layout
            .rightSpaceToView(cell,15)
            .centerYEqualToView(cell)
            .widthIs(20)
            .heightIs(20);
        
        
    }
    
    return cell;
}
-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * xx;
    if (text1) {
        xx=text1;
    }else{
        xx=text2;
    }
    
    return xx;
}
#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==1) {
    //我的二维码
    QrCodeViewController * vc =[QrCodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 80;
        }
    }else{
        return 54;
    }
    return 54;
}


#pragma mark -- 区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 20;
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
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    if (_lastOn==YES) {
      [fabu setTitle:@"保存" forState:0];
      [fabu addTarget:self action:@selector(save1) forControlEvents:UIControlEventTouchUpInside];
    }else{
      [fabu setTitle:@"提交" forState:0];
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
//上个界面进来的修改
-(void)save{
   
    //标题
    MyInformationTableViewCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    // NSLog(@"%@",cell1.nameText.text);
     [LCProgressHUD showLoading:@"正在提交..."];
    [Engine AddMineInfomationRegistID:@"" name:cell1.nameText.text QuCanDianID:@"25" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showSuccess:[dic objectForKey:@"msg"]];
            NSDictionary * content =[dic objectForKey:@"content"];
            NSDictionary * baseInfo =[content objectForKey:@"baseInfo"];
           [XYString savePlist:baseInfo name:@"base"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showFailure:[dic objectForKey:@"msg"]];
        }
        
        
    } error:^(NSError *error) {
        
    }];
    
    
    
}

//首次登陆
-(void)save1{
    //NSLog(@"点击了保存");
    
    //标题
    MyInformationTableViewCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
      [LCProgressHUD showLoading:@"正在保存..."];
    [Engine upDataMessageValue:cell1.nameText.text filedName:@"name" success:^(NSDictionary *dic) {
        [LCProgressHUD showInfoMsg:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * content =[dic objectForKey:@"content"];
            [XYString savePlist:content name:@"base"];
        }
 
    } error:^(NSError *error) {
        
    }];
    
  //  NSDictionary * dic=[XYString duquPlistWenJianPlistName:@"base"];
   // NSString * name =[dic objectForKey:@"name"];
   // if ([name isEqualToString:cell1.nameText.text]) {
       // NSLog(@"一样不用修改");
  //  }else{
      //  NSLog(@"不一样保存修改");
   // }
    
    
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_tableView  endEditing:YES];
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
