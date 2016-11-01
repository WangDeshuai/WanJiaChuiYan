//
//  HomeViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeViewController.h"
#import "JZPulsingView.h"
#import "JZTagTextView.h"
#import "JZTagView.h"
#import "KitchenViewController.h"
#import "XiaoZhanViewController.h"
#import "PromotionCodeViewController.h"
#import "ToApplyForViewController.h"
#import "TheRulesViewController.h"
#import "CityViewController.h"
#import "MyXiaoZhanViewController.h"
#import "WanJiaChuFangViewController.h"
@interface HomeViewController ()
{
    UIImageView * imageview1;
    UIImageView * imageview2;
    UIImageView * imageview3;
    JZTagView * animation;
    JZTagView * animation2;
    JZTagView * animation3;
    JZTagView * animation4;
    JZTagView * animation5;
    JZTagView * animation6;
    JZTagView * animation7;
    UIButton * btnDian1;
    UIButton * btnDian2;
    UIButton * btnDian3;
    UIButton * btnDian4;
    UIButton * btnDian5;
    UIButton * btnDian6;
    UIButton * btnDian7;
    UIButton *fabu;
}
@property(nonatomic,strong)CALayer *myLayer;
@property(nonatomic,copy)NSString * cityText;
@property(nonatomic,retain)UIScrollView * bgScrollerView;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
      NSMutableDictionary *dic= [XYString duquPlistWenJianPlistName:@"cityDingWei"];
    if (dic==nil) {
        //没有记录说明是第一次进来d的
        CityViewController * vc =[CityViewController new];
        vc.cityNameBlock=^(NSString * name){
            _cityText=name;
            //fabu=name;
            [fabu setTitle:name forState:0];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@">>>%@>>%@",[dic objectForKey:@"cityName"],[dic objectForKey:@"shengName"]);
        
        
        return;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];

    self.title=@"万家饮烟";
    
    [self rightBtn];
    [self initScrollerView];
    [self initView1];
    [self dianAnimation];
    [self dianAnimation2];
    [self dianAnimation3];
}








#pragma mark --左上角的保存
-(void)rightBtn
{
     NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    
    fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    if (_cityText==nil) {
        
        if (cityName==nil) {
             [fabu setTitle:@"定位" forState:0];
        }else{
             [fabu setTitle:[cityName objectForKey:@"cityName"] forState:0];
        }
        
        
        
    }else{
        [fabu setTitle:_cityText forState:0];
    }

    [fabu setImage:[UIImage imageNamed:@"address"] forState:0];
    fabu.titleLabel.font=[UIFont systemFontOfSize:16];
    [fabu setTitleColor:[UIColor blackColor] forState:0];
    [fabu addTarget:self action:@selector(dingwei) forControlEvents:UIControlEventTouchUpInside];
    
    [fabu setImageEdgeInsets:UIEdgeInsetsMake(0,-20, 0, 0)];
    [fabu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    fabu.frame=CGRectMake(0,0, 100, 57/2);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    
    self.navigationItem.leftBarButtonItem=rightBtn;

}
-(void)dingwei{
    CityViewController * vc =[CityViewController new];
    vc.cityNameBlock=^(NSString * name){
        _cityText=name;
         [fabu setTitle:name forState:0];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)initScrollerView{
    if (!_bgScrollerView) {
          _bgScrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49)];
    }
    _bgScrollerView.backgroundColor=[UIColor clearColor];
    _bgScrollerView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight-64-40);
    [self.view addSubview:_bgScrollerView];
     [self.view bringSubviewToFront:self.tabbarView];
}


