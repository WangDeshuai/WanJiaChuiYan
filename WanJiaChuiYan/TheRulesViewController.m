//
//  TheRulesViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/7.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TheRulesViewController.h"
#import "TheRulesTableViewCell.h"
@interface TheRulesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSArray * titleArr;
@property(nonatomic,retain)NSArray *contentArr;
@end

@implementation TheRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
   
    self.tabbarView.hidden=YES;
    UIImageView * imageview =[[UIImageView alloc]init];//WithImage:];
    imageview.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
   
//_number是倒叙 倒着来的
    if (_number==3) {
         self.title=@"介绍";
      
        imageview.image=[UIImage imageNamed:@"intr_bg"];
    }else if (_number==2){
       imageview.backgroundColor=[UIColor whiteColor];
         self.title=@"申请规则";
    }else{
          [self CreatImageView:imageview];
         imageview.image=[UIImage imageNamed:@"intr_bg"];
         self.title=@"我的午餐";
    }
   [self.view addSubview:imageview];
    // Do any additional setup after loading the view.
    [self leftBtn];
    
    [self numberData];
    [self CreatTableView];
//
}

-(void)numberData{
  
    if (_number==1) {
         _titleArr=@[@"方便：",@"安全",@"便宜",@"参与"];
        _contentArr=@[@"我们把午餐做成了一瓶矿泉水那样方便您在便利店就可以去买、去卖。",
                      @"拒绝无证合作，接受相关职能部门监督，合作户必须提供相关有效证件，通过我们严格的安全审核、技术矫正。",
                      @"不影响菜品含金量。如果一份饭专为你做为你而送，我们是便宜不起的，但是我们发挥合作商户闲置时间增加经济效益，没有增加新的硬件投入，那么这件事就很有意义了。",
                      @"每次吃饭后您都可以在“我的订单”内进行评论，只要参与都会得到粮票，感谢您为我们改善菜品做出贡献。",];
                      
    }else if(_number==2){
        _titleArr=@[@"1.两个要素",@"2.钱那点事 ",@"3.地点要求",@"4.协助建站"];
        
        _contentArr=@[@"建立炊烟小站必须同时满足地点和午餐时间有人来收发。",
                      @"小站是有偿服务，费用由平台支付。",
                      @"为了自己取餐方便在某个楼层发起，也可以是你自愿来做这份兼职在办公室发起，也可以是便利店长期做代理业务增加客流量和经济收入而发起。",
                      @"您也可以点击“申请中”小站发现有您附近的取餐点投赞成票，一人一天一次投票权，促成这个炊烟小站尽快建成，方便你下次取餐。后台审核会参考票数（15票以上）作为通过条件之一。",
                      ];
    }else{
        _titleArr=@[@"1.logo寓意",@"2.关于我们",@"3.我们的目标"];
        _contentArr=@[@"向上箭头寓意我们的团队天天向上、事业蒸蒸日上；碗寓意食，碗大到能装下屋子，是对民以食为天最好的配图说明，我们原创这个logo就是向您承诺，您吃得放心满意，对于我们来说就是天大的事！",
                      @"颠覆传统外卖模式，并且只有午餐，所以更专注于让大家各种（性价比、口味、安全）满意。",
                      @"让您像买一瓶矿泉水那样方便的去买性价比高的午餐。",
                    ];
        
    }
    
    
}


-(void)CreatImageView:(UIImageView*)bgImage{
    
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"huanying"];
    [bgImage sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .centerXEqualToView(bgImage)
    .topSpaceToView(bgImage,ScreenHeight/4*3)
    .widthIs(357/2)
    .heightIs(34/2);
    
}



#pragma mark -- 表的创建CreatTableView
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (_number==3) {
         _tableView.backgroundColor=[UIColor clearColor];
    }else{
         _tableView.backgroundColor=[UIColor clearColor];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
#pragma mark --tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}
#pragma mark --tableViewDataSoure
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯
    TheRulesTableViewCell * cell =[TheRulesTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    if (_number==3) {
        cell.number=indexPath.row+1;
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.titleLabel.text=_titleArr[indexPath.row];
    cell.name=_contentArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString * str =_contentArr[indexPath.row];
  
   
    
    return [XYString HeightForText:str withSizeOfLabelFont:14 withWidthOfContent:ScreenWidth-45]+30+20+10;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
