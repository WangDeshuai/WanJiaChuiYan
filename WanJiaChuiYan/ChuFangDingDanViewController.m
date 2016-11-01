//
//  ChuFangDingDanViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChuFangDingDanViewController.h"
#import "XiaoZhanFenOrderVC.h"
#import "CaiPinFenViewController.h"

@interface ChuFangDingDanViewController ()<SGTopTitleViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation ChuFangDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
   // [self.navigationItem setTitle:@"厨房订单"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
     self.title=@"厨房订单";
    // Do any additional setup after loading the view.
    [self leftBtn];
    // 1.添加所有子控制器
    [self setupChildViewController];
    self.titles = @[@"按小站分",@"按菜品分"];
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0,ScreenWidth, 44)];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    XiaoZhanFenOrderVC *oneVC = [[XiaoZhanFenOrderVC alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
    

    
}
//// 添加所有子控制器
- (void)setupChildViewController {
    // 未领取
    XiaoZhanFenOrderVC *oneVC = [[XiaoZhanFenOrderVC alloc] init];
    [self addChildViewController:oneVC];
    
    // 领取
    CaiPinFenViewController *twoVC = [[CaiPinFenViewController alloc] init];
    [self addChildViewController:twoVC];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    
}
// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}








//-(void)ShuJu
//{
//    _dataArray=[NSMutableArray new];
//    ChuFangOrderModel * model =[[ChuFangOrderModel alloc]init];
//    model.phoneNumber=@"联系电话：15032735032";
//    model.titleName=@"取餐点 广安大厦安桥商务";
//    model.date=@"2016-08-22";
//    model.fenshu=@"共150份";
//    model.payNumber=@"实付¥25.00";
//    model.imageview=@"head_pic";
//    [_dataArray addObject:model];
//}
//
//-(void)CreatView1{
//    _view1 =[UIView new];
//    _view1.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
//    [self.view sd_addSubviews:@[_view1]];
//    _view1.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .topSpaceToView(self.view,5)
//    .heightIs(80);
//    
//    UIButton * leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.tag=1;
//    leftBtn.backgroundColor=[UIColor clearColor];
//    leftBtn.titleLabel.alpha=.6;
//    [leftBtn setTitleColor:[UIColor blackColor] forState:0];
//    [leftBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
//    [leftBtn addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    [leftBtn setTitle:@"按小站分" forState:0];
//    leftBtn.selected=YES;
//    lastBtn=leftBtn;
//    [_view1 sd_addSubviews:@[leftBtn]];
//    
//    
//    
//    
//    
//    UIButton * rigthBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    rigthBtn.tag=2;
//    rigthBtn.backgroundColor=[UIColor clearColor];
//    [rigthBtn setTitleColor:[UIColor blackColor] forState:0];
//    [rigthBtn setTitle:@"按菜品分" forState:0];
//    [rigthBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
//    rigthBtn.titleLabel.alpha=.6;
//    [rigthBtn addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
//    rigthBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    [_view1 sd_addSubviews:@[rigthBtn]];
//    
//    leftBtn.sd_layout
//    .leftSpaceToView(_view1,0)
//    .topSpaceToView(_view1,0)
//    .heightIs(30)
//    .widthRatioToView(_view1,.5);
//  
//    rigthBtn.sd_layout
//    .rightSpaceToView(_view1,0)
//    .topEqualToView(leftBtn)
//    .heightRatioToView(leftBtn,1)
//    .widthRatioToView(leftBtn,1);
//    
//    UILabel * timeLable =[UILabel new];
//    timeLable.text=@"订单日期";
//    timeLable.font=[UIFont systemFontOfSize:15];
//    timeLable.alpha=.7;
//    timeLable.textAlignment=1;
//    [_view1 sd_addSubviews:@[timeLable]];
//    timeLable.sd_layout
//    .leftSpaceToView(_view1,15)
//    .topSpaceToView(leftBtn,10)
//    .bottomSpaceToView(_view1,0);
//    [timeLable setSingleLineAutoResizeWithMaxWidth:100];
//    
//    UILabel * dateLable =[UILabel new];
//    dateLable.text=@"2016-08-22";
//    dateLable.font=[UIFont systemFontOfSize:15];
//    dateLable.alpha=.5;
//    dateLable.textAlignment=0;
//    [_view1 sd_addSubviews:@[dateLable]];
//    dateLable.sd_layout
//    .leftSpaceToView(timeLable,15)
//    .topEqualToView(timeLable)
//    .bottomSpaceToView(_view1,0);
//    [dateLable setSingleLineAutoResizeWithMaxWidth:100];
//    
//    linView =[[UIView alloc]init];
//    linView.frame=CGRectMake(ScreenWidth/4-40, 30, 80, 2);
//    linView.backgroundColor=[UIColor greenColor];
//    [_view1 addSubview:linView];
//    
//    
//    
//}
//-(void)topBtn:(UIButton*)btn{
//    
//    lastBtn.selected=!lastBtn.selected;
//    btn.selected=!btn.selected;
//    lastBtn=btn;
//    if (btn.tag==1) {
//        [UIView animateWithDuration:.5 animations:^{
//            linView.frame=CGRectMake(ScreenWidth/4-40, 30, 80, 2);
//        }];
//    }else{
//        [UIView animateWithDuration:.5 animations:^{
//            linView.frame=CGRectMake(ScreenWidth/4*3-40, 30, 80, 2);
//        }];
//    }
//    tagg=(int)btn.tag;
//    [_tableView reloadData];
//    
//    
//}
//-(void)CreatTableView{
//    if (!_tableView) {
//        _tableView=[[UITableView alloc]init];
//    }
//    _tableView.frame=CGRectMake(0, 85, ScreenWidth, ScreenHeight-64);
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    _tableView.tableFooterView=[[UIView alloc]init];
//    _tableView.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:_tableView];
//    
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//   
//    return _dataArray.count;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
//    if (tagg==1) {
//        ChuFangDingDanTableViewCell * cell =[ChuFangDingDanTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
//        cell.model=_dataArray[indexPath.row];
//         return cell;
//    }else{
//        ChuFangOrderTableViewCell * cell =[ChuFangOrderTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
//        cell.textLabel.text=@"按照菜品来分的";
//        return cell;
//    }
//    
//   
//    
//   // return cell;
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//   
//    ChuFangOrderModel * md =_dataArray[indexPath.row];
//   // return ;
//    NSLog(@">>>%f",[_tableView cellHeightForIndexPath:indexPath model:md keyPath:@"model" cellClass:[ChuFangDingDanTableViewCell class] contentViewWidth:[self  cellContentViewWith]]);
//    return 250;
//}
//- (CGFloat)cellContentViewWith
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    
//    // 适配ios7
//    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//        width = [UIScreen mainScreen].bounds.size.height;
//    }
//    return width;
//}
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
