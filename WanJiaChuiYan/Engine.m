//
//  Engine.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Engine.h"

@implementation Engine
#pragma mark --用户注册
+(void)registeredUserNamePhoneNumber:(NSString*)phoneNumber Code:(NSString*)code PassWord:(NSString*)psw PassWordTwo:(NSString*)pswtwo invitationCode:(NSString*)invitation success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@regist/app_personalRegist.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:phoneNumber forKey:@"account"];
    [parameter setObject:code forKey:@"randomStr"];
    [parameter setObject:psw forKey:@"password"];
    [parameter setObject:pswtwo forKey:@"password2"];
    if (invitation) {
        [parameter setObject:invitation forKey:@"invitation_code"];
    }
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"注册的%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --登录
+(void)LoginUserName:(NSString*)name PassWord:(NSString*)pass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@login/app_Login.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:name forKey:@"account"];
    [parameter setObject:pass forKey:@"password"];
   
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"登录的%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}

#pragma mark --添加个人资料
+(void)AddMineInfomationRegistID:(NSString*)regisID name:(NSString*)nicheng QuCanDianID:(NSString*)qucanID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_addBaseInfo.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    NSLog(@"注册号%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"]);
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:nicheng forKey:@"name"];//昵称
    [parameter setObject:qucanID forKey:@"takeStation_id"];//取餐点ID
    [parameter setObject:@"123" forKey:@"headimgurl"];//头像
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];//注册ID
   
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"填写个人信息的%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
}

#pragma mark --申请万家厨房
+(void)shenQingWanJiaChuFang:(NSString*)regsiID lianXiNumber:(NSString*)phone Address:(NSString*)dizhi longitude:(NSString*)jingdu latitude:(NSString*)weiDu  provname:(NSString*)sheng cityName:(NSString*)city districtName:(NSString*)xian payStye:(NSString*)shouKuan payAccoun:(NSString*)zhangHao zjImage:(NSMutableArray*)zhengJiaImage success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_applyKitchen.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    NSString * idd =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"];
      [parameter setObject:@"ios" forKey:@"osType"];
      [parameter setObject:idd forKey:@"regist_id"];//注册ID
      [parameter setObject:phone forKey:@"connect_tel"];//电话
      [parameter setObject:dizhi forKey:@"addr"];//地址
      [parameter setObject:jingdu forKey:@"longitude"];//精度
      [parameter setObject:weiDu forKey:@"latitude"];//维度
      [parameter setObject:sheng forKey:@"provname"];//省
      [parameter setObject:city forKey:@"cityname"];//市
      [parameter setObject:xian forKey:@"districtname"];//县
      [parameter setObject:shouKuan forKey:@"payReceive_type"];//收款类型
      [parameter setObject:zhangHao forKey:@"payReceive_account"];//收款账号
     // [parameter setObject:zhengJiaImage forKey:@"image"];//图片
    for (int i =0; i<zhengJiaImage.count; i++) {
        NSString * name =[NSString stringWithFormat:@"image%d",i];
        [parameter setObject:zhengJiaImage[i] forKey:name];
    }
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"申请万家厨房%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}

#pragma mark --上传图片获取地址
+(void)shangChuanData:(NSData*)imagCode success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
  
    NSString * urlStr =[NSString stringWithFormat:@"%@upload/app_uploadImgBase64.action",SERVICE];
    
    //获得的data
    NSData *imageData=imagCode;
    //base编码后
    NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:endStr forKey:@"imgCode"];
    [dicc setObject:@"ios" forKey:@"osType"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"上传图片后返回的地址%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
    
}

#pragma mark --忘记密码
+(void)forgetMiMaAccount:(NSString*)account Password:(NSString*)pasw YanZhengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_addBaseInfo.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    NSLog(@"注册号%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"]);
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:account forKey:@"account"];
    [parameter setObject:pasw forKey:@"password"];
    [parameter setObject:code forKey:@"randomStr"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"填写个人信息的%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}
#pragma mark --查询申请万家厨房的结果
+(void)queryWanJiasuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_qryKitchenApplayStatus.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
   
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询申请万家厨房的结果%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}

