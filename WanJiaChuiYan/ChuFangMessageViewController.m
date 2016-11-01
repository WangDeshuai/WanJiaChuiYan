//
//  ChuFangMessageViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChuFangMessageViewController.h"
#import "KitchenTableViewCell.h"

@interface ChuFangMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * nameArray;
@end

@implementation ChuFangMessageViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    //[self.navigationItem setTitle:@"厨房信息"];
     self.title=@"厨房信息";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatNameArray];
    [self CreatTableView];
    
    
}






#pragma mark --初始化数组
-(void)CreatNameArray{
    NSArray * arr1 =@[@"联系电话"];
    NSArray * arr2 =@[@"厨房地址",@"地图坐标"];
    NSArray * arr3 =@[@"收款方式",@"收款账号"];
    NSArray * arr4 =@[@"证件存档"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3,arr4, nil];
}
#pragma mark -- 表的创建CreatTableView
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.bounces=NO;
     _tableView.scrollEnabled=NO;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark --tableViewDataSoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nameArray.count;
}
#pragma mark --tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_nameArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KitchenTableViewCell * cell =[KitchenTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
     cell.textField.enabled=NO;
    cell.textField.alpha=.6;
    if (indexPath.section==0) {
      //  cell.textField.placeholder=@"例如:15032735032";
       // cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        cell.textField.text=_modelMessage.phoneNumber;
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
//            cell.textField.placeholder=@"请详细填写，仅您自己可见，平台保密";
            cell.textField.text=_modelMessage.address;//@"河北石家庄";
        }else{
            cell.textField.text=_modelMessage.zuoBiao;//@"157.43221，38.424223";
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            cell.textField.text=_modelMessage.payStye;//@"银行卡";
        }else{
            cell.textField.text=_modelMessage.payCode;//@"6227000130030601486";
        }
    }else{
        cell.textField.hidden=YES;
        cell.imagebgView.hidden=NO;
        cell.addBtn.hidden=YES;
        [self CreatCell:cell];
    }
    return cell;
}

-(void)CreatCell:(KitchenTableViewCell*)cell{
    
    for (int i =0; i<_modelMessage.imageArr.count; i++) {
        UIImageView * imageview =[[UIImageView alloc]init];
        imageview.userInteractionEnabled=YES;
        imageview.frame=CGRectMake((60+10)*i, 0, 60, 60);
        NSString * url =_modelMessage.imageArr[i];
        [imageview setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photomy"]];
        [cell.imagebgView addSubview:imageview];
    }
    
    
    
   
}


#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 80;
    }else{
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