#pragma mark --初始化3张大图片和2个小箭头
-(void)initView1{
    
   
    [imageview1 removeFromSuperview];
    [imageview2 removeFromSuperview];
    [imageview3 removeFromSuperview];
    [animation removeFromSuperview];
    [animation2 removeFromSuperview];
    [animation3 removeFromSuperview];
    [animation4 removeFromSuperview];
    [animation5 removeFromSuperview];
    [animation6 removeFromSuperview];
    [animation7 removeFromSuperview];
    [btnDian1 removeFromSuperview];
    [btnDian2 removeFromSuperview];
    [btnDian3 removeFromSuperview];
    [btnDian4 removeFromSuperview];
    [btnDian5 removeFromSuperview];
    [btnDian6 removeFromSuperview];
    [btnDian7 removeFromSuperview];
    
     UIView * viewTop =_bgScrollerView;
    
    imageview1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wanjiachufang"]];
    imageview1.userInteractionEnabled=YES;
    [_bgScrollerView sd_addSubviews:@[imageview1]];
    imageview1.sd_layout
    .topSpaceToView(viewTop,10)
    .leftSpaceToView(viewTop,10)
    .rightSpaceToView(viewTop,10)
    .heightIs((ScreenWidth-20)*300/702);
    //向下的箭头1
    UIButton * btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"jiantou1"] forState:0];
    [_bgScrollerView sd_addSubviews:@[btn1]];
    btn1.sd_layout
    .topSpaceToView(imageview1,0)
    .centerXEqualToView(viewTop)
    .widthIs(287/2)
    .heightIs(70/2);

    imageview2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chuiyanxiaozhan"]];
    imageview2.userInteractionEnabled=YES;
    [_bgScrollerView sd_addSubviews:@[imageview2]];
    imageview2.sd_layout
    .topSpaceToView(btn1,0)
    .leftSpaceToView(viewTop,10)
    .rightSpaceToView(viewTop,10)
    .heightIs((ScreenWidth-20)*300/702);
     //向下的箭头2
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"jiantou2"] forState:0];
    [_bgScrollerView sd_addSubviews:@[btn2]];
    btn2.sd_layout
    .topSpaceToView(imageview2,0)
    .centerXEqualToView(viewTop)
    .widthIs(287/2)
    .heightIs(70/2);
    
    
    imageview3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gerenzhongxin"]];
    imageview3.userInteractionEnabled=YES;
    [_bgScrollerView sd_addSubviews:@[imageview3]];
    imageview3.sd_layout
    .topSpaceToView(btn2,0)
    .leftSpaceToView(viewTop,10)
    .rightSpaceToView(viewTop,10)
    .heightIs((ScreenWidth-20)*300/702);


    
    
}




#pragma mark --第一张图片的闪动小动画
-(void)dianAnimation{
    
    animation = [[JZTagView alloc]init];
    animation.backgroundColor = [UIColor clearColor];
    [imageview1 sd_addSubviews:@[animation]];

    animation.sd_layout
    .centerXEqualToView(imageview1)
    .centerYEqualToView(imageview1)
    .widthIs(26)
    .heightIs(26);
    
    btnDian1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian1 setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
    [btnDian1 addTarget:self action:@selector(chufang) forControlEvents:UIControlEventTouchUpInside];
    [btnDian1 setTitle:@"申请厨房" forState:0];
    btnDian1.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnDian1 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview1 sd_addSubviews:@[btnDian1]];
    btnDian1.sd_layout
    .leftSpaceToView(animation,2)
    .topSpaceToView(imageview1,55)
    .widthIs(128/2)
    .heightIs(42/2);
    
    
    
    JZTagView* chufang = [[JZTagView alloc]init];
    chufang.backgroundColor = [UIColor clearColor];
    [imageview1 sd_addSubviews:@[chufang]];
    
    chufang.sd_layout
    .topSpaceToView(imageview1,35)
    .leftSpaceToView(imageview1,50)
    .widthIs(26)
    .heightIs(26);

    
   UIButton *   guize =[UIButton buttonWithType:UIButtonTypeCustom];
    [guize setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
    guize.tag=1;
    [guize addTarget:self action:@selector(guiZe:) forControlEvents:UIControlEventTouchUpInside];
    [guize setTitle:@"我的午餐" forState:0];
    guize.titleLabel.font=[UIFont systemFontOfSize:13];
    [guize setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview1 sd_addSubviews:@[guize]];
    guize.sd_layout
    .leftSpaceToView(chufang,2)
    .centerYEqualToView(chufang)
    .widthIs(128/2)
    .heightIs(42/2);
    
    
    
    
}
#pragma mark --第二张图片的闪动小动画
-(void)dianAnimation2{
  //这是第一个点
    animation2 = [[JZTagView alloc]init];
    animation2.backgroundColor = [UIColor clearColor];
    [imageview2 sd_addSubviews:@[animation2]];
    
    animation2.sd_layout
    .leftSpaceToView(imageview2,75)
    .topSpaceToView(imageview2,55)
    .widthIs(26)
    .heightIs(26);
    
    btnDian2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian2 setBackgroundImage:[UIImage imageNamed:@"arrow-bg"] forState:0];
  [btnDian2 addTarget:self action:@selector(xiaozhan) forControlEvents:UIControlEventTouchUpInside];
    [btnDian2 setTitle:@"申请小站" forState:0];
    btnDian2.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnDian2 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview2 sd_addSubviews:@[btnDian2]];
    btnDian2.sd_layout
    .leftSpaceToView(imageview2,5)
    .topSpaceToView(imageview2,50)
    .widthIs(128/2)
    .heightIs(42/2);
  //这是第二个点
    animation3 = [[JZTagView alloc]init];//WithFrame:CGRectMake(100, 100, 100, 26)];
   // animation3.hidden=YES;
    animation3.backgroundColor = [UIColor clearColor];
    [imageview2 sd_addSubviews:@[animation3]];
    
    animation3.sd_layout
    .centerXEqualToView(imageview2)
    .topSpaceToView(imageview2,25)
    .widthIs(26)
    .heightIs(26);
    
    btnDian3 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian3 setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
    btnDian3.tag=2;
    [btnDian3 addTarget:self action:@selector(guiZe:) forControlEvents:UIControlEventTouchUpInside];
    [btnDian3 setTitle:@"申请规则" forState:0];
    btnDian3.titleLabel.font=[UIFont systemFontOfSize:13];
  //  [btnDian3 setTitleColor:[UIColor colorWithRed:73/255.0 green:210/255.0 blue:120/255.0 alpha:1] forState:0];
    
    [btnDian3 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview2 sd_addSubviews:@[btnDian3]];
    btnDian3.sd_layout
    .leftSpaceToView(animation3,5)
    .topSpaceToView(imageview2,20)
    .widthIs(128/2)
    .heightIs(42/2);
