//
//  XiaoZhanViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiaoZhanViewController.h"
#import "KitchenTableViewCell.h"
#import "MapViewController.h"
#import "PayStyeViewController.h"
#import "SGImagePickerController.h"//相片选择
#import "ContactKeFuViewController.h"
@interface XiaoZhanViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString * jingWeiDuText;//经纬度连在一起
    NSString * jinDuText;//精度
    NSString * weiDuText;//维度
    NSString * payName;//收款方式
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * nameArray;
@property(nonatomic,retain)NSMutableArray * xiangCeArray;
@property(nonatomic,retain)NSMutableArray * FangArray;
@property(nonatomic,retain)NSMutableArray * xiaoZhanArray;
@end

@implementation XiaoZhanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请饮烟小站";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.tabbarView.hidden=YES;
    [self leftBtn];
    // Do any additional setup after loading the view.
    [self CreatNameArray];
    [self CreatTableView];
    [self CreatLiJiShenQing];
}
#pragma mark --初始化数组
-(void)CreatNameArray{
    NSArray * arr1 =@[@"申请账号",@"联系电话"];
    NSArray * arr2 =@[@"小站地址",@"地图坐标"];
    NSArray * arr3 =@[@"收款方式",@"收款账号"];
    NSArray * arr4 =@[@"小站图片"];
    NSArray * arr5 =@[@"证件存档"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3,arr4,arr5, nil];
    _xiangCeArray=[NSMutableArray new];
    _FangArray=[NSMutableArray new];
    _xiaoZhanArray=[NSMutableArray new];
    _photoUrlArray=[NSMutableArray new];
    _xiaoZhanUrlAr=[NSMutableArray new];
}
#pragma mark -- 表的创建CreatTableView
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
#pragma mark --tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_nameArray[section];
    return arr.count;
}
#pragma mark --tableViewDataSoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _nameArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KitchenTableViewCell * cell =[KitchenTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
//            cell.textField.placeholder=@"已在平台注册的手机号";
            cell.textField.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            cell.textField.enabled=NO;
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;

        }else{
            cell.textField.placeholder=[NSString stringWithFormat:@"例如:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];             cell.textField.keyboardType=UIKeyboardTypeNumberPad;

        }
       
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            cell.textField.placeholder=@"仅您自己可见,平台保密";
        }else{
            cell.textField.hidden=NO;
            cell.arrowImage.hidden=NO;
            cell.textField.enabled=NO;
            cell.textField.placeholder=@"请选择经纬度";
            cell.textField.text=[self stringText:jingWeiDuText Text2:nil];

        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            cell.arrowImage.hidden=NO;
            cell.textField.placeholder=@"请选择您的收款方式";
            cell.textField.enabled=NO;
            cell.textField.text=[self stringText:payName Text2:nil];

        }else{
            cell.textField.placeholder=@"例如:6227000130030601486";
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;

        }
    }else if(indexPath.section==3){
        //小站图片(只能上传一张)
        cell.textField.hidden=YES;
        cell.imagebgView.hidden=NO;
        [cell.addBtn addTarget:self action:@selector(addPhoto1) forControlEvents:UIControlEventTouchUpInside];
    }else{
        //证件存档(最多4张)
        cell.textField.hidden=YES;
        cell.imagebgView.hidden=NO;
        [cell.addBtn addTarget:self action:@selector(addPhoto2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    return cell;
}


#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            //地图坐标
            KitchenTableViewCell *celladdress = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            MapViewController * vc =[[MapViewController alloc]init];
            vc.addressCity=celladdress.textField.text;
            
            vc.JingWeiBlock=^(NSString*jingDu,NSString*weiDu){
                jinDuText=jingDu;
                weiDuText=weiDu;
                NSString *str =[NSString stringWithFormat:@"%@，%@",jingDu,weiDu];
                jingWeiDuText=str;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            //收款方式
            PayStyeViewController * vc =[PayStyeViewController new];
            vc.payStyeBlock=^(NSString*payName2){
                payName=payName2;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        
        
    }

    
}

-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * str;
    if (text1) {
        str=text1;
    }else{
        str=text2;
    }
    
    return str;
}

-(UIView * )CreatCell{
    UIView * cellView=[UIView new];
    cellView.backgroundColor=[UIColor clearColor];
    //证件存档
    UILabel * label =[UILabel new];
    label.text=@"证件存档";
    label.font=[UIFont systemFontOfSize:15];
    label.alpha=.8;
    [cellView sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(cellView,10)
    .topSpaceToView(cellView,5)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:100];
    //照相机
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"apply_kitchen_add"] forState:0];
    [cellView sd_addSubviews:@[button]];
    
    button.sd_layout
    .leftSpaceToView(label,10)
    .centerYEqualToView(cellView)
    .widthIs(60)
    .heightIs(60);
    
    
    return cellView;
}

