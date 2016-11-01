//
//  LoginViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForGetViewController.h"
#import "LogineModel.h"
@interface LoginViewController ()
{
    UITextField * phoneNumberText;//手机号
    UITextField * pswNumberText;//密码
}
@property(nonatomic,retain)UIImageView * bgView;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    phoneNumberText.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"账号"];
    pswNumberText.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"密码"];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"账号"]==nil) {
        jiZhu.selected=NO;
    }else{
        jiZhu.selected=YES;
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      //self.view.backgroundColor=[UIColor blackColor];
    _bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight)];
    _bgView.userInteractionEnabled=YES;
    _bgView.image=[UIImage imageNamed:@"bg"];
    [self.view addSubview:_bgView];
    [self AddbackBtn];
}
-(void)AddbackBtn{
    //返回按钮
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
  //  backBtn.backgroundColor=[UIColor redColor];//setBackgroundImage
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:0];
    backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[backBtn]];
    
    backBtn.sd_layout
    .leftSpaceToView(_bgView,15)
    .topSpaceToView(_bgView,15)
    .widthIs(70)
    .heightIs(50);
   //logo图标
    UIImageView * logoImage =[[UIImageView  alloc]init];
    logoImage.image=[UIImage imageNamed:@"logo"];
    [_bgView sd_addSubviews:@[logoImage]];
    logoImage.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(_bgView,50*ScreenHeight/667)
    .widthIs(159/2)
    .heightIs(229/2);
    //请输入手机号
    UIView * numberView =[[UIView alloc]init];
    numberView.backgroundColor=[UIColor whiteColor];
    numberView.layer.cornerRadius=5;
    numberView.clipsToBounds=YES;
    [_bgView sd_addSubviews:@[numberView]];
    numberView.sd_layout
    .leftSpaceToView(_bgView,15)
    .rightSpaceToView(_bgView,15)
    .topSpaceToView(logoImage,30*ScreenHeight/667)
    .heightIs(40);
    UIImageView * peImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"admin"]];
    [numberView sd_addSubviews:@[peImage]];
    peImage.sd_layout
    .centerYEqualToView(numberView)
    .leftSpaceToView(numberView,10)
    .widthIs(12)
    .heightIs(29/2);
    
    phoneNumberText =[[UITextField alloc]init];
    phoneNumberText.keyboardType=UIKeyboardTypeNumberPad;
    phoneNumberText.placeholder=@"请输入手机号";
    phoneNumberText.font=[UIFont systemFontOfSize:15];
    [numberView sd_addSubviews:@[phoneNumberText]];
    phoneNumberText.sd_layout
    .centerYEqualToView(numberView)
    .leftSpaceToView(peImage,15)
    .rightSpaceToView(numberView,20)
    .heightIs(30);

   //请输入密码
    UIView * pswView =[[UIView alloc]init];
    pswView.backgroundColor=[UIColor whiteColor];
    pswView.layer.cornerRadius=5;
    pswView.clipsToBounds=YES;
    [_bgView sd_addSubviews:@[pswView]];
    pswView.sd_layout
    .leftSpaceToView(_bgView,15)
    .rightSpaceToView(_bgView,15)
    .topSpaceToView(numberView,10)
    .heightIs(40);
    UIImageView * pswImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    [pswView sd_addSubviews:@[pswImage]];
    pswImage.sd_layout
    .centerYEqualToView(pswView)
    .leftSpaceToView(pswView,10)
    .widthIs(25/2)
    .heightIs(31/2);
    
    pswNumberText =[[UITextField alloc]init];
    pswNumberText.keyboardType=UIKeyboardTypeNumberPad;
    pswNumberText.placeholder=@"请输入密码";
     pswNumberText.font=[UIFont systemFontOfSize:15];
    [pswView sd_addSubviews:@[pswNumberText]];
    pswNumberText.sd_layout
    .centerYEqualToView(pswView)
    .leftSpaceToView(pswImage,15)
    .rightSpaceToView(pswView,20)
    .heightIs(30);
 //登录按钮
    UIButton * loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor=[UIColor redColor];
   // [loginButton setBackgroundImage:[UIImage imageNamed:@"login"] forState:0];
   
    loginButton.backgroundColor=[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136/255.0 alpha:1];
    [loginButton setTitle:@"登录" forState:0];
    [loginButton setTitleColor:[UIColor blackColor] forState:0];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
     loginButton.titleLabel.font=[UIFont systemFontOfSize:15];
   loginButton.sd_cornerRadius=@(5);
    [_bgView sd_addSubviews:@[loginButton]];
    loginButton.sd_layout
    .leftEqualToView(numberView)
    .rightEqualToView(numberView)
    .heightIs(40)
    .topSpaceToView(pswView,30*ScreenHeight/667);
 //记住密码
    jiZhu =[UIButton buttonWithType:UIButtonTypeCustom];
    [jiZhu setBackgroundImage:[UIImage imageNamed:@"password-kuang"] forState:0];
     [jiZhu setBackgroundImage:[UIImage imageNamed:@"password-kuang-click"] forState:UIControlStateSelected];
    [jiZhu addTarget:self action:@selector(jizhuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[jiZhu]];
    jiZhu.sd_layout
    .leftEqualToView(loginButton)
    .topSpaceToView(loginButton,10)
    .widthIs(12)
    .heightIs(12);
    UILabel * jizhuLabel =[[UILabel alloc]init];
    jizhuLabel.text=@"记住密码";
    jizhuLabel.textColor=[UIColor blackColor];//[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136/255.0 alpha:1];
    jizhuLabel.font=[UIFont systemFontOfSize:12];
    [_bgView sd_addSubviews:@[jizhuLabel]];
    jizhuLabel.sd_layout
    .leftSpaceToView(jiZhu,5)
    .topEqualToView(jiZhu)
    .heightIs(11);
    [jizhuLabel setSingleLineAutoResizeWithMaxWidth:120];
   //忘记密码
    UIButton * forgetPsw=[UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPsw setTitle:@"忘记密码" forState:0];
    [forgetPsw setTitleColor:[UIColor blackColor] forState:0];
    forgetPsw.titleLabel.font=[UIFont systemFontOfSize:12];
    [forgetPsw addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[forgetPsw]];
    forgetPsw.sd_layout
    .rightEqualToView(pswView)
    .heightIs(11)
    .topEqualToView(jizhuLabel)
    .widthIs(70);
  //温馨提示
    UILabel * tishi =[UILabel new];
    tishi.textColor=[UIColor blackColor];//[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136/255.0 alpha:1];
    tishi.text=@"温馨提示:新用户需要先注册";
    tishi.font=[UIFont systemFontOfSize:12];
    [_bgView sd_addSubviews:@[tishi]];
    tishi.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(loginButton,30)
    .heightIs(11);
    [tishi setSingleLineAutoResizeWithMaxWidth:200];
   //注册按钮
    UIButton * registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"zhuce"] forState:0];
    [registerBtn addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[registerBtn]];
    registerBtn.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(tishi,20)
    .widthIs(150/2)
    .heightIs(53/2);
    
    
}

