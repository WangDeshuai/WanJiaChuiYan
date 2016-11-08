//
//  TextFiledOneVC.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/11/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TextFiledOneVC.h"

@interface TextFiledOneVC ()
@property(nonatomic,strong)UITextField * textFiled;

@end

@implementation TextFiledOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"小站自编辑广告语";
    [self leftBtn];
    [self rightBtn];
    _textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 35)];
    _textFiled.placeholder=@"请输入广告语";
    // _textFiled.backgroundColor=[UIColor redColor];
    [self.view addSubview:_textFiled];
    UIView * lineView =[UIView new];
    lineView.frame=CGRectMake(5, 55, ScreenWidth-10, 1);
    lineView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:lineView];
    [self shuJuJieXiData];
    
    
}
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"提交" forState:0];
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    fabu.frame=CGRectMake(0,0, 104/2, 57/2);
    [fabu setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
//提交广告语
-(void)save{
    if (self.textFiled.text.length==0 || self.textFiled.text ==nil) {
        [LCProgressHUD showMessage:@"请输入广告语"];
    }else{
        [Engine gengXinGuangGao:self.textFiled.text success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } error:^(NSError *error) {
            
        }];
    }
}
//查询广告语
-(void)shuJuJieXiData{
    [Engine ChaKanXiaoZhanXuanChuansuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            if ([dic objectForKey:@"content"]==[NSNull null] ||[dic objectForKey:@"content"]==nil )
            {
                
            }else
            {
                self.textFiled.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            }
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
@end