#pragma mark --申请的2个按钮
-(void)CreatLiJiShenQing{
    //获取1区0行的cell
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    //获取某一行Cell坐标
    CGRect rect = [self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    //立即申请
    UIButton * shenQingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shenQingBtn setBackgroundImage:[UIImage imageNamed:@"shenqing"] forState:0];
    [shenQingBtn addTarget:self action:@selector(shengqing) forControlEvents:UIControlEventTouchUpInside];
    
    if (ScreenHeight==736) {
        shenQingBtn.center=CGPointMake(_tableView.center.x, rect.origin.y+rect.size.height+60);
        shenQingBtn.bounds=CGRectMake(0, 0, 494*35/60, 35);
    }else{
        shenQingBtn.center=CGPointMake(_tableView.center.x, rect.origin.y+rect.size.height+40);
        shenQingBtn.bounds=CGRectMake(0, 0, 494/2, 30);
    }
    [_tableView addSubview:shenQingBtn];
    //联系客服
    UIButton * keFuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [keFuBtn setBackgroundImage:[UIImage imageNamed:@"kefu"] forState:0];
    [keFuBtn addTarget:self action:@selector(keFuBtn) forControlEvents:UIControlEventTouchUpInside];
    
    if (ScreenHeight==736) {
        keFuBtn.center=CGPointMake(_tableView.center.x, shenQingBtn.origin.y+rect.size.height+15);
        keFuBtn.bounds=CGRectMake(0, 0, 494*35/60, 35);
    }else{
        keFuBtn.center=CGPointMake(_tableView.center.x, shenQingBtn.origin.y+rect.size.height);
        keFuBtn.bounds=CGRectMake(0, 0, 494/2, 30);
    }
    [_tableView addSubview:keFuBtn];
    
}

#pragma mark --立即申请
-(void)shengqing{
    if (_xiangCeArray.count==0 || _xiaoZhanArray.count==0) {
        
        [LCProgressHUD showMessage:@"选择照片"];
    }else{
        [LCProgressHUD showLoading:@"正在上传图片..."];
       
        //小站图片
        UIImage * image2 =_xiaoZhanArray[0];
        CGSize size2 =CGSizeMake(image2.size.width,image2.size.height );
        NSData *imgData2=[XYString imageWithImage:image2 scaledToSize:size2];
        [self shangChuanImage:imgData2];
    }
    
}
#pragma mark --在上传图片获取地址呢
-(void)shangChuanImage:(NSData*)data{
    
    [Engine shangChuanData:data success:^(NSDictionary *dic) {
        //证件图片
        [_xiaoZhanUrlAr addObject:[dic objectForKey:@"content"]];
      //  NSLog(@">>%lu",_xiaoZhanUrlAr.count);
        for (UIImage * image in _xiangCeArray )
        {
            CGSize size =CGSizeMake(image.size.width,image.size.height );
            NSData *imgData=[XYString imageWithImage:image scaledToSize:size];
            
           [self twoShangChuan:imgData ];
        }
       
    } error:^(NSError *error) {
        
    }];
}
-(void)twoShangChuan:(NSData*)data {
    NSLog(@"走没走啊");
    [_photoUrlArray removeAllObjects];
    [Engine shangChuanData:data success:^(NSDictionary *dic) {
        [_photoUrlArray addObject:[dic objectForKey:@"content"]];
       NSLog(@"_photoUrlArray怎么回事%lu>>>_xiangCeArray%lu",_photoUrlArray.count,_xiangCeArray.count);
        if (_photoUrlArray.count==_xiangCeArray.count) {
                //当全部加到数组中后可以调用
                [self shenqingdeCanshu];
            
        }
        
    } error:^(NSError *error) {
                    
   }];
    
    
}
#pragma mark --申请的一堆参数
-(void)shenqingdeCanshu{
    //  联系电话
    KitchenTableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //  厨房地址
    KitchenTableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //  收款账号
    KitchenTableViewCell * cell3 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    //联系电话
     KitchenTableViewCell * cell4 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSLog(@"小站数组有个数吗%lu",_xiaoZhanUrlAr.count);
    //经纬度
     NSLog(@"精度%@",jinDuText);
     NSLog(@"维度%@",weiDuText);
    //收款方式
    // NSLog(@"收款方式%@",payName);
    //省市县
    NSMutableDictionary * dic =[XYString duquPlistWenJianPlistName:@"adress"];
    if (dic ==nil) {
         [LCProgressHUD showMessage:@"请重新选择地图坐标"];
        return;
    }
    
//    NSString * str =[dic objectForKey:@"sheng"];
//     NSString * str2 =[dic objectForKey:@"shi"];
//     NSString * str3 =[dic objectForKey:@"xian"];
//    NSLog(@">>>%@--%@---%@",str,str2,str3);
    [LCProgressHUD showLoading:@"正在申请..."];
    
    [Engine shenQingXiaoZhanPhone:[XYString IsNotNull:cell1.textField.text] Call:[XYString IsNotNull:cell4.textField.text] AddRess:[XYString IsNotNull:cell2.textField.text] JinDu:jinDuText WeiDu:weiDuText Sheng:[dic objectForKey:@"sheng"] City:[dic objectForKey:@"shi"] Xian:[dic objectForKey:@"xian"] payStye:[self shouKuanStype:payName] PayNumber:[XYString IsNotNull:cell3.textField.text] xiaoZhanImage:_xiaoZhanUrlAr ZhengJianImage:_photoUrlArray success:^(NSDictionary *dic) {
        
        [LCProgressHUD showInfoMsg:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
       
    } error:^(NSError *error) {
        
    }];
    
    
}
#pragma mark --判断支付方式呢
-(NSString *)shouKuanStype:(NSString*)name{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"1" forKey:@"支付宝"];
    [dic setObject:@"2" forKey:@"微信"];
    [dic setObject:@"3" forKey:@"银行卡"];
    NSString * string =[dic objectForKey:name];
    NSString * str;
    if (name==nil) {
        str=@"";
    }else{
        str=string;
    }
    
    return str;
}
#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 80;
    }else if (indexPath.section==4){
        return 80;
    }
    else{
        return 50;
    }
}


