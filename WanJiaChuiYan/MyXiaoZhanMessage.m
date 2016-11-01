//
//  MyXiaoZhanMessage.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyXiaoZhanMessage.h"
#import "KitchenTableViewCell.h"
@interface MyXiaoZhanMessage ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * nameArray;
@end

@implementation MyXiaoZhanMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"小站信息";
    [self leftBtn];
    
    // Do any additional setup after loading the view.
    [self CreatNameArray];
    [self CreatTableView];
}
#pragma mark --初始化数组
-(void)CreatNameArray{
    NSArray * arr1 =@[@"站长账号",@"联系电话"];
    NSArray * arr2 =@[@"厨房地址",@"地图坐标"];
    NSArray * arr3 =@[@"收款方式",@"收款账号"];
    NSArray * arr4 =@[@"小站图片"];
    NSArray * arr5 =@[@"证件存档"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3,arr4,arr5, nil];
    
}
#pragma mark -- 表的创建CreatTableView
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
     _tableView.scrollEnabled=NO;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
#pragma mark --tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_nameArray[section];
    return arr.count;
}
#pragma mark --tableViewDataSoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nameArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KitchenTableViewCell * cell =[KitchenTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    cell.textField.enabled=NO;
    cell.arrowImage.hidden=YES;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textField.text=_model.pingTaiAccount;
        }else{
           cell.textField.text=_model.phoneNumber;
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            cell.textField.text=_model.address;
        }else{
           cell.textField.text=_model.zuoBiao;
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
           cell.textField.text=_model.payStye;
            
        }else{
            cell.textField.text=_model.payCode;
            
        }
    }else if(indexPath.section==3){
         cell.imagebgView.hidden=NO;
        //小站图片(只能上传一张)
        [cell.addBtn setBackgroundImageForState:0 withURL:[NSURL URLWithString:_model.xiaoZhanImage] placeholderImage:[UIImage imageNamed:@"photomy"]];
    }else{
         cell.imagebgView.hidden=NO;
        //证件存档(最多4张)
        [self CreatCell:cell];
    }
    
    
    
    
    return cell;
}
-(void)CreatCell:(KitchenTableViewCell*)cell{
    
    for (int i =0; i<_model.imageArr.count; i++) {
        UIImageView * imageview =[[UIImageView alloc]init];
        imageview.userInteractionEnabled=YES;
        imageview.frame=CGRectMake((60+10)*i, 0, 60, 60);
        NSString * url =_model.imageArr[i];
        [imageview setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photomy"]];
        [cell.imagebgView addSubview:imageview];
    }
    
    
    
    
}
#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 80;
    }else if (indexPath.section==4){
        return 80;
    }
    else{
        return 50;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