#pragma mark --修改个人资料
+(void)upDataMessageValue:(NSString*)value filedName:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
  
     NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_updateBaseInfoByOneField.action",SERVICE];
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    NSLog(@"name>>>%@",name);
    [parameter setObject:value forKey:@"fieldValue"];
    [parameter setObject:name forKey:@"fieldName"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改个人资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"%@",error);
    }];
}
#pragma mark --查询厨房信息
+(void)querChuFangMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_getKitchenInfoByRegist_Id.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询厨房信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
    
}
#pragma mark --查询厨房今日营业
+(void)quiteTodayYingYeStyesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_qryFoodReportStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询查询厨房今日营业%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}


#pragma mark --查询今日营业详情界面
+(void)quiteTodayXiangQingsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_qryAllocatedFoodReportDetail.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询今日营业详情界面%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}


#pragma mark --今日营业菜品上报
+(void)todayShangBao:(NSString*)cookInforArray success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_updateCookFoodReport.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    [parameter setObject:cookInforArray forKey:@"cookInfoArray"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"今日营业菜品上报%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}

#pragma mark --获取省份列表
+(void)quiteShengFenlieBiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@system_area/app_qryAllCity.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取省份列表%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
}
#pragma mark --打饭界面获取取餐点列表
+(void)daFanQuCanDianJingDu:(NSString*)jingdu WeiDu:(NSString*)weidu Sheng:(NSString*)sheng City:(NSString*)city success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryStationListInOrder.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    NSString * resiID =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"];
    if (resiID==nil) {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    [parameter setObject:resiID forKey:@"regist_id"];
     [parameter setObject:jingdu forKey:@"longitude"];
     [parameter setObject:weidu forKey:@"latitude"];
     [parameter setObject:sheng forKey:@"provname"];
     [parameter setObject:city forKey:@"cityname"];
    
    NSLog(@"坎坎坷坷发吧longitude%@",jingdu);
    NSLog(@"坎坎坷坷发吧latitude%@",weidu);
    NSLog(@"坎坎坷坷发吧provname%@",sheng);
    NSLog(@"坎坎坷坷发吧cityname%@",city);
    NSLog(@"坎坎坷坷发吧regist_id%@",resiID);
    NSLog(@"坎坎坷坷发吧osType ios");
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"打饭界面获取取餐点列表%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}


#pragma mark --查询菜单
+(void)quiteMenuDaFanSheng:(NSString*)sheng CityName:(NSString*)cityname success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@food_menu/app_qryFoodMenusInOrder.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    NSString * resiID =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"];
    if (resiID==nil) {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    [parameter setObject:resiID forKey:@"regist_id"];
    [parameter setObject:sheng forKey:@"provname"];
    [parameter setObject:cityname forKey:@"cityname"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询菜单%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接(饭菜)"];
        NSLog(@"请检查网络连接(饭菜)>>>>>%@",error);
    }];
    
}
#pragma mark --申请小站
+(void)shenQingXiaoZhanPhone:(NSString*)phone Call:(NSString*)call AddRess:(NSString*)dizhi JinDu:(NSString*)jdu WeiDu:(NSString*)weidu Sheng:(NSString*)sheng City:(NSString*)city Xian:(NSString*)xian payStye:(NSString*)paystye PayNumber:(NSString*)paynumber xiaoZhanImage:(NSMutableArray*)imagexz ZhengJianImage:(NSMutableArray*)imageZj success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_applyStation.action",SERVICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    NSString * idd =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:idd forKey:@"apply_regist_id"];//注册ID
    [parameter setObject:phone forKey:@"master_account"];//账号
    [parameter setObject:call forKey:@"connect_tel"];//电话
    [parameter setObject:dizhi forKey:@"addr"];
    [parameter setObject:jdu forKey:@"longitude"];//精度
    [parameter setObject:weidu forKey:@"latitude"];//维度
    [parameter setObject:sheng forKey:@"provname"];//省
    [parameter setObject:city forKey:@"cityname"];//市
    [parameter setObject:xian forKey:@"districtname"];//县
     [parameter setObject:paystye forKey:@"payReceive_type"];//收款方式
    [parameter setObject:paynumber forKey:@"payReceive_account"];//收款方式
    [parameter setObject:imagexz[0] forKey:@"station_image"];
    
    
    for (int i =0; i<imageZj.count; i++) {
        NSString * name =[NSString stringWithFormat:@"credentials_image%d",i];
        [parameter setObject:imageZj[i] forKey:name];
    }
    
    
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"申请小站%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --查询小站申请状态
+(void)quiteXiaoZhanShenStyesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryStationApplayStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"master_regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询小站申请状态%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
}
#pragma mark --查询小站信息
+(void)quiteXiaoZhanMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_getStationInfoByMaster_Regist_Id.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"master_regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询小站申请状态%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --获取确认订单信息
+(void)getOrderMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@payment/app_getout_trade_no.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取确认订单信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --提交打饭菜单
+(void)TiJiaoDaFanMenuOrderBianHao:(NSString*)bianHao Provname:(NSString*)sheng CityName:(NSString*)cityName TotalMoney:(NSString*)totalPrice Order:(NSString*)order success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_submitOrder.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
     [parameter setObject:bianHao forKey:@"out_trade_no"];
     [parameter setObject:sheng forKey:@"provname"];
     [parameter setObject:cityName forKey:@"cityname"];
     [parameter setObject:totalPrice forKey:@"total_money"];
     [parameter setObject:order forKey:@"orderInfoArr"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取确认订单信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --找人带领开关状态
+(void)PeopleDaiLingSwitchOnsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryReplacementStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"找人带领开关状态%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --找人带领详情页面
+(void)zhaoRenDaiLingXiangXisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryReplacementDetail.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"找人带领详情页面%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --app添加带领人
+(void)appAddDaiLingRenAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_addReplacement.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
     [parameter setObject:account forKey:@"replace_account"];
     [parameter setObject:name forKey:@"replace_user_name"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"app添加带领人%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}
#pragma mark --删除带领人
+(void)deleagteDaiLingRenPhone:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_deleteReplacement.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:account forKey:@"replace_account"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除带领人%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    

}
#pragma mark--设置开启的代领人
+(void)kaiQiDaiLingRenAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_setOpenedReplacement.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:account forKey:@"replace_account"];
     [parameter setObject:name forKey:@"replace_user_name"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"设置开启的代领人%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark--关闭带领人
+(void)ShutDownDaiLingRensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_closeReplacement.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"关闭带领人%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
    
}


