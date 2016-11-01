//
//  PayStyeDaFan.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PayStyeDaFan.h"
#import "PayStyeTableViewCell.h"
#import "Order.h"
#import "WeiXinModel.h"
#import "DataSigner.h"
#import "SettlementModel.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
@interface PayStyeDaFan ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * _lastBtn;
    NSInteger indexpathRow;
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    UILabel * labelText;
     NSString * liangP;
   
}
@property(nonatomic,retain)SettlementModel * model;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)NSMutableArray * leftArray;
@property(nonatomic,retain)NSMutableArray * nameArray;
@property(nonatomic,retain)NSMutableArray *btnArray;

@property(nonatomic,retain)NSMutableArray * liangpiaoyue;
@end

@implementation PayStyeDaFan
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"在线支付";
   // [self.navigationItem setTitle:@"在线支付"];
    // Do any additional setup after loading the view.
    _btnArray=[NSMutableArray new];
    _liangpiaoyue=[NSMutableArray new];
    [self getOrderMessage];//获取订单号
     [self liangPiaoYuE];//获取粮票
    [self leftBtn];
    [self time];
  
    [self CreatLabel];
   
   
}

#pragma mark --获取倒计时
-(void)time{
    [Engine timeHuoQusuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            [self  CreatTime:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
        }
        
    } error:^(NSError *error) {
        
    }];
}




-(void)CreatTime:(NSString *)time{
    //设置倒计时总时长
    secondsCountDown =[time intValue];//60秒倒计时
    //开始倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    //设置倒计时显示的时间
    NSString * timee=[NSString stringWithFormat:@"支付剩余时间%@秒\n倒计时时间内支付，否则支付成功也导致订单失败",[self timeFormatted:secondsCountDown]];
    labelText =[UILabel new];
    labelText.text=timee;//@"支付剩余时间:6分30秒";
    labelText.textAlignment=1;
    labelText.numberOfLines=0;
    labelText.frame=CGRectMake(0, 0, ScreenWidth, 50);
    labelText.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    labelText.font=[UIFont systemFontOfSize:15];
    labelText.textColor=[UIColor redColor];
    //[UIColor colorWithRed:80/255.0 green:231/255.0 blue:132/255.0 alpha:1];
    labelText.alpha=.7;
    [self.view addSubview:labelText];
}
-(void)timeFireMethod{
    
    //倒计时-1
    secondsCountDown--;
    NSString * timee=[NSString stringWithFormat:@"支付剩余时间%@秒\n倒计时时间内支付，否则支付成功也导致订单失败",[self timeFormatted:secondsCountDown]];
    //修改倒计时标签现实内容
    labelText.text=timee;
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [labelText removeFromSuperview];
        [self deleateGouWuChe];
        [self.navigationController popToRootViewControllerAnimated:YES];
        //[LCProgressHUD showMessage:@"您的订单已失效,请重新选则菜品"];
        
    }
    
}

//转换成时分秒
- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
  //  int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}
