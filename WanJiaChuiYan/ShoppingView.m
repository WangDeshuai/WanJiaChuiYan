//
//  ShoppingView.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShoppingView.h"
#import "ShoppingTableViewCell.h"
@interface ShoppingView()<UITableViewDelegate,UITableViewDataSource>
{
    ZYData * dao;
    UILabel * manyPrice;
    MenData * menDao;
}
@property(nonatomic,retain)UIImageView * headView;
@property(nonatomic,retain)UIImageView * endView;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end
@implementation ShoppingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self getDataMySqlite];
        [self CreatheadView];
        [self CreatEndView];
        [self CreatTableView];
        [self bringSubviewToFront:_endView];
    }
    return self;
}

#pragma mark --从数据库中读取数据
-(void)getDataMySqlite{
    _dataArray=[NSMutableArray new];
     dao =[[ZYData alloc]init];
    [dao connectSqlite];
    NSArray * array =[dao searchAllPeople];
    for (The_Menu * men in array) {
        [_dataArray addObject:men];
    }
    
    NSEnumerator *enumerator = [_dataArray reverseObjectEnumerator];
    _dataArray =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    menDao =[[MenData alloc]init];
    [menDao connectSqlite];
}





#pragma mark --创建抬头图片
-(void)CreatheadView{
    _headView =[UIImageView new];
    _headView.userInteractionEnabled=YES;
    _headView.image=[UIImage imageNamed:@"bus_gouwuche"];
    [self sd_addSubviews:@[_headView]];
    _headView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .heightIs(ScreenWidth*97/750);
//    //竖线
//    UIImageView * lineImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bus-line"]];
//     [_headView sd_addSubviews:@[lineImage]];
//    lineImage.sd_layout
//    .leftSpaceToView(_headView,10)
//    .centerYEqualToView(_headView)
//    .widthIs(5)
//    .heightIs(20);
//    //字体购物车
//    UILabel * nameLable =[UILabel new];
//    nameLable.text=@"购物车";
//    nameLable.font=[UIFont systemFontOfSize:15];
//    nameLable.alpha=.7;
//    [_headView sd_addSubviews:@[nameLable]];
//    nameLable.sd_layout
//    .topSpaceToView(_headView,0)
//    .bottomSpaceToView(_headView,0)
//    .leftSpaceToView(lineImage,0);
//    [nameLable setSingleLineAutoResizeWithMaxWidth:120];
    //清空
    UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"bus_delete"] forState:0];
    [deleteBtn addTarget:self action:@selector(jiesuan:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag=1;
    [_headView sd_addSubviews:@[deleteBtn]];
    deleteBtn.sd_layout
    .rightSpaceToView(_headView,0)
    .topSpaceToView(_headView,0)
    .bottomSpaceToView(_headView,0)
    .widthIs(70);
  
    
}
#pragma mark --创建中间的表
-(void)CreatTableView{
    _tableView=[[UITableView alloc]init];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(_headView,0)
    .bottomSpaceToView(_endView,-10);
    
}


#pragma mark --创建最下面图片
-(void)CreatEndView{
    _endView =[UIImageView new];
    _endView.userInteractionEnabled=YES;
    _endView.image=[UIImage imageNamed:@"gouwuche_jiesuan"];
    [self sd_addSubviews:@[_endView]];
    _endView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .heightIs(ScreenWidth*10/75);
   
    //购物小车
    UIButton * gouWuChe=[UIButton buttonWithType:UIButtonTypeCustom];
    [gouWuChe setBackgroundImage:[UIImage imageNamed:@"bus_button"] forState:0];
    gouWuChe.adjustsImageWhenHighlighted=NO;
    [_endView sd_addSubviews:@[gouWuChe]];
    gouWuChe.sd_layout
    .leftSpaceToView(_endView,10)
    .bottomSpaceToView(_endView,5)
    .widthIs(64)
    .heightIs(64);
    //显示数量的小不点
    UIButton * xiaoDian=[UIButton buttonWithType:UIButtonTypeCustom];
    [xiaoDian setBackgroundImage:[UIImage imageNamed:@"dafan_samll_button"] forState:0];
    xiaoDian.adjustsImageWhenHighlighted=NO;
    [gouWuChe sd_addSubviews:@[xiaoDian]];
    xiaoDian.sd_layout
    .rightSpaceToView(gouWuChe,0)
    .topSpaceToView(gouWuChe,0)
    .widthIs(18)
    .heightIs(18);
    
    
    
    
    //去结算按钮
    UIButton * jieSuanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    jieSuanBtn.tag=2;
    jieSuanBtn.backgroundColor=[UIColor clearColor];
    [jieSuanBtn addTarget:self action:@selector(jiesuan:) forControlEvents:UIControlEventTouchUpInside];
    [_endView sd_addSubviews:@[jieSuanBtn]];
    jieSuanBtn.sd_layout
    .rightSpaceToView(_endView,0)
    .topSpaceToView(_endView,10)
    .bottomSpaceToView(_endView,0)
    .widthIs(100);
    
    
    //价格label
    manyPrice=[UILabel new];
    [self jiaGe];//自动计算价格
    manyPrice.textAlignment=1;
    manyPrice.font=[UIFont systemFontOfSize:18];
    [_endView sd_addSubviews:@[manyPrice]];
    manyPrice.sd_layout
    .leftSpaceToView(gouWuChe,15)
    .centerYEqualToView(_endView)
    .heightIs(30);
    [manyPrice setSingleLineAutoResizeWithMaxWidth:100];
}


#pragma mark --tableViewDelegate tableViewDataSoce
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯

    ShoppingTableViewCell * cell =[ShoppingTableViewCell cellWithTableView:tableView CellID:CellIdentifier];
    
    [cell.addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag=indexPath.row;
    [cell.subtractBtn addTarget:self action:@selector(subtractBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.subtractBtn.tag=indexPath.row;
    The_Menu * men =_dataArray[indexPath.row];
    cell.numberLable.text=men.fenShu;
    cell.menuName1.text=men.name1;
    cell.menuName2.text=men.name2;
    cell.menuName3.text=men.name3;
    /*
        隐藏了价格,购物车当中的价格
     */
    
//    cell.price1.text=[NSString stringWithFormat:@"¥%@",men.price1];
//    cell.price2.text=[NSString stringWithFormat:@"¥%@",men.price2];
//    cell.price3.text=[NSString stringWithFormat:@"¥%@",men.price3];
    //过滤购物车中的布点
    if ([men.name3 isEqualToString:@"不点"]) {
        cell.menuName3.hidden=YES;
        cell.price3.hidden=YES;
    }
    
    

    
   return cell;
}
#pragma mark --加号
-(void)add:(UIButton*)addBtn{
    The_Menu * men =_dataArray[addBtn.tag];
    men.fenShu=[NSString stringWithFormat:@"%d",[men.fenShu intValue]+1];
    [_dataArray replaceObjectAtIndex:addBtn.tag withObject:men];
    [_tableView reloadData];
    [self upDataMySqliteFenShu:men];
    [self jiaGe];
    //点击加号的同时第二个数据库也增加
    /*
     men.menuId 和men.fenShu 是从第一个表中取出来的，
     men.fenShu是自加1的，和btn.tag一样
     */
    NSString * menID =[NSString stringWithFormat:@"%@-%@",men.menuId,men.fenShu];
   [menDao insertPeopleWithName:men.name1 menu:men.price1 menid:menID CaiId:men.menID1 XuHao:@"" QiTa:@""];
    [menDao insertPeopleWithName:men.name2 menu:men.price2 menid:menID CaiId:men.menID2 XuHao:@"" QiTa:@""];
    [menDao insertPeopleWithName:men.name3 menu:men.price3 menid:menID CaiId:men.menID3 XuHao:@"" QiTa:@""];
    
    
 
}
#pragma mark --减号
-(void)subtractBtn:(UIButton*)subBtn{
    
   The_Menu * men =_dataArray[subBtn.tag];
   men.fenShu=[NSString stringWithFormat:@"%d",[men.fenShu intValue]-1];
   [_dataArray replaceObjectAtIndex:subBtn.tag withObject:men];
    [self upDataMySqliteFenShu:men];
    [self jiaGe];
    if ([men.fenShu intValue]==0) {
       /*
        1.在第二个表中，根据套餐ID去移除第二个表中的数据这个
        men.menuId是指没有点击加号时的menID也就是33-27-26，
        这种的3位数的ID;
        2.在从数组中移除;
        3.在根据men从第一个数据库中删除数据;
        
        */
        [menDao delegateTaoCanID:men.menuId];
        [_dataArray removeObject:men];
        [dao deleteWithPeople:men];
        
    }
    [_tableView reloadData];
    /*
     1.这是点击了加号之后从数据库中删除的，此时menID是33-27-26-2
       4位数字组合
     2.从第二个数据中也删除
     */
     NSString * menID =[NSString stringWithFormat:@"%@-%d",men.menuId,[men.fenShu intValue]+1];
    [menDao delegateTaoCanID:menID];
  

    
}

#pragma mark --自动计算价格
-(void)jiaGe{
    NSMutableArray * zongArray=[NSMutableArray new];
    NSArray * arr =[dao searchAllPeople];
    NSEnumerator *enumerator = [arr reverseObjectEnumerator];
    arr =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    for (The_Menu * men  in arr) {
//        int a= [men.price1 intValue]+[men.price2 intValue]+[men.price3 intValue];
//       
//        int b=a*[men.fenShu intValue];
//        NSString * bb =[NSString stringWithFormat:@"%d",b];
//
        NSString * price =decimalNumberMutiplyWithString(men.price1, men.price2,men.price3,men.fenShu);
        [zongArray addObject:price];
        NSLog(@"每一个的价格%@",price);
        
    }
  NSNumber * sum = [zongArray valueForKeyPath:@"@sum.floatValue"];
  manyPrice.text=[NSString stringWithFormat:@"¥%@元",sum];//@"¥0元";
}
#pragma mark --加法乘法计算
NSString *decimalNumberMutiplyWithString(NSString *price1,NSString *price2,NSString*price3,NSString *fenshu)
{
    NSDecimalNumber *price11 = [NSDecimalNumber decimalNumberWithString:price1];
    NSDecimalNumber *price22 = [NSDecimalNumber decimalNumberWithString:price2];
    NSDecimalNumber *price33 = [NSDecimalNumber decimalNumberWithString:price3];
    NSDecimalNumber *fenShu = [NSDecimalNumber decimalNumberWithString:fenshu];
 
    //加
    NSDecimalNumber *product2 = [price11 decimalNumberByAdding:price22];
    NSDecimalNumber *product3 = [product2 decimalNumberByAdding:price33];

    //乘
    NSDecimalNumber *product = [product3 decimalNumberByMultiplyingBy:fenShu];
    
    //减
  //  NSDecimalNumber *product3 = [multiplicandNumber decimalNumberBySubtracting:multiplierNumber];
    //除
  //  NSDecimalNumber *product4 = [multiplicandNumber decimalNumberByDividingBy:multiplierNumber];
   
    
    
    return [product stringValue];
}







#pragma mark --修改数据库中的份数
-(void)upDataMySqliteFenShu:(The_Menu*)men{
    The_Menu * p=[dao taoCanIDsearchFenShu:men.menuId];
    p.fenShu=men.fenShu;//要修改的值
    [dao updateWithPeople:p];
}



#pragma mark --侧滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSEnumerator *enumerator = [_dataArray reverseObjectEnumerator];
    //_dataArray =[[NSMutableArray alloc]initWithArray: [enumerator allObjects]];
    The_Menu * men =_dataArray[indexPath.row];
    NSLog(@"输出id=%@",men.menuId);
    NSString * menID =[NSString stringWithFormat:@"%@-%@",men.menuId,men.fenShu];
    //从第二个数据中也删除1
    [menDao delegateTaoCanID:men.menuId];
    //从第二个数据中也删除2
   
    [menDao delegateTaoCanID:menID];
     //从第一个数据中也删除
    [dao deleteWithPeople:men];
    [_dataArray removeObject:men];
    [self jiaGe];
    [_tableView reloadData];
}

#pragma mark --行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    The_Menu * men =_dataArray[indexPath.row];
    if ([men.name3 isEqualToString:@"不点"]) {
      
        return 60;
    }
    return 90;
}










#pragma mark --结算 点击删除
-(void)jiesuan:(UIButton*)button{
    NSArray * array =[dao searchAllPeople];
    if(button.tag==1){
        for (The_Menu * menu in array) {
            [dao deleteWithPeople:menu];
        }
        [_dataArray removeAllObjects];
        _dataArray =nil;
        manyPrice.text=@"¥0元";
        [_tableView reloadData];
        //把第二个表也删除
        for (TheMenuTwo * menuTwo in [menDao searchAllPeople]) {
            [menDao deleteWithPeople:menuTwo];
        }
        
        
        
    }
    
    if ([_delegate respondsToSelector:@selector(clickedButtonAtIndex:)]) {
        [_delegate clickedButtonAtIndex:button.tag];
    }
}

@end