#pragma mark --查询副站长开关
+(void)quiteFuZhanZhangSwitchsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryViceMasterOpenStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询副站长开关%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
}
#pragma mark --查询副站长列表详情
+(void)quiteFuZhanZhangXiangQingsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryViceMasterDetailList.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询副站长开关%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
}
#pragma mark --添加副站长
+(void)AddFuZhanZhangAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
  
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_addViceMaster.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:account forKey:@"vice_account"];
    [parameter setObject:name forKey:@"vice_name"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"添加副站长%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}
#pragma mark --删除副站长
+(void)deleagteFuZhanZhangAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_deleteViceMaster.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:account forKey:@"vice_account"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除副站长%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --开启副站长
+(void)kaiQiFuZhanZhangAccount:(NSString*)account Name:(NSString*)name success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_setOpenedViceMaster.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:account forKey:@"vice_account"];
   // [parameter setObject:name forKey:@"replace_user_name"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"开启副站长%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    

}
#pragma mark --关闭所有站长
+(void)guanBiZhanZhangsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_closeViceMaster.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"关闭所有站长%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    

}
#pragma mark --关闭今日营业'
+(void)closeTodayYingYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_closeFoodReport.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"关闭所有站长%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}

#pragma mark --查询用户粮票
+(void)quiteLiangPiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryFoodStamps.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询用户粮票%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"%@",error);
    }];

}