#pragma mark --初始化数组
-(void)CreatArray{
   
    NSString * str;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"]==nil) {
        str=@"0";
    }else{
        str=[[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"];
    }
    
    NSArray * arr1 =@[@"支付宝支付",@"微信支付"];
    NSArray * arr2=@[[NSString stringWithFormat:@"可用粮票余额%@元",str]];
    NSArray * image1 =@[@"zhifubao",@"微信"];
    NSArray * image2=@[@"money"];
    _leftArray=[[NSMutableArray alloc]initWithObjects:image1,image2, nil];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,nil];
//    if (_number==1) {
//        NSArray * arr1 =@[@"支付宝支付",@"微信支付"];
//        NSArray * arr2=@[[NSString stringWithFormat:@"可用粮票余额%@元",[[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"]]];
//        NSArray * image1 =@[@"zhifubao",@"微信"];
//        NSArray * image2=@[@"money"];
//        _leftArray=[[NSMutableArray alloc]initWithObjects:image1,image2, nil];
//        _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,nil];
//    }else{
//        NSArray * arr1 =@[@"支付宝支付",@"微信支付"];
//        NSArray * arr2=@[[NSString stringWithFormat:@"可用粮票余额%@元",[[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"]]];
//        NSArray * image1 =@[@"zhifubao",@"微信"];
//        NSArray * image2=@[@"money"];
//        _leftArray=[[NSMutableArray alloc]initWithObjects:image1,image2, nil];
//        _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,nil];
//    }
//    
   
    
    
}
#pragma mark --初始化Label
-(void)CreatLabel
{
    _nameLabel=[UILabel new];
    _nameLabel.text=@"请选择收款方式";
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.alpha=.8;
    [self.view sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(self.view,60)
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
    .topSpaceToView(_nameLabel,10)
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr =_nameArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    PayStyeTableViewCell * cell =[PayStyeTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    
    NSArray * array =_leftArray[indexPath.section];
    
    [cell.leftImage setImage:[UIImage imageNamed:array[indexPath.row]] forState:0];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    
    if (indexPath.section==0) {
        cell.rightImage.tag=indexPath.row+100;
    }
     [cell.rightImage addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
//    if (_number==1) {
//        if (indexPath.section==0) {
//            cell.rightImage.tag=indexPath.row;
//            if (cell.rightImage.selected==YES) {
//                //cell.rightImage.selected=YES;
//                _lastBtn=cell.rightImage;
//            }
//            [cell.rightImage addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
//        }else{
//            [cell.rightImage addTarget:self action:@selector(rightBtn2:) forControlEvents:UIControlEventTouchUpInside];
//           // cell.rightImage.selected=!cell.rightImage.selected;
//        }
//
//    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
#pragma mark -- 区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else{
        return 10;
    }
}
#pragma mark -- 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
#pragma mark --右边按钮
-(void)rightBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
    if (btn.tag>= 100) {
        if (_lastBtn == btn && btn.selected == YES) {
            _lastBtn.selected =YES;
        }
        else
        {
            _lastBtn.selected =NO;
        }
        _lastBtn = btn;
    }
    
   
    
    
}



//获取所有可见cell
-(NSArray*)cellsForTableView:(UITableView*)tableView{
    NSInteger sections =tableView.numberOfSections;
    NSMutableArray * cells =[[NSMutableArray alloc]init];
    for (int  section=0; section<sections; section++) {
        NSInteger rows =[tableView numberOfRowsInSection:section];
        for (int row = 0; row<rows; row++) {
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:row inSection:section];
            [cells addObject:[tableView cellForRowAtIndexPath:indexPath]];
        }
    }
    return cells;
}
#pragma mark --获取粮票
-(void)liangPiaoYuE{
    [Engine quiteLiangPiaosuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSString * content =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            liangP=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            [_liangpiaoyue addObject:content];
            
            [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"粮票"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        [self CreatArray];
        [self CreatTableView];
        NSLog(@"看看%lu",(unsigned long)_liangpiaoyue.count);
       // [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}



#pragma mark --确认按钮
-(void)sure{
    NSArray * cells =[self cellsForTableView:_tableView];
    PayStyeTableViewCell * cell0 =cells[0];
    PayStyeTableViewCell * cell1 =cells[1];
    PayStyeTableViewCell * cell2 =cells[2];
   
    //获取订单号
    
    NSString * dingDan;// =_model.bianHao;
    if (_number==1) {
        dingDan=_dingDan;
    }else{
        dingDan=_model.bianHao;
    }
    
    NSLog(@"我是订单号%@",dingDan);
    
    //获取粮票余额
   
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"]==nil) {
        liangP=@"0";
    }else{
        liangP=[[NSUserDefaults standardUserDefaults]objectForKey:@"粮票"];
    }
    
    //获取价格
    float jiage;
    if (_number==1) {
        jiage =[_jiage floatValue];
    }else{
        jiage=5.00;
    }
    
   
    
    float lp =[liangP floatValue];
    NSString * cha;
    if (jiage>lp) {
        cha= [NSString stringWithFormat:@"%.2f",jiage-lp]; ;
    }else{
        cha=[NSString stringWithFormat:@"%.2f",jiage];
    }
    NSLog(@"输出价格%@",cha);
    
    if (cell0.rightImage.selected==YES && cell1.rightImage.selected==NO && cell2.rightImage.selected==NO) {
       // NSLog(@"支付宝支付");
        [Engine queRenZhiFupayDingDanHao:dingDan FanCaiMa:[NSString stringWithFormat:@"%lu",(long)_number] PayStye:@"1" LiangPiao:nil ZongJinPrice:cha success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //获取到后台价格
                NSString * htPrice=[dic objectForKey:@"content"];
                NSLog(@"正确的价格应该是%@",htPrice);
                [self zhifujiemianbiaotii:@"这是标题" jiage:htPrice miaoshu:@"这是描述" DinDan:dingDan];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }

            
        } error:^(NSError *error) {
            
        }];
        
        
    }else if(cell0.rightImage.selected==NO && cell1.rightImage.selected==YES && cell2.rightImage.selected==NO){
      //  NSLog(@"微信支付");
      
        [Engine queRenZhiFupayDingDanHao:dingDan FanCaiMa:[NSString stringWithFormat:@"%lu",(long)_number] PayStye:@"2" LiangPiao:nil ZongJinPrice:cha success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //获取到后台的价格
                float chaa =[[dic objectForKey:@"content"] floatValue];
                //转化为分
                NSString * fen =[NSString stringWithFormat:@"%.0f",chaa*100];
                NSLog(@"微信正确的价格是%@",fen);
               [self WXpayStayePrice:fen MiaoShu:@"这是描述" DingDan:dingDan];
                
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
            
        } error:^(NSError *error) {
            
        }];
    }else if(cell0.rightImage.selected==NO && cell1.rightImage.selected==NO && cell2.rightImage.selected==YES){
        NSLog(@"粮票支付");
        [Engine queRenZhiFupayDingDanHao:dingDan FanCaiMa:[NSString stringWithFormat:@"%lu",(long)_number]PayStye:@"3" LiangPiao:[NSString stringWithFormat:@"%f",jiage] ZongJinPrice:nil success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
          //   [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            if ([code isEqualToString:@"1"]) {
                if (_number==2) {
                    UIAlertController * actionview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"购买成功\n请前往您选择的取餐点领取" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action =[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [self.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [actionview addAction:action];
                    [self presentViewController:actionview animated:YES completion:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [self deleateGouWuChe];
                   
                }
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
               
            }
        } error:^(NSError *error) {
            
        }];
    }else if(cell0.rightImage.selected==YES && cell1.rightImage.selected==NO && cell2.rightImage.selected==YES){
     //   NSLog(@"支付宝15+粮票5");
        [Engine queRenZhiFupayDingDanHao:dingDan FanCaiMa:[NSString stringWithFormat:@"%lu",(long)_number] PayStye:@"4" LiangPiao:liangP ZongJinPrice:cha success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                
                //获取到后台价格
                 NSString * htPrice=[dic objectForKey:@"content"];
                NSLog(@"支付宝和粮票正确的价格%@",htPrice);
                [self zhifujiemianbiaotii:@"这是标题" jiage:htPrice miaoshu:@"这是描述" DinDan:dingDan];
                
                
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
            
            
        } error:^(NSError *error) {
            
        }];
        
        
    }else if(cell0.rightImage.selected==NO && cell1.rightImage.selected==YES && cell2.rightImage.selected==YES){
      //  NSLog(@"微信+粮票");
        
        [Engine queRenZhiFupayDingDanHao:dingDan FanCaiMa:[NSString stringWithFormat:@"%lu",(long)_number]PayStye:@"5" LiangPiao:liangP ZongJinPrice:cha success:^(NSDictionary *dic) {
            
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //获取到后台的价格
                float chaa =[[dic objectForKey:@"content"] floatValue];
                //转化为分
                NSString * fen =[NSString stringWithFormat:@"%.0f",chaa*100];
                  NSLog(@"微信+粮票正确的价格%@",fen);
                [self WXpayStayePrice:fen MiaoShu:@"这是描述" DingDan:dingDan];
                
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
            
            
        } error:^(NSError *error) {
            
        }];
    }else{
       // NSLog(@"请选择正确的支付方式11");
        [LCProgressHUD showMessage:@"请选择正确的支付方式"];
    }
    

    
    
    
    