#pragma mark -- 区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 10;
    }else{
        return 15;
    }
}
#pragma mark -- 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view =[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --点击了小站图片加号
-(void)addPhoto1{
    number=10;
    UIAlertController * altController =[UIAlertController alertControllerWithTitle:@"请选择照片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:altController animated:YES completion:nil];
    
   // UIAlertAction * action =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用相机
       // [self phoneXiangJi];
   // }];
    UIAlertAction * xiangCe =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
       [self dioayongXiangCe];;
    }];
    UIAlertAction * quxiao =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消不做处理
    }];
    
  // [altController addAction:action];
    [altController addAction:xiangCe];
    [altController addAction:quxiao];
    
    
}
#pragma mark --证件存档
-(void)addPhoto2{
    number=20;
    UIAlertController * altController =[UIAlertController alertControllerWithTitle:@"请选择照片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:altController animated:YES completion:nil];
    
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调用相机
         [self phoneXiangJi];
    }];
    UIAlertAction * xiangCe =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        [self diaoYongXiangCe];
        
    }];
    UIAlertAction * quxiao =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消不做处理
    }];
    
    [altController addAction:action];
    [altController addAction:xiangCe];
    [altController addAction:quxiao];
    

}





#pragma mark --调用系统相册（小站的）
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    if (number==10) {
        [_xiaoZhanArray removeAllObjects];
        KitchenTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        cell.imagebgView.hidden=NO;
        [cell.addBtn setBackgroundImage:image forState:0];
        [_xiaoZhanArray addObject:image];
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        [_xiangCeArray addObject:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self photoArray:_xiangCeArray];
    }
    
    
    //[LCProgressHUD showLoading:@"正在上传头像..."];
    //CGSize size =CGSizeMake(image.size.width,image.size.height );
   // NSData *imgData=[XYString imageWithImage:image scaledToSize:size];
   // [self shangChuanImage:imgData];
    
}


/*******************/

#pragma mark --手机相机
-(void)phoneXiangJi{
    if (_xiangCeArray.count<4) {
        // 先判断相机是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 把imagePicker.sourceType改为相机
            UIImagePickerController * imagePicker=[[UIImagePickerController alloc]init];
            imagePicker.delegate =self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else
        {
            [LCProgressHUD showFailure:@"相机不可用"];
        }
        
    }else{
        NSLog(@"超过4个了");
        [LCProgressHUD showFailure:@"最大限制4个"];
        // [WINDOW showHUDWithText:@"最大数4个" Type:ShowPhotoNo Enabled:YES];
    }
    
    
}

