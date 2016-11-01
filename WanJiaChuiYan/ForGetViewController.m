//
//  ForGetViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ForGetViewController.h"

@interface ForGetViewController ()
{
    UITextField * phoneNumberText;
    UITextField * pswNumberText;
    UITextField * pswText3;
}
@property(nonatomic,retain)UIImageView * bgView;


@end

@implementation ForGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight)];
    _bgView.userInteractionEnabled=YES;
    _bgView.image=[UIImage imageNamed:@"bg"];
    [self.view addSubview:_bgView];
    [self CreatTuBiao];
}
-(void)CreatTuBiao{
    //返回按钮
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forState:0];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[backBtn]];
    backBtn.sd_layout
    .leftSpaceToView(_bgView,15)
    .topSpaceToView(_bgView,15)
    .widthIs(20/2)
    .heightIs(34/2);
    
    
    
    //tiitleLabel
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"忘记密码";
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .centerXEqualToView(_bgView)
    .heightIs(20)
    .topSpaceToView(_bgView,15);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:100];
    //view1
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    view1.sd_cornerRadius=@(5);
    [_bgView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(_bgView,15)
    .rightSpaceToView(_bgView,15)
    .topSpaceToView(titleLabel,30*ScreenHeight/667)
    .heightIs(45);
    UIImageView * renImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"admin"]];
    [view1 sd_addSubviews:@[renImage]];
    renImage.sd_layout
    .centerYEqualToView(view1)
    .leftSpaceToView(view1,10)
    .widthIs(12)
    .heightIs(29/2);
    
    phoneNumberText=[UITextField new];
    phoneNumberText.placeholder=@"请输入手机号";
    phoneNumberText.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[phoneNumberText]];
    phoneNumberText.sd_layout
    .centerYEqualToView(view1)
    .leftSpaceToView(renImage,15)
    .rightSpaceToView(view1,20)
    .heightIs(35);
    
    
    
    //view2(先创建Button)
    UIButton * yanZhengMaBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [yanZhengMaBtn addTarget:self action:@selector(yanzhengMa:) forControlEvents:UIControlEventTouchUpInside];
   // [yanZhengMaBtn setBackgroundImage:[UIImage imageNamed:@"验证码1"] forState:0];
    [yanZhengMaBtn setTitle:@"获取验证码" forState:0];
    yanZhengMaBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [yanZhengMaBtn setTitleColor:[UIColor blackColor] forState:0];
    yanZhengMaBtn.backgroundColor=[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136/255.0 alpha:1];
    yanZhengMaBtn.sd_cornerRadius=@(5);
    [_bgView sd_addSubviews:@[yanZhengMaBtn]];
    yanZhengMaBtn.sd_layout
    .rightSpaceToView(_bgView,15)
    .topSpaceToView(view1,10)
    .widthIs(111)
    .heightIs(45);
    
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    view2.sd_cornerRadius=@(5);
    [_bgView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftEqualToView(view1)
    .rightSpaceToView(yanZhengMaBtn,5)
    .topSpaceToView(view1,10)
    .heightRatioToView(view1,1);
    
    
    UIImageView * yanImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pass"]];
    [view2 sd_addSubviews:@[yanImage]];
    yanImage.sd_layout
    .centerYEqualToView(view2)
    .leftSpaceToView(view2,10)
    .widthIs(26/2)
    .heightIs(32/2);
    
    pswNumberText=[UITextField new];
    pswNumberText.placeholder=@"请输入验证码";
     pswNumberText.font=[UIFont systemFontOfSize:15];
    [view2 sd_addSubviews:@[pswNumberText]];
    pswNumberText.sd_layout
    .centerYEqualToView(view2)
    .leftSpaceToView(yanImage,15)
    .rightSpaceToView(view2,20)
    .heightIs(35);
    
    
    
    //view3
    UIView * view3 =[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    view3.sd_cornerRadius=@(5);
    [_bgView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftEqualToView(view1)
    .rightEqualToView(view1)
    .topSpaceToView(view2,10)
    .heightRatioToView(view2,1);
    
    
    UIImageView * loginImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    [view3 sd_addSubviews:@[loginImage]];
    loginImage.sd_layout
    .centerYEqualToView(view3)
    .leftSpaceToView(view3,10)
    .widthIs(25/2)
    .heightIs(31/2);
    
    pswText3=[UITextField new];
    pswText3.placeholder=@"请输入6~20位登录密码";
    pswText3.font=[UIFont systemFontOfSize:15];
    [view3 sd_addSubviews:@[pswText3]];
    pswText3.sd_layout
    .centerYEqualToView(view3)
    .leftSpaceToView(loginImage,15)
    .rightSpaceToView(view3,20)
    .heightIs(35);
    
    //确认修改
    UIButton * registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // [registerBtn setBackgroundImage:[UIImage imageNamed:@"确认修改"] forState:0];
    [registerBtn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor=[UIColor colorWithRed:129/255.0 green:228/255.0 blue:136/255.0 alpha:1];
    [registerBtn setTitle:@"确认修改" forState:0];
    [registerBtn setTitleColor:[UIColor blackColor] forState:0];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:15];

    
    
    [_bgView sd_addSubviews:@[registerBtn]];
    
    registerBtn.sd_layout
    .leftEqualToView(view3)
    .rightEqualToView(view3)
    .heightRatioToView(view3,1)
    .topSpaceToView(view3,30);

    
    
}
#pragma mark -- 验证码获取
-(void)yanzhengMa:(UIButton*)sender{
    NSLog(@"验证码获取");
    [LCProgressHUD showLoading:@"正在获取验证码..."];
    [Engine duanXinTime:phoneNumberText.text success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            
            //实现倒计时
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                    });
                }
                else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            
            
            
            
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark -- 确认修改
-(void)registerBtn{
    
//    UITextField * phoneNumberText;
//    UITextField * pswNumberText;
//    UITextField * pswText3;
    
    [Engine forgetMiMaAccount:phoneNumberText.text Password:pswNumberText.text YanZhengCode:pswText3.text success:^(NSDictionary *dic) {
        
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