////    if (indexpathRow==0) {
////        //支付宝
////        [self zhifujiemian:@"fafagsgsa" biaotii:@"这是标题" jiage:@"0.01" miaoshu:@"雷神火麒麟天龙"];
////        
////    }else{
////        //微信
////    }
//    
//
    
}

#pragma mark --支付宝大部队
-(void)zhifujiemianbiaotii:(NSString*)bt jiage:(NSString*)jiage miaoshu:(NSString*)mshu DinDan:(NSString * )dingdan
{
    NSString *partner =@"2088421728335148";
    NSString *seller = @"514622205@qq.com";// //收款账户，手机号或者邮箱wanjiayanjiu@yeah.net
    NSString*privateKey= @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAPKkAp77qxbuOZrxKm0E0oRlhv0/4NnaqNlr9/kwb+bRs76RbrFKPADmQokDcDFAO1Vj2x5ASSKLX8KkEbuVM2QKXYEwDPjIj1b1wMCS4lIIDzCXa6aY2if4pcrSmI9YLKoe1wZuuKibd5W25dESX049IikGvalNmW3utnoSrXnPAgMBAAECgYB8BHpWejm7ca291RAjQri69Q2m+XRaxVlSL85B7pDzgDGH8NuMAG5k40wUrc41TihFf9FqR99ZqbUbTjLGFv95XsyOh8da+ZNsZVWfMIfu9jBD5r/vcPY/34t3X0qhfzw78Y6MSNN+hgCVfkjf3i3MuC8KpZ/BtAHUD1C6B9TUOQJBAPvvj4/FOYdVgegmamUwNEEE2JIAfQmlMmjdcY8u7GbaytWe4+jFXHUaQqgnnYXeoT+RWXuE5FBqbyDf5Rcqj4sCQQD2jhAKY6bSg5Mfk+2g1hvOCBLFx+zdF/zkcYAO8nA8YO0wdDLCuZwAlkPGDXXW2ecFGlx9KgZPoGTUeyzhSodNAkB1kQKGjfvdqsp3gk3OMKOB3/gMkgvHj36prwUKU1RgXyOecopampcd0oZeoDYDPbQzzOlcGdTNrg1z4ueuWt8nAkBSL6zdKba0ObPTNOZjVLvUBBDt6OTmFlbwd30uflY3aj/mhPVev6xm7bAN1vLO+bfulYj7GAUeieLSiXS+bK+JAkAYA2aagzCkhfNmWZmFAMIhadS5/+pGBZXOICaF8MIxeNrWqxqI6V4IYS5315lmALYoGByIhDkEm3I2l7APfWIP";// 私钥
    
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = dingdan;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = bt; //商品标题
    order.body = mshu; //商品描述
    order.totalFee = jiage;//@"0.01"; //商品价格
    order.notifyURL = @"http://119.29.83.154:8080/OrderSystem/payment/app_alipayCallBack.action"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    order.itBPay=@"2m";
    NSString *appScheme = @"wanjia";//标识符得在info里面设置
    
    //将商品信息拼接成字符串   该方法支付宝已经封好
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //调用签名
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        //上面提到好的后台，会把订单字符串直接传给我们，而我们要做的其实也就只剩下这一步了
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"支付结果>>>%@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //9000为支付成功
                UIAlertController * alercon =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"充值成功，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * que =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alercon addAction:que];
                [self presentViewController:alercon animated:YES completion:nil];
            }
        }];
    }
    
    
    
}

