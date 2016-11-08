//
//  PromotionCodeViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PromotionCodeViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
@interface PromotionCodeViewController ()
@property(nonatomic,retain)UIImageView * imageViewTitle;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation PromotionCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"我的推广码";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    [self CreatTitleImage];
    [self imageData];
    [self CreatTwoLable];

}

#pragma mark --数据解析
-(void)imageData{
    [Engine huoQuFenXiangMasuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSString * content =[dic objectForKey:@"content"];
            [_dataArray addObject:content];
        }
        [self CreatImageContent];
    } error:^(NSError *error) {
        
    }];
    
    
}

-(void)CreatTitleImage{
    _imageViewTitle=[[UIImageView alloc]init];
    _imageViewTitle.userInteractionEnabled=YES;
  //  _imageViewTitle.backgroundColor=[UIColor redColor];
    _imageViewTitle.image=[UIImage imageNamed:@"tuiguangma_bg"];
    [self.view sd_addSubviews:@[_imageViewTitle]];
    _imageViewTitle.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(375*193/750);
}
#pragma mark --图片
-(void)CreatImageContent{
    UILabel * botm=[UILabel new];
    botm.text=@"立即邀请好友即可获得粮票";
    botm.font=[UIFont systemFontOfSize:13];
    botm.textAlignment=1;
    botm.alpha=.6;
    [_imageViewTitle sd_addSubviews:@[botm]];
    botm.sd_layout
    .bottomSpaceToView(_imageViewTitle,15)
    .centerXEqualToView(_imageViewTitle)
    .heightIs(15);
    [botm setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    UILabel * numLab=[UILabel new];
    numLab.text=_dataArray[0];
    numLab.textAlignment=1;
    numLab.font=[UIFont systemFontOfSize:22];
    numLab.textColor=[UIColor colorWithRed:72/255.0 green:236/255.0 blue:136/255.0 alpha:1];
    [_imageViewTitle sd_addSubviews:@[numLab]];
    numLab.sd_layout
    .topSpaceToView(_imageViewTitle,20)
    .centerXEqualToView(_imageViewTitle)
    .bottomSpaceToView(botm,0);
    [numLab setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    [self CreatYaoQingBtn];
}
#pragma mark --创建2行Lable
-(void)CreatTwoLable{
    UIImageView * dian1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tuiguangma_button"]];
    [self.view sd_addSubviews:@[dian1]];
    dian1.sd_layout
    .leftSpaceToView(self.view,15)
    .topSpaceToView(_imageViewTitle,50)
    .widthIs(8)
    .heightIs(8);
    UIImageView * dian2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tuiguangma_button"]];
    [self.view sd_addSubviews:@[dian2]];
    dian2.sd_layout
    .leftEqualToView(dian1)
    .topSpaceToView(dian1,20)
    .widthIs(8)
    .heightIs(8);
    
    UILabel * label1 =[[UILabel alloc]init];
    label1.text=@"邀请好友:成功邀请一个好友注册APP即可获得2元粮票";
    label1.font=[UIFont systemFontOfSize:14];
    label1.alpha=.6;
    [self.view sd_addSubviews:@[label1]];
    label1.sd_layout
    .leftSpaceToView(dian1,10)
    .centerYEqualToView(dian1)
    .heightIs(15);
    [label1 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    UILabel * label2 =[[UILabel alloc]init];
    label2.alpha=.6;
    label2.text=@"邀请收益:成功邀请好友越多，下载越多，获得的粮票越多";
    label2.font=[UIFont systemFontOfSize:14];
    [self.view sd_addSubviews:@[label2]];
    label2.sd_layout
    .leftSpaceToView(dian2,10)
    .centerYEqualToView(dian2)
    .heightIs(15);
    [label2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
}
#pragma mark -- 创建button
-(void)CreatYaoQingBtn{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor colorWithRed:72/255.0 green:236/255.0 blue:136/255.0 alpha:1];
    btn.sd_cornerRadius=@(5);
    [btn addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"立即邀请" forState:0];
    [self.view sd_addSubviews:@[btn]];
    btn.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .leftSpaceToView(self.view,50)
    .rightSpaceToView(self.view,50)
    .heightIs(30);
    
    
    
}
-(void)button{
//搜索附近家厨，更新午餐标准，
    NSString * str= [NSString stringWithFormat:@"专业掌上午餐，专注一碗好米。新用户注册填写邀请码%@得3元粮票",_dataArray[0]];
//分享给好友时的标题与连接
    [UMSocialData defaultData].extConfig.title = @"万家炊烟";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/us/app/wan-jia-chui-yan/id1163591027?mt=8";
    
//分享给朋友圈的时候标题与连接
    [UMSocialData defaultData].extConfig.wechatTimelineData.title= str;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://itunes.apple.com/us/app/wan-jia-chui-yan/id1163591027?mt=8";
    //分享到QQ空间的连接
     [UMSocialData defaultData].extConfig.qzoneData.url=@"";
    
    
    
    
//短信分享的内容
    [UMSocialData defaultData].extConfig.smsData.shareText=str;
//短信分享的连接
    [UMSocialData defaultData].extConfig.smsData.urlResource.url=@"https://itunes.apple.com/us/app/wan-jia-chui-yan/id1163591027?mt=8";
    [UMSocialSnsService presentSnsIconSheetView:self
                                        appKey:@"57d11a8ee0f55a65880030cd"
                                      shareText:str
                                     shareImage:[UIImage imageNamed:@"icon1"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                       delegate:nil];
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
