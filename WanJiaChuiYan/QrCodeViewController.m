//
//  QrCodeViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "QrCodeViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
@interface QrCodeViewController ()
@property(nonatomic,retain)UIView * bgView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.title=@"扫描下载";
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatErcodeBack];
    [self imageData];
}
#pragma mark --创建二维码背景
-(void)CreatErcodeBack{
    
    NSDictionary* dicc= [XYString duquPlistWenJianPlistName:@"base"];
   
    
    
    
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    [self.view sd_addSubviews:@[_bgView]];
    _bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,20);
    //头像
    UIImageView * headImage =[UIImageView new];
   // headImage.image=[UIImage imageNamed:@"picmy"];//换成网络图片
    NSString * url =[dicc objectForKey:@"headimgurl"];
    [headImage  setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photomy"]];
   
    
    [_bgView sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .leftSpaceToView(_bgView,10)
    .topSpaceToView(_bgView,10)
    .widthIs(60)
    .heightIs(60);
    //名字
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=[self stringText:[dicc objectForKey:@"name"]];//;//@"快乐小厨房";
    nameLabel.font=[UIFont systemFontOfSize:14];
    nameLabel.alpha=.8;
    [_bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(headImage,15)
    .topSpaceToView(_bgView,20)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    //手机号
    UILabel * phoneLable =[UILabel new];
    phoneLable.text= [self stringText:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];  //;
    phoneLable.font=[UIFont systemFontOfSize:14];
    phoneLable.alpha=.6;
    [_bgView sd_addSubviews:@[phoneLable]];
    phoneLable.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,5)
    .heightIs(20);
    [phoneLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    //二维码
    UIImageView  * erCode=[[UIImageView alloc]init];
    erCode.image=[UIImage imageNamed:@"myerweima"];
    [_bgView sd_addSubviews:@[erCode]];
    erCode.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(headImage,20)
    .widthIs(200)
    .heightIs(200);
    //
    UILabel * label =[UILabel new];
    label.text=@"扫一扫上面的二维码";
    label.font=[UIFont systemFontOfSize:15];
    label.alpha=.7;
    [_bgView sd_addSubviews:@[label]];
    label.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(erCode,15)
    .heightIs(15);
    [label setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    
    
    [_bgView setupAutoHeightWithBottomView:label bottomMargin:20];
}

#pragma mark --数据解析
-(void)imageData{
    _dataArray=[NSMutableArray new];
    [Engine huoQuFenXiangMasuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSString * content =[dic objectForKey:@"content"];
            [_dataArray addObject:content];
            
        }
      [self CreatYaoQingBtn];
    } error:^(NSError *error) {
        
    }];
    
    
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
    .topSpaceToView(_bgView,20)
    .leftSpaceToView(self.view,50)
    .rightSpaceToView(self.view,50)
    .heightIs(30);
    
    
    
}
-(void)button{
    //搜索附近家厨，更新午餐标准，
    NSString * str= [NSString stringWithFormat:@"午餐搜索，不一样的烟火。新用户注册填写邀请码%@得3元粮票",_dataArray[0]];
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
-(NSString *)stringText:(id)text1 {
    
    NSString * str;
    if (text1==nil || [text1 isEqualToString:@"(null)"] ) {
        str=@"";
    }else{
        str=text1;
    }
    return str;
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