#pragma mark --微信大部队
-(void)WXpayStayePrice:(NSString*)price MiaoShu:(NSString*)ms DingDan:(NSString*)dd{
    
    [Engine WXyuZhiFuDingDanHao:dd Price:price MiaoShu:ms SheBeiIP:nil success:^(NSDictionary *dic) {
        
        
        NSString * s =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([s isEqualToString:@"1"])
        {
            NSDictionary * dicc= [dic objectForKey:@"content"];
            WeiXinModel * md =[[ WeiXinModel alloc]initWithZhiFuDic:dicc];
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = md.partnerid;
            request.prepayId=  md.prepayid;
            request.package = md.package;
            request.nonceStr=  md.noncestr;
            request.timeStamp= md.timestamp.intValue;
            request.sign= md.sign;
            [WXApi sendReq:request];
            
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
        
        
    } error:^(NSError *error) {
        
    }];
    
    
   //1.订单号
    //2.支付金额（单位分）
    //3.商品描述
    //4.本机IP
    
    
}
//本地IP
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
   // [self.navigationController popViewControllerAnimated:YES];
//    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"返回将会撤销订单并清空购物车\n是否确认返回" preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alert animated:YES completion:nil];
//    
//    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self deleateGouWuChe];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    
//    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alert addAction:action1];
//    [alert addAction:action2];
//    
}
#pragma mark --清空购物车所有菜品
-(void)deleateGouWuChe
{
    //清空第一个表
    ZYData * data =[[ZYData alloc]init];
    [data connectSqlite];
    NSArray * array =[data searchAllPeople];
    for (The_Menu * menu in array) {
        [data deleteWithPeople:menu];
    }
    
    MenData * menDao=[[MenData alloc]init];
    [menDao connectSqlite];
    //把第二个表也删除
    for (TheMenuTwo * menuTwo in [menDao searchAllPeople]) {
        [menDao deleteWithPeople:menuTwo];
    }
    
    
}
#pragma mark --获取订单信息
-(void)getOrderMessage
{
    [Engine getOrderMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            _model=[[SettlementModel alloc]initWithOrderDic:[dic objectForKey:@"content"]];
        }
     
    } error:^(NSError *error) {
        
    }];
    
}

@end