#pragma mark --购买餐具
+(void)canJuGouMaisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_payForTableware.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"购买餐具%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}
#pragma mark --app设置更换取餐的
+(void)appSheZhiChangeQuCanDianID:(NSString*)quID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_updateTakeStation.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:quID forKey:@"station_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"app设置更换取餐的%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}
#pragma mark --打饭界面更换取餐点ID
+(void)gengHuanQuCanDianstation_id:(NSString*)statiID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_updateTakeStation.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:statiID forKey:@"station_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"打饭界面更换取餐点ID%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --申请中(小站)
+(void)shenQingZhongProvName:(NSString*)provname CityName:(NSString*)cityname JingDu:(NSString*)Jlatitude WeiDu:(NSString*)Wlongitude success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryStationsInApplying.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    NSString * resiID =[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"];
    if (resiID==nil) {
        [LCProgressHUD showMessage:@"请登录"];
        return;
    }
    [parameter setObject:resiID forKey:@"regist_id"];
    [parameter setObject:provname forKey:@"provname"];
    [parameter setObject:cityname forKey:@"cityname"];
    [parameter setObject:Jlatitude forKey:@"longitude"];
    [parameter setObject:Wlongitude forKey:@"latitude"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询菜单%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
}
#pragma mark --申请中点赞支持取消
+(void)shenqingZhiChiStaticID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_toggleStationApplyPraise.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:idd forKey:@"station_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"申请中点赞支持取消%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
}
#pragma mark --获取分享码
+(void)huoQuFenXiangMasuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryPromote_Code.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取分享码%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --收菜饭菜
+(void)shouCaiFanCaisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryReceiveFoodInTheory2.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"收菜饭菜%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --app查询炊烟小站的餐具订单
+(void)quiteCanJuOrdersuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryTablewareOrder.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询炊烟小站的餐具订单%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
}

#pragma mark --查询炊烟小站的用户取餐状态
+(void)quiteSwithXiaoZhansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryEnableCustomerTakeFoodStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询炊烟小站的用户取餐状态%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
 
}

#pragma mark --切换用户取餐（是否取餐）
+(void)isNotQuCansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_toggleCustomerTakeFoodStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"切换用户取餐%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
 
}
#pragma mark --万家厨房查询订单，按厨房分组
+(void)WanJiaChuFangChuFangFensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_qryOrderGroupByStation.action",SERVICE];\
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"万家厨房查询订单%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
}
#pragma mark --万家厨房查询订单，按照菜品份
+(void)WanJiaChuFangCaiPinFensuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_qryOrderGroupByMenu.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"按照菜品份%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

}

#pragma mark --我的订单（我的界面）
+(void)MyOrderWeiLingQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryMyOrderNotReceived.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"我的订单（我的界面）%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"未领取%@",error);
    }];
    
}
#pragma mark --我的订单(已领取)
+(void)MyOrderLingQuLesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryMyOrderHaveReceived.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"我的订单（已领取）%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --我的订单(立即领取)
+(void)lijiLingQuOrder:(NSString*)orderHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_receiveImmediately.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:orderHao forKey:@"out_trade_no"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"我的订单（已领取）%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}