//这是第三个点
    animation4 = [[JZTagView alloc]init];//WithFrame:CGRectMake(100, 100, 100, 26)];
   // animation4.hidden=YES;
    animation4.backgroundColor = [UIColor clearColor];
    [imageview2 sd_addSubviews:@[animation4]];
    
    animation4.sd_layout
    .rightSpaceToView(imageview2,64+35)
    .topSpaceToView(imageview2,65)
    .widthIs(26)
    .heightIs(26);
    
    btnDian4 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian4 setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
   // btnDian4.hidden=YES;
    [btnDian4 setTitle:@"申请中" forState:0];
    [btnDian4 addTarget:self action:@selector(shenqing:) forControlEvents:UIControlEventTouchUpInside];
    btnDian4.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnDian4 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview2 sd_addSubviews:@[btnDian4]];
    btnDian4.sd_layout
    .leftSpaceToView(animation4,5)
    .topSpaceToView(imageview2,55)
    .widthIs(128/2)
    .heightIs(42/2);

    
    
    
    
}
#pragma mark --第三张图片的闪动小动画
-(void)dianAnimation3{
    
    //这是第一个点
    animation5 = [[JZTagView alloc]init];//WithFrame:CGRectMake(100, 100, 100, 26)];
   // animation5.hidden=YES;
    animation5.backgroundColor = [UIColor clearColor];
    [imageview3 sd_addSubviews:@[animation5]];
    
    animation5.sd_layout
    .leftSpaceToView(imageview3,75)
    .topSpaceToView(imageview3,55)
    .widthIs(26)
    .heightIs(26);
    
    btnDian5 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian5 setBackgroundImage:[UIImage imageNamed:@"arrow-bg"] forState:0];
   // btnDian5.hidden=YES;
    [btnDian5 setTitle:@"打饭" forState:0];
    [btnDian5 addTarget:self action:@selector(dafan) forControlEvents:UIControlEventTouchUpInside];
    btnDian5.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnDian5 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview3 sd_addSubviews:@[btnDian5]];
    btnDian5.sd_layout
    .leftSpaceToView(imageview3,5)
    .topSpaceToView(imageview3,50)
    .widthIs(128/2)
    .heightIs(42/2);
    //这是第二个点
    animation6 = [[JZTagView alloc]init];//WithFrame:CGRectMake(100, 100, 100, 26)];
   // animation6.hidden=YES;
    animation6.backgroundColor = [UIColor clearColor];
    [imageview3 sd_addSubviews:@[animation6]];
    
    animation6.sd_layout
    .centerXEqualToView(imageview3)
    .topSpaceToView(imageview3,25)
    .widthIs(26)
    .heightIs(26);
    
    btnDian6 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian6 setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
   // btnDian6.hidden=YES;
    [btnDian6 addTarget:self action:@selector(tuiguangma:) forControlEvents:UIControlEventTouchUpInside];
    [btnDian6 setTitle:@"推广" forState:0];
    btnDian6.titleLabel.font=[UIFont systemFontOfSize:13];
    //[btnDian6 setTitleColor:[UIColor colorWithRed:73/255.0 green:210/255.0 blue:120/255.0 alpha:1] forState:0];
    [btnDian6 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview3 sd_addSubviews:@[btnDian6]];
    btnDian6.sd_layout
    .leftSpaceToView(animation6,5)
    .topSpaceToView(imageview3,20)
    .widthIs(128/2)
    .heightIs(42/2);
    //这是第三个点
    animation7 = [[JZTagView alloc]init];//WithFrame:CGRectMake(100, 100, 100, 26)];
   // animation7.hidden=YES;
    animation7.backgroundColor = [UIColor clearColor];
    [imageview3 sd_addSubviews:@[animation7]];
    
    animation7.sd_layout
    .rightSpaceToView(imageview3,64+35)
    .topSpaceToView(imageview3,65)
    .widthIs(26)
    .heightIs(26);
    
    btnDian7 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDian7 setBackgroundImage:[UIImage imageNamed:@"link_bg"] forState:0];
    btnDian7.tag=3;
    [btnDian7 addTarget:self action:@selector(guiZe:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnDian7 setTitle:@"介绍" forState:0];
    btnDian7.titleLabel.font=[UIFont systemFontOfSize:13];
    [btnDian7 setTitleColor:[UIColor colorWithRed:0/255.0 green:139/255.0 blue:9/255.0 alpha:1] forState:0];
    [imageview3 sd_addSubviews:@[btnDian7]];
    btnDian7.sd_layout
    .leftSpaceToView(animation7,5)
    .topSpaceToView(imageview3,55)
    .widthIs(128/2)
    .heightIs(42/2);
}
#pragma mark --打饭
-(void)dafan{
    OrderViewController * vc =[[OrderViewController alloc]init];
    BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    WINDOW.rootViewController=nav;
}



