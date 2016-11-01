//
//  MapViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MapViewController.h"
//bmkroute
@interface MapViewController ()<BMKMapViewDelegate,BMKRouteSearchDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView ;//地图初始化
    BMKPointAnnotation* _annotation;//设置标注物
    UITextField * _textFiled;
    CLGeocoder * _coder; //地理编码 反编码
    NSString * jingDu;
    NSString * weiDu;
    BMKGeoCodeSearch *_searcher;//百度地图编码
}
@end

@implementation MapViewController
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"地图坐标";
    [self leftBtn];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.view.backgroundColor=[UIColor whiteColor];
    [self rightBtn];
    
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
   // geoCodeSearchOption.city= @"石家庄市";
    geoCodeSearchOption.address = _addressCity;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
         [LCProgressHUD showMessage:@"请填写详细地址"];
    }
    
    
//
    
    
    
    

   
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"精度%f",result.location.longitude);
        NSLog(@"维度%f",result.location.latitude);
        NSLog(@">>>%@",result.address);
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",result.location.longitude] forKey:@"starjd"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",result.location.latitude] forKey:@"starwd"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //通过纬度，精度获取到具体地址(反向编码)
        _searcher = [[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;//注意实现代理
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){result.location.latitude, result.location.longitude};
        BMKReverseGeoCodeOption *revers = [[BMKReverseGeoCodeOption alloc]init];
        revers.reverseGeoPoint = pt;
        BOOL flag = [_searcher reverseGeoCode:revers];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }

        
        
        
            //创建地图
          _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight)];
            [self.view addSubview:_mapView];
         _mapView.mapType = BMKMapTypeStandard;
        
        
            //添加标注
            _annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
        coor.latitude =result.location.latitude  ;//38.057572;//刚一开始打开地图时的位置
        coor.longitude= result.location.longitude;//114.529362;
            _annotation.coordinate = coor;
            _mapView.centerCoordinate=coor;
            _annotation.title =result.address;//@"石家庄安桥商务";
            [_mapView addAnnotation:_annotation];
        
        
            //添加手势
            UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
            [_mapView addGestureRecognizer:mTap];
            
            //编码
            _coder = [[CLGeocoder alloc]init];

    }
    else {
        NSLog(@"抱歉，未找到结果");
        [LCProgressHUD showMessage:@"请填写详细地址"];
    }
}

//#pragma mark --把地址编译成经纬度在地图显示出来
//-(void)btnn{
//    //（把具体的地址编译成经纬度）
//    [_coder geocodeAddressString:_textFiled.text completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * mark, NSUInteger idx, BOOL *stop) {
//            //纬度
//            CLLocationDegrees lat =mark.location.coordinate.latitude;
//            //经度
//            CLLocationDegrees lon = mark.location.coordinate.longitude;
//            NSLog(@"编码后的经度是%f,纬度是%f",lon,lat);
//            
//            _annotation.coordinate = mark.location.coordinate;
//            _mapView.centerCoordinate=mark.location.coordinate;
//            _annotation.title = _textFiled.text;
//            [_mapView addAnnotation:_annotation];
//            
//        }];
//        
//    }];
//}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark --手势点击获取经纬度
-(void)tapPress:(UIGestureRecognizer*)gestureRecognizer
{
    
    //获取用户点击的经纬度
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView ];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView ];
    
    //通过纬度，精度获取到具体地址(反向编码)
    _searcher = [[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;//注意实现代理
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){touchMapCoordinate.latitude, touchMapCoordinate.longitude};
    BMKReverseGeoCodeOption *revers = [[BMKReverseGeoCodeOption alloc]init];
    revers.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:revers];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
   //  NSLog(@"维度%f精度%f",touchMapCoordinate.latitude, touchMapCoordinate.longitude);
     jingDu =[NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
     weiDu =[NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
    
}


#pragma mark --反向编码接收的代理
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        // 在此处理正常结果
        NSLog(@">>>>%@",result.addressDetail.city);
//        NSLog(@"哈哈我来了
//              ");
        NSMutableDictionary * dic =[NSMutableDictionary new];
        [dic setObject:result.addressDetail.province forKey:@"sheng"];
        [dic setObject:result.addressDetail.city forKey:@"shi"];
        [dic setObject:result.addressDetail.district forKey:@"xian"];
        [XYString savePlist:dic name:@"adress"];
        //省份
//        district
//        city;
//        province;
        
        _annotation.coordinate = result.location;//大头针的位置
        _mapView.centerCoordinate=result.location;//把地图中心点移动到点击位置
         _annotation.title =result.address ;//大头针的标题
        [_mapView addAnnotation:_annotation];//把大头针添加到地图上
       
    }
    else {
          NSLog(@"抱歉，未找到结果");
    }
}



#pragma mark --标注物执行的方法
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
#pragma mark -- 假说有2个大头针，这个是点击大头针可以切换，可以获取大头针的坐标
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    //NSLog(@"点击了大头针移动过来了");
    //把地图中心点移动到大头针
    _mapView.centerCoordinate =view.annotation.coordinate;
    //获取大头针的坐标
    //NSLog(@"%f>>%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
}
#pragma mark -- 移动地图的时候
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //  NSLog(@"你移动地图了");
    // CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    //输出地图的经纬度
    //  NSLog(@"%f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
}
#pragma mark --右上角的保存
-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setTitle:@"确定" forState:0];
     [fabu setTitleColor:[UIColor blackColor] forState:0];
    fabu.frame=CGRectMake(ScreenWidth-104/2-10,27, 104/2, 57/2);
    [fabu addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
}
-(void)saveBtn{
    if (jingDu==nil) {
        NSLog(@"空空");
        self.JingWeiBlock([[NSUserDefaults standardUserDefaults]objectForKey:@"starjd"],[[NSUserDefaults standardUserDefaults]objectForKey:@"starwd"]);
        
    }else{
        self.JingWeiBlock(jingDu,weiDu);
      
    }
      [self.navigationController popViewControllerAnimated:YES];
    
    
   
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
