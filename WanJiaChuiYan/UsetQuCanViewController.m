//
//  UsetQuCanViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UsetQuCanViewController.h"

@interface UsetQuCanViewController ()

@end

@implementation UsetQuCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"开启用户取餐";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatUserQuCan];
}
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"确定" forState:0];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(reladbtn) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
-(void)CreatUserQuCan{
    UIView * bgView =[[UIView alloc]init];
    bgView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[bgView]];
    
    bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,15);
    
    
    UILabel * titleLable =[UILabel new];
    UILabel * nameLable =[UILabel new];
    UISwitch * swith =[UISwitch new];
    
    [bgView sd_addSubviews:@[titleLable,nameLable,swith]];
   
    titleLable.alpha=.8;
    titleLable.font=[UIFont systemFontOfSize:15];
    nameLable.alpha=.6;
    nameLable.font=[UIFont systemFontOfSize:15];
    nameLable.numberOfLines=0;
    titleLable.text=@"开启用户取餐";
    nameLable.text=@"开启用户取餐后，用户到指定的取餐点，点击立即领取即可取餐";
    
    swith.transform = CGAffineTransformMakeScale(0.75, 0.75);
    if (_model.isOpen==YES) {
        [swith setOn:YES animated:YES];
    }else{
         [swith setOn:NO animated:YES];
    }
     [swith addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
    swith.sd_layout
    .rightSpaceToView(bgView,10)
    .centerYEqualToView(titleLable);
    
    
    
    titleLable.sd_layout
    .leftSpaceToView(bgView,15)
    .topSpaceToView(bgView,10)
    .heightIs(30);
    [titleLable setSingleLineAutoResizeWithMaxWidth:100];
    
    nameLable.sd_layout
    .leftEqualToView(titleLable)
    .topSpaceToView(titleLable,10)
    .rightSpaceToView(bgView,15)
    .heightIs(40);
    
    
    
    [bgView setupAutoHeightWithBottomView:nameLable bottomMargin:15];
    
}
-(void)getValue1:(UISwitch*)swith{
    [Engine isNotQuCansuccess:^(NSDictionary *dic) {
       // NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --确定
-(void)reladbtn{
    
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