#pragma mark --注册
-(void)zhuce{
    RegisterViewController * vc =[[RegisterViewController alloc]init];
//    vc.userNamePswBlock=^(NSString*user,NSString*psw){
//        phoneNumberText.text=user;
//        pswNumberText.text=psw;
//    };
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
#pragma mark -- 忘记密码
-(void)forgetBtn{
    ForGetViewController * vc =[ForGetViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark --记住密码
-(void)jizhuBtn:(UIButton*)btn
{
    btn.selected=!btn.selected;
//    phoneNumberText.text
//    pswNumberText.text
    if (btn.selected==YES) {
        
//        if ( [phoneNumberText.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"账号"]] && [pswNumberText.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"密码"]]) {
//          
//        }else{
//            NSLog(@"账号或密码有误");
//        }
        
        [Engine LoginUserName:phoneNumberText.text PassWord:pswNumberText.text success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                NSLog(@"记住了");
                [[NSUserDefaults standardUserDefaults]setObject: phoneNumberText.text forKey:@"账号"];
                [[NSUserDefaults standardUserDefaults]setObject: pswNumberText.text forKey:@"密码"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
           

        } error:^(NSError *error) {
            
        }];
        
    }else{
        NSLog(@"没记住");
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"账号"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"密码"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    
}




#pragma mark-- 登录按钮
-(void)login:(UIButton*)loginBtn{
    NSLog(@"点击了登录");
    /*
     phoneNumberText
     pswNumberText
     */
    [LCProgressHUD showLoading:@"正在登录"];
    [Engine LoginUserName:phoneNumberText.text PassWord:pswNumberText.text success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD showSuccess:[dic objectForKey:@"msg"]];
            //登录成功
            [[NSUserDefaults standardUserDefaults]setObject:phoneNumberText.text  forKey:@"username"];
           
             [self dismissViewControllerAnimated:YES completion:nil];
            
            NSDictionary * content =[dic objectForKey:@"content"];
            if ([content objectForKey:@"baseInfo"]!=[NSNull null]) {
                 //baseInfoDic是空的，就只存regist_id
                 NSDictionary * baseInfoDic =[content objectForKey:@"baseInfo"];
                [XYString savePlist:baseInfoDic name:@"base"];
               // NSLog(@"看情况%@",baseInfoDic);
                NSString * zhuceID=[NSString stringWithFormat:@"%@",[baseInfoDic objectForKey:@"regist_id"]];
                [[NSUserDefaults standardUserDefaults]setObject:zhuceID  forKey:@"zhuceid"];
            }
            NSDictionary * registDic =[content objectForKey:@"registInfo"];
              //NSLog(@"看情况sssssa啊%@",registDic);
              [XYString savePlist:registDic name:@"regist"];
            NSString * zhuceID=[NSString stringWithFormat:@"%@",[registDic objectForKey:@"regist_id"]];
            [[NSUserDefaults standardUserDefaults]setObject:zhuceID  forKey:@"zhuceid"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }else{
            //登录失败
          //  [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:2 Enabled:YES];
            [LCProgressHUD showFailure:[dic objectForKey:@"msg"]];
        }
        
        

    } error:^(NSError *error) {
        
    }];

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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
