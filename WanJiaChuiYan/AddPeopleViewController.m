//
//  AddPeopleViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AddPeopleViewController.h"
#import "PeopleActingTableViewCell.h"
#import "AddPeopleTableViewCell.h"
@interface AddPeopleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation AddPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"添加";
    // Do any additional setup after loading the view.
    [self rightBtn];
    [self leftBtn];
    [self CreatTableView];
}
#pragma mark --创建表格
-(void)CreatTableView{
    if (!_tableView) {
         _tableView=[[UITableView alloc]init];
    }
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50);
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    
    AddPeopleTableViewCell * cell =[AddPeopleTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
   
    if (indexPath.row==0) {
        cell.nameLabel.text=@"昵称";
        cell.textFiled.placeholder=@"可以选填";
    }else{
        cell.nameLabel.text=@"账号";
        cell.textFiled.placeholder=@"已在平台注册的手机号";
        cell.textFiled.keyboardType=UIKeyboardTypeNumberPad;
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    [fabu setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
-(void)save{
    //  姓名
    AddPeopleTableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //账号
    AddPeopleTableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (_number==1) {
        NSString * str;
        if ([cell1.textFiled.text isEqualToString:@""]) {
            NSLog(@"是空的");
            str=@"";
        }else{
            str=cell1.textFiled.text;
        }
        [Engine appAddDaiLingRenAccount:cell2.textFiled.text Name:str success:^(NSDictionary *dic) {
            NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([ss isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
    }else{
        
        [Engine AddFuZhanZhangAccount:cell2.textFiled.text Name:cell1.textFiled.text success:^(NSDictionary *dic) {
            NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([ss isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        } error:^(NSError *error) {
            
        }];
        
        
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) hideKeyboard {
   // [_tableView resignFirstResponder];
    [_tableView endEditing:YES];
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
