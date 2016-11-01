//
//  TodayBusineTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TodayBusineTableViewCell.h"

@implementation TodayBusineTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    TodayBusineTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[TodayBusineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        //self.backgroundColor=[UIColor whiteColor];
        //[self CreatStar];
        [self setArray];
    }
    return self;
}
-(void)CreatStar{
//    _nameLable=[[UILabel alloc]init];
//    _nameLable.font=[UIFont systemFontOfSize:15];
//    _nameLable.alpha=.7;
//    [self.contentView sd_addSubviews:@[_nameLable]];
//    _nameLable.sd_layout
//    .leftSpaceToView(self.contentView,15)
//    .topSpaceToView(self.contentView,20)
//    .heightIs(20);
//    [_nameLable setSingleLineAutoResizeWithMaxWidth:100];
    
//    _swich=[[UISwitch alloc]init];
//    _swich.transform = CGAffineTransformMakeScale(0.75, 0.75);
//   // [_swich setOn:NO animated:YES];
//  //  [self.contentView sd_addSubviews:@[_swich]];
//    _swich.sd_layout
//    .rightSpaceToView(self.contentView,10)
//    .centerYEqualToView(_nameLable);
    
//    _shuLiang=[[UILabel alloc]init];
//    _textfiled=[[UITextField alloc]init];
//    _fenShu=[[UILabel alloc]init];
//    [self.contentView sd_addSubviews:@[_shuLiang,_textfiled,_fenShu]];
//    _shuLiang.backgroundColor=[UIColor redColor];
//    _shuLiang.alpha=.5;
//    _shuLiang.font=[UIFont systemFontOfSize:14];
//    
//    _fenShu.backgroundColor=[UIColor greenColor];
//    _fenShu.alpha=.5;
//    _fenShu.font=[UIFont systemFontOfSize:14];
//    
//    
//    _textfiled.keyboardType=UIKeyboardTypeNumberPad;
//    _textfiled.backgroundColor=[UIColor whiteColor];
//    _textfiled.textAlignment=1;
//    _textfiled.alpha=.6;
//    _textfiled.font=[UIFont systemFontOfSize:14];
//    
//    _shuLiang.sd_layout
//    .topSpaceToView(_nameLable,30)
//    .leftSpaceToView(self.contentView,30)
//    .heightIs(15);
//    [_shuLiang setSingleLineAutoResizeWithMaxWidth:50];
//    
//    _textfiled.sd_layout
//    .leftSpaceToView(_shuLiang,10)
//    .centerYEqualToView(_shuLiang)
//    .widthIs(60)
//    .heightIs(30);
//    
//    _fenShu.sd_layout
//    .leftSpaceToView(_textfiled,10)
//    .centerYEqualToView(_textfiled)
//    .heightIs(15);
//    [_fenShu setSingleLineAutoResizeWithMaxWidth:30];

    
   
}

-(void)setArray{
//    _shuLiang=[[UILabel alloc]init];
//    _textfiled=[[UITextField alloc]init];
//    _fenShu=[[UILabel alloc]init];
//    [self.contentView sd_addSubviews:@[_shuLiang,_textfiled,_fenShu]];
//   // _shuLiang.backgroundColor=[UIColor redColor];
//    _shuLiang.alpha=.5;
//    _shuLiang.font=[UIFont systemFontOfSize:14];
//    
//  //  _fenShu.backgroundColor=[UIColor greenColor];
//    _fenShu.alpha=.5;
//    _fenShu.font=[UIFont systemFontOfSize:14];
//    
//    
//    _shuLiang.text=@"数量";
//    _fenShu.text=@"份";
//    
//    _textfiled.keyboardType=UIKeyboardTypeNumberPad;
//    _textfiled.backgroundColor=[UIColor whiteColor];
//    _textfiled.textAlignment=1;
//    _textfiled.alpha=.6;
//    _textfiled.font=[UIFont systemFontOfSize:14];
//    
//    _shuLiang.sd_layout
//    .leftSpaceToView(self.contentView,30)
//    .centerYEqualToView(self.contentView)
//    .heightIs(15);
//    [_shuLiang setSingleLineAutoResizeWithMaxWidth:50];
//    
//    _textfiled.sd_layout
//    .leftSpaceToView(_shuLiang,10)
//    .centerYEqualToView(_shuLiang)
//    .widthIs(60)
//    .heightIs(30);
//    
//    _fenShu.sd_layout
//    .leftSpaceToView(_textfiled,10)
//    .centerYEqualToView(_textfiled)
//    .heightIs(15);
//    [_fenShu setSingleLineAutoResizeWithMaxWidth:30];
//    
}



-(void)setModel:(TodatModel *)model
{
//    _model=model;
//    _nameLable.text=model.name;
//    _shuLiang.text=model.shuliang;
//    _fenShu.text=model.fenshu;
//    
//    if (model.isopen==YES) {
//            [_swich setOn:YES animated:YES];
//                _textfiled.hidden=NO;
//                _fenShu.hidden=NO;
//               _shuLiang.hidden=NO;
//                _textfiled.text=model.number;
//            }else{
//                [_swich setOn:NO animated:YES];
//                _textfiled.hidden=YES;
//                _fenShu.hidden=YES;
//                _shuLiang.hidden=YES;
//            }
    
    
//    if (_shuLiang.hidden==YES) {
//        NSLog(@"隐藏的");
//        [self setupAutoHeightWithBottomView:_nameLable bottomMargin:20];
//    }else{
//        NSLog(@"显示的");
//        [self setupAutoHeightWithBottomView:_shuLiang bottomMargin:10];
//    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
