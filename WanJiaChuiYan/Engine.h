//
//  Engine.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);
@interface Engine : NSObject
#pragma mark --用户注册
+(void)registeredUserNamePhoneNumber:(NSString*)phoneNumber Code:(NSString*)code PassWord:(NSString*)psw PassWordTwo:(NSString*)pswtwo invitationCode:(NSString*)invitation success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --登录
+(void)LoginUserName:(NSString*)name PassWord:(NSString*)pass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --添加个人资料
+(void)AddMineInfomationRegistID:(NSString*)regisID name:(NSString*)nicheng QuCanDianID:(NSString*)qucanID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --申请万家厨房
+(void)shenQingWanJiaChuFang:(NSString*)regsiID lianXiNumber:(NSString*)phone Address:(NSString*)dizhi longitude:(NSString*)jingdu latitude:(NSString*)weiDu  provname:(NSString*)sheng cityName:(NSString*)city districtName:(NSString*)xian payStye:(NSString*)shouKuan payAccoun:(NSString*)zhangHao zjImage:(NSMutableArray*)zhengJiaImage success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --上传图片获取地址
+(void)shangChuanData:(NSData*)imagCode success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --忘记密码
+(void)forgetMiMaAccount:(NSString*)account Password:(NSString*)pasw YanZhengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询申请万家厨房的结果
+(void)queryWanJiasuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --修改个人资料
+(void)upDataMessageValue:(NSString*)value filedName:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询厨房信息
+(void)querChuFangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询厨房今日营业
+(void)quiteTodayYingYeStyesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --查询今日营业详情界面
+(void)quiteTodayXiangQingsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --今日营业菜品上报
+(void)todayShangBao:(NSString*)cookInforArray success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --获取省份列表
+(void)quiteShengFenlieBiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --打饭界面获取取餐点列表
+(void)daFanQuCanDianJingDu:(NSString*)jingdu WeiDu:(NSString*)weidu Sheng:(NSString*)sheng City:(NSString*)city success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询菜单
+(void)quiteMenuDaFanSheng:(NSString*)sheng CityName:(NSString*)cityname success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --申请小站
+(void)shenQingXiaoZhanPhone:(NSString*)phone Call:(NSString*)call AddRess:(NSString*)dizhi JinDu:(NSString*)jdu WeiDu:(NSString*)weidu Sheng:(NSString*)sheng City:(NSString*)city Xian:(NSString*)xian payStye:(NSString*)paystye PayNumber:(NSString*)paynumber xiaoZhanImage:(NSMutableArray*)imagexz ZhengJianImage:(NSMutableArray*)imageZj success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --查询小站申请状态
+(void)quiteXiaoZhanShenStyesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询小站信息
+(void)quiteXiaoZhanMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --获取确认订单信息
+(void)getOrderMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --提交打饭菜单
+(void)TiJiaoDaFanMenuOrderBianHao:(NSString*)bianHao Provname:(NSString*)sheng CityName:(NSString*)cityName TotalMoney:(NSString*)totalPrice Order:(NSString*)order success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --找人带领开关状态
+(void)PeopleDaiLingSwitchOnsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --找人带领详情页面
+(void)zhaoRenDaiLingXiangXisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --app添加带领人
+(void)appAddDaiLingRenAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --删除带领人
+(void)deleagteDaiLingRenPhone:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark--设置开启的代领人
+(void)kaiQiDaiLingRenAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark--关闭带领人
+(void)ShutDownDaiLingRensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --查询副站长开关
+(void)quiteFuZhanZhangSwitchsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询副站长列表详情
+(void)quiteFuZhanZhangXiangQingsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --添加副站长
+(void)AddFuZhanZhangAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --删除副站长
+(void)deleagteFuZhanZhangAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --开启副站长
+(void)kaiQiFuZhanZhangAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --关闭所有站长
+(void)guanBiZhanZhangsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --关闭今日营业'
+(void)closeTodayYingYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询用户粮票
+(void)quiteLiangPiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --购买餐具
+(void)canJuGouMaisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --app设置更换取餐的
+(void)appSheZhiChangeQuCanDianID:(NSString*)quID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --打饭界面更换取餐点ID
+(void)gengHuanQuCanDianstation_id:(NSString*)statiID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --申请中(小站)
+(void)shenQingZhongProvName:(NSString*)provname CityName:(NSString*)cityname JingDu:(NSString*)Jlatitude WeiDu:(NSString*)Wlongitude success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --申请中点赞支持取消
+(void)shenqingZhiChiStaticID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --获取分享码
+(void)huoQuFenXiangMasuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --收菜饭菜
+(void)shouCaiFanCaisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --app查询炊烟小站的餐具订单
+(void)quiteCanJuOrdersuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查询炊烟小站的用户取餐状态
+(void)quiteSwithXiaoZhansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --切换用户取餐（是否取餐
+(void)isNotQuCansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --万家厨房查询订单，按厨房分组
+(void)WanJiaChuFangChuFangFensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --万家厨房查询订单，按照菜品份
+(void)WanJiaChuFangCaiPinFensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --我的订单（我的界面）
+(void)MyOrderWeiLingQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --我的订单(已领取)
+(void)MyOrderLingQuLesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --我的订单(立即领取)
+(void)lijiLingQuOrder:(NSString*)orderHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --确认领取(我的订单里面)
+(void)querenlingquDanHao:(NSString*)danhao nsnumber:(NSString*)num  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --实收菜单表
+(void)shiShouMenTableViewChuFangID:(NSString*)chuID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --上报实收饭菜
+(void)shangBaoShiShouFanCaiChuFangID:(NSString*)chuID JsonStr:(NSString*)json success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --已领取菜品的评价
+(void)pingjiaMenuDingDanHao:(NSString*)danHao ChuID:(NSString*)chuId XiaoZhanID:(NSString*)xiaozhanID MenuID:(NSString*)menID  tuiJian:(NSString*)tuijian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --确认支付成功
+(void)queRenZhiFupayDingDanHao:(NSString*)danHao FanCaiMa:(NSString*)fancima PayStye:(NSString*)pay  LiangPiao:(NSString*)jine ZongJinPrice:(NSString*)totlePrice success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --微信预支付
+(void)WXyuZhiFuDingDanHao:(NSString*)danHao Price:(NSString*)price MiaoShu:(NSString*)miaoshu SheBeiIP:(NSString*)sheIP success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --获取倒计时
+(void)timeHuoQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --短信倒计时
+(void)duanXinTime:(NSString*)phoneNumber success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --餐具发放
+(void)fafangCanJuDingDanHao:(NSString*)danHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --是否是登录退出
+(void)isLoginTuiChusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --下单关闭的时间
+(void)xiaDanCloseTimesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --今日营业提交
+(void)todayTijiaoStyle:(NSString*)style success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --查看业绩(小站和厨房
+(void)ChaKanYeJiUrl:(NSString*)url UrlTwo:(NSString*)Url2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --66查看小站宣传语
+(void)ChaKanXiaoZhanXuanChuansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --67更新小站宣传语
+(void)gengXinGuangGao:(NSString *)str success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


@end
