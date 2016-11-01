//
//  BaseViewController.m
//  TableBar
//
//  Created by Macx on 16/7/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBackGroundImage];
    [self initTabBar];
}


-(void)initBackGroundImage{
    UIImageView * imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    imageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:imageView];
}


#pragma mark --自定义tabbar
-(void)initTabBar{
    _tabbarView=[[UIView alloc]init];
    _tabbarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_bg"]];
    [self.view sd_addSubviews:@[_tabbarView]];
    
    _tabbarView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(49)
    .bottomSpaceToView(self.view,0);
    
    
    
    UIButton * btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 0, ScreenWidth/3, 49);
    btn1.tag=1;
    [btn1 setImage:[UIImage imageNamed:@"food"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"food_click"] forState:UIControlStateSelected];
    [_tabbarView addSubview:btn1];
    
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(ScreenWidth/3, -25, ScreenWidth/3, 49+20);//101  135
    [btn2 setImage:[UIImage imageNamed:@"index_logo-1"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [_tabbarView addSubview:btn2];
    
    UIButton * btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(ScreenWidth/1.5, 0,ScreenWidth/3, 49);
    [btn3 addTarget:self action:@selector(btn3:) forControlEvents:UIControlEventTouchUpInside];
     btn3.tag=3;
    [btn3 setImage:[UIImage imageNamed:@"mine"] forState:UIControlStateNormal];
     [btn3 setImage:[UIImage imageNamed:@"mine_click"] forState:UIControlStateSelected];
    [_tabbarView addSubview:btn3];
    
    
    
}
//吃饭界面
#pragma mark --吃饭界面
-(void)btn1:(UIButton*)btn1{
   
    OrderViewController * vc =[[OrderViewController alloc]init];
    BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    WINDOW.rootViewController=nav;
     btn1.selected=!btn1.selected;
}
//主界面
#pragma mark --主界面
-(void)btn2:(UIButton*)btn2{
    btn2.selected=!btn2.selected;
    HomeViewController * vc =[[HomeViewController alloc]init];
    BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    WINDOW.rootViewController=nav;
}
//我的界面
#pragma mark --我的界面
-(void)btn3:(UIButton*)btn3{
//    MyViewController
    btn3.selected=!btn3.selected;
    MyViewController * vc =[[MyViewController alloc]init];
    BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    WINDOW.rootViewController=nav;
    
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

@end