#pragma mark --调用相册（证件）
-(void)diaoYongXiangCe{
    
    //就只需要这2步即可完成照片多选操作
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    picker.maxCount = 4-_xiangCeArray.count;
    [picker setDidFinishSelectImages:^(NSMutableArray *images)
     {
         for (int i =0; i<images.count; i++) {
             [_xiangCeArray addObject:images[i]];
         }
         [self photoArray:_xiangCeArray];
     }];
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)photoArray:(NSMutableArray*)array{
    KitchenTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    
    for (UIButton * butn in _FangArray) {
        [butn removeFromSuperview];
    }
    [_FangArray removeAllObjects];
    NSLog(@"数组个数%lu",array.count);
    for (int i = 0; i<array.count; i++)
    {
        UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        gester.view.tag=i;
        UIButton * imageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [imageBtn setBackgroundImage:_xiangCeArray[i] forState:0];
        [imageBtn addTarget:self action:@selector(tapGesture:) forControlEvents:UIControlEventTouchUpInside];
        imageBtn.frame=CGRectMake((60+10)*i, 0, 60, 60);
        [cell.imagebgView addSubview:imageBtn];
        imageBtn.tag=i;
        //如果数组中相片的个数是最后一个
        if (i==_xiangCeArray.count-1)
        {//就改动AddBtn的坐标像右边移动
            [cell.imagebgView addSubview:cell.addBtn];
            cell.addBtn.frame=CGRectMake(70*(i+1), 0, 60, 60);
        }
        //如果i=3及数组中个数是4个的话
        if (i==3) {
            cell.addBtn.hidden=YES;
        }
        [_FangArray addObject:imageBtn];
        [imageBtn addGestureRecognizer:gester];
    }
    
}

#pragma mark --长按图片添加删除按钮
-(void)longPress:(UIGestureRecognizer*)gester
{
    //NSLog(@"%lu",gester.view.tag);
    if (gester.state == UIGestureRecognizerStateBegan)
    {
        UIButton *btn = (UIButton *)gester.view;
        btn.userInteractionEnabled=YES;
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.bounds = CGRectMake(0, 0, 20, 20);
        // dele.backgroundColor=[UIColor greenColor];
        [dele setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        dele.tag=gester.view.tag;
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [dele setBackgroundImage:[UIImage imageNamed:@"delete(2)"] forState:0];
        dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width+8, -8, dele.frame.size.width, dele.frame.size.height);
        
        [btn addSubview:dele];
        [self start : btn];
        
        
    }
    
}

#pragma mark --长按开始抖动
- (void)start : (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [btn.layer addAnimation:anim forKey:@"shake"];
}

#pragma mark --删除图片
-(void)deletePic:(UIButton*)btnn{
    
    UIButton * btn =(UIButton *)[btnn superview];
    KitchenTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    [btn removeFromSuperview];
    [_xiangCeArray removeObjectAtIndex:btn.tag];
    [_FangArray removeObject:btn];
    for (int i =0; i<_FangArray.count; i++) {
        UIButton * imageBtn =_FangArray[i];
        imageBtn.tag=i;
        cell.addBtn.hidden=NO;
        imageBtn.frame=CGRectMake((60+10)*i, 0, 60, 60);
        [imageBtn addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [cell.imagebgView addSubview:imageBtn];
        if (i==_FangArray.count-1)
        {//就改动AddBtn的坐标像右边移动
            [cell.imagebgView addSubview:cell.addBtn];
            cell.addBtn.frame=CGRectMake(70*(i+1), 0, 60, 60);
        }
    }
    if (_FangArray.count==0) {
        [_xiangCeArray removeAllObjects];
        [_FangArray removeAllObjects];
        cell.addBtn.frame=CGRectMake(0, 0, 60, 60);
    }
    
    
}










#pragma mark --短按图片停止抖动
-(void)tapGesture:(UIButton *)btn
{
    [self deleClose:btn];
    
}
#pragma mark-- 删除"删除按钮"
- (BOOL)deleClose:(UIButton *)btn
{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
    
    return NO;
}

#pragma mark --停止抖动
- (void)stop:(UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tableView endEditing:YES];
}

#pragma mark --联系客服
-(void)keFuBtn{
    ContactKeFuViewController * vc =[ ContactKeFuViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