#pragma mark --申请厨房按钮
-(void)chufang{
    if(![ToolClass isLogin])
    {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    [Engine queryWanJiasuccess:^(NSDictionary *dic) {
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([content isEqualToString:@"2"]) {
            KitchenViewController * vc =[KitchenViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([content isEqualToString:@"1"]){
            NSString * type =[ToolClass userType];
            if ([type isEqualToString:@"1"]) {
               
            }else{
               // [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                WanJiaChuFangViewController * vc =[WanJiaChuFangViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }

            
        }
        else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
   
}
#pragma mark --申请小站
-(void)xiaozhan{
    
    if(![ToolClass isLogin])
    {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    [Engine quiteXiaoZhanShenStyesuccess:^(NSDictionary *dic) {
        NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        if ([content isEqualToString:@"2"]) {
            XiaoZhanViewController * vc =[XiaoZhanViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([content isEqualToString:@"1"]){
            
              NSString * type =[ToolClass userType];
            if ([type isEqualToString:@"1"]) {
               
            }else{
                MyXiaoZhanViewController * vc =[MyXiaoZhanViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                //[LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
           
            
        }
        else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
}
#pragma mark --我的推广码
-(void)tuiguangma:(UIButton*)btn
{
    if(![ToolClass isLogin])
    {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    PromotionCodeViewController * vc= [PromotionCodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --申请中
-(void)shenqing:(UIButton*)btn
{
    if(![ToolClass isLogin])
    {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    ToApplyForViewController * vc =[ToApplyForViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --申请规则
-(void)guiZe:(UIButton*)btn{
//
    TheRulesViewController * vc =[TheRulesViewController new];
    vc.number=btn.tag;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --介绍
-(void)jieshao{
    
//    TheRulesViewController * vc =[TheRulesViewController new];
//    vc.number=3;
//    [self.navigationController pushViewController:vc animated:YES];
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
