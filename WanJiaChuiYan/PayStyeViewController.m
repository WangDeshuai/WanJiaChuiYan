//
//  PayStyeViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PayStyeViewController.h"
#import "PayStyeTableViewCell.h"
@interface PayStyeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * _lastBtn;
    NSInteger indexpathRow;
}
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * leftArray;
@property(nonatomic,retain)NSMutableArray * nameArray;
@end

@implementation PayStyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"收款方式";
    // Do any additional setup after loading the view.
    [self leftBtn];
    [self CreatArray];
    [self CreatLabel];
    [self CreatTableView];
}
#pragma mark --初始化数组
-(void)CreatArray{
    _leftArray=[NSMutableArray new];
    [_leftArray addObject:@"zhifubao"];
    [_leftArray addObject:@"微信"];
    [_leftArray addObject:@"ka"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:@"支付宝",@"微信",@"银行卡", nil];
}
#pragma mark --初始化Label
-(void)CreatLabel
{
    _nameLabel=[UILabel new];
    _nameLabel.text=@"请选择收款方式";
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.alpha=.8;
    [self.view addSubview:_nameLabel];
    _nameLabel.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(self.view,20)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}
#pragma mark --初始化表
-(void)CreatTableView{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_nameLabel,15)
    .bottomSpaceToView(self.view,50);
    
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"shoukuan_sure"] forState:0];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[sureBtn]];
    sureBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50);
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _nameArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
     PayStyeTableViewCell * cell =[PayStyeTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    [cell.leftImage setImage:[UIImage imageNamed:_leftArray[indexPath.row]] forState:0];
    
    cell.nameLabel.text=_nameArray[indexPath.row];
    cell.rightImage.tag=indexPath.row;
    [cell.rightImage addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row==0) {
        cell.rightImage.selected=YES;
        _lastBtn=cell.rightImage;
   }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
#pragma mark --右边按钮
-(void)rightBtn:(UIButton*)btn{
    _lastBtn.selected=!_lastBtn.selected;
    _lastBtn=btn;
    btn.selected=!btn.selected;
    indexpathRow=btn.tag;
}
#pragma mark --确认按钮
-(void)sure{
    self.payStyeBlock(_nameArray[indexpathRow]);
    [self.navigationController popViewControllerAnimated:YES];
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
