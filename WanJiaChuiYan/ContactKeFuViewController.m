//
//  ContactKeFuViewController.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ContactKeFuViewController.h"

@interface ContactKeFuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * array;
@end

@implementation ContactKeFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabbarView.hidden=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
   // [self.navigationItem setTitle:@"联系客服"];
     self.title=@"联系客服";
    [self leftBtn];
    // Do any additional setup after loading the view.
    _dataArray=[[NSMutableArray alloc]initWithObjects:@"点击进入",@"联系电话", nil];
    _array=[[NSMutableArray alloc]initWithObjects:@"http://www.hbwjcy.com",@"4006781797", nil];
    [self CreatTableView];
}
#pragma mark --创建表格
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.tableFooterView=[[UIView alloc]init];
    _tableView.scrollEnabled=NO;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.tableHeaderView=[self headTableView];
    _tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50);
    [self.view addSubview:_tableView];
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        UILabel * nameLable =[UILabel new];
        nameLable.tag=10;
        [cell sd_addSubviews:@[nameLable]];
        nameLable.sd_layout
        .rightSpaceToView(cell,15)
        .centerYEqualToView(cell)
        .heightIs(50);
        [nameLable setSingleLineAutoResizeWithMaxWidth:300];
       
    }
    UILabel * nameLable =(UILabel *)[cell viewWithTag:10];
   
    
        UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        nameLable.userInteractionEnabled=YES;
          [nameLable addGestureRecognizer:touch];
    
    
    cell.textLabel.font=[UIFont systemFontOfSize:17];
    cell.textLabel.alpha=.7;
    nameLable.font=[UIFont systemFontOfSize:17];
    nameLable.alpha=.7;
    cell.textLabel.text=_dataArray[indexPath.row];
    nameLable.text=_array[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
    
    return cell;
}

-(void)handleTap:(UILongPressGestureRecognizer*) recognizer

{
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self becomeFirstResponder];
            UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UILabel * nameLable =(UILabel *)[cell viewWithTag:10];
            
            UIMenuItem *copyLink =[[UIMenuItem alloc] initWithTitle:@"复制"
                                                             action:@selector(copy:)];
            
            [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:copyLink]];
            
            [[UIMenuController sharedMenuController] setTargetRect:nameLable.frame inView:nameLable.superview];
            [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }

    
    
    
   
   
    
}

//  复制时执行的方法
-(void)copy:(id)sender

{
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel * nameLable =(UILabel *)[cell viewWithTag:10];
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = nameLable.text;
    
}
//如果想弹出menuController 必须重写
- (BOOL)canBecomeFirstResponder{
    return YES;
}
-(UIView*)headTableView{
    
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor clearColor];
    view.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(200);
    
    UIImageView  * logoImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"link_logo"]];
    [view sd_addSubviews:@[logoImage]];
    logoImage.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(view,30)
    .widthIs(142/2)
    .heightIs(142/2);
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"万家炊烟v1.0";
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.6;
    [view sd_addSubviews:@[nameLabel]];
    
    nameLabel.sd_layout
    .centerXEqualToView(logoImage)
    .topSpaceToView(logoImage,10)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        NSString * allString =_array[0];//[NSString stringWithFormat:@"http://www.baidu.com/"];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }else{
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认拨打电话" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:actionView animated:YES completion:nil];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [ToolClass tellPhone:_array[1]];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [actionView addAction:action1];
        [actionView addAction:action2];
       
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 55;
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