#pragma mark --确认领取(我的订单里面)
+(void)querenlingquDanHao:(NSString*)danhao nsnumber:(NSString*)num success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_confirmReceive.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:num forKey:@"receive_result"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:danhao forKey:@"out_trade_no"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"确认领取(我的订单里面)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --实收菜单表
+(void)shiShouMenTableViewChuFangID:(NSString*)chuID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_qryReceivedFoodListInFact.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:chuID forKey:@"kitchen_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"实收菜单表%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --上报实收饭菜
+(void)shangBaoShiShouFanCaiChuFangID:(NSString*)chuID JsonStr:(NSString*)json success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_updateReceivedFoodListInFact.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:chuID forKey:@"kitchen_id"];
    [parameter setObject:json forKey:@"orderInfoInFact"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"上报实收饭菜%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --已领取菜品的评价
+(void)pingjiaMenuDingDanHao:(NSString*)danHao ChuID:(NSString*)chuId XiaoZhanID:(NSString*)xiaozhanID MenuID:(NSString*)menID  tuiJian:(NSString*)tuijian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_gradeOrderMenu.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
   
    [parameter setObject:chuId forKey:@"kitchen_id"];
    [parameter setObject:xiaozhanID forKey:@"station_id"];
    [parameter setObject:danHao forKey:@"out_trade_no"];
    [parameter setObject:menID forKey:@"menu_id"];
    [parameter setObject:tuijian forKey:@"grade_status"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"已领取菜品的评价%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --确认支付成功
+(void)queRenZhiFupayDingDanHao:(NSString*)danHao FanCaiMa:(NSString*)fancima PayStye:(NSString*)pay LiangPiao:(NSString*)jine ZongJinPrice:(NSString*)totlePrice success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_confirmPayment.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * cityName =[XYString duquPlistWenJianPlistName:@"cityDingWei"];
    if (cityName==nil ) {
        [LCProgressHUD showMessage:@"打饭界面暂无省份"];
        return;
    }
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    [parameter setObject:danHao forKey:@"out_trade_no"];
    [parameter setObject:fancima forKey:@"goods_type"];
    [parameter setObject:pay forKey:@"payment_platform"];
    [parameter setObject:[cityName objectForKey:@"shengName"] forKey:@"provname"];
    [parameter setObject:[cityName objectForKey:@"cityName"] forKey:@"cityname"];
   
    
    if (jine!=nil) {
        [parameter setObject:jine forKey:@"foodStamps_forSubtract"];
    }
    if (totlePrice!=nil) {
         [parameter setObject:totlePrice forKey:@"total_fee_forSubtract"];
    }
    
   
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"确认支付成功%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];

    
}
#pragma mark --微信预支付
+(void)WXyuZhiFuDingDanHao:(NSString*)danHao Price:(NSString*)price MiaoShu:(NSString*)miaoshu SheBeiIP:(NSString*)sheIP success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@payment/app_weixin_perpay.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    [parameter setObject:danHao forKey:@"out_trade_no"];
    [parameter setObject:price forKey:@"total_fee"];
    [parameter setObject:miaoshu forKey:@"body"];
   
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"微信预支付%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}
#pragma mark --获取倒计时
+(void)timeHuoQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlStr =[NSString stringWithFormat:@"%@payment/app_qryCountdown_second.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
   // [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取倒计时%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
}
#pragma mark --发送短信验证码
+(void)duanXinTime:(NSString*)phoneNumber success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@sms/pushVerificationCode.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:phoneNumber forKey:@"telNum"];
    
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"发送短信验证码%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
    }];
    
    
}
#pragma mark --餐具发放
+(void)fafangCanJuDingDanHao:(NSString*)danHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@station/app_sendTableware.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:danHao forKey:@"out_trade_no"];
     [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"餐具发放%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"餐具发放请检查网络连接"];
    }];
    
}
#pragma mark --是否是登录退出
+(void)isLoginTuiChusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@customer/app_qryUser_Type.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"是否是登录退出%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"是否是登录退出请检查网络连接"];
    }];
}


#pragma mark --下单关闭的时间
+(void)xiaDanCloseTimesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@systemconfig/app_getCurtimeAndOrder_close_time.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
   
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"下单关闭的时间%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"是否是登录退出请检查网络连接"];
    }];

    
}
#pragma mark --今日营业提交
+(void)todayTijiaoStyle:(NSString*)style success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@kitchen/app_toogleFoodReportStatus.action",SERVICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [parameter setObject:style forKey:@"status"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"今日营业提交%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"是否是登录退出请检查网络连接"];
    }];
 
}


#pragma mark --查看业绩(小站和厨房)
+(void)ChaKanYeJiUrl:(NSString*)url  UrlTwo:(NSString*)Url2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    ///   station/app_qryStationAchievements.action
    ///    kitchen/app_qryKitchenAchievements.action Kitchen
    NSString * urlStr =[NSString stringWithFormat:@"%@%@/app_qry%@Achievements.action",SERVICE,url,Url2];
    NSLog(@"输出%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter=[NSMutableDictionary new];
    [parameter setObject:@"ios" forKey:@"osType"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuceid"] forKey:@"regist_id"];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查看业绩(小站和厨房)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"查看业绩(小站和厨房)退出请检查网络连接"];
    }];
}
@end
