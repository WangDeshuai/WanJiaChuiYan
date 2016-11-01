//
//  YeJiTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/10/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YeJiTableViewCell.h"
@interface YeJiTableViewCell()
@property(nonatomic,retain)UILabel * timeLable;
@property(nonatomic,retain)UIView * view0;

@end
@implementation YeJiTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID indexp:(NSIndexPath*)indepaxth{
    YeJiTableViewCell * cell =[tableView cellForRowAtIndexPath:indepaxth];
    if (!cell) {
        cell=[[YeJiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    _timeLable=[UILabel new];
    _view0=[UIView new];
    _totleLable=[UILabel new];
    _taoCanShu=[UILabel new];
    [self.contentView sd_addSubviews:@[_timeLable,_view0,_totleLable,_taoCanShu]];
    
    _timeLable.font=[UIFont systemFontOfSize:16];
    _timeLable.alpha=.7;
    
    _totleLable.font=[UIFont systemFontOfSize:15];
    _totleLable.alpha=.7;
    
    _taoCanShu.font=[UIFont systemFontOfSize:15];
    _taoCanShu.alpha=.7;
    _taoCanShu.hidden=YES;
   // _view0.backgroundColor=[UIColor redColor];
    
    _timeLable.sd_layout
    .leftSpaceToView(self.contentView,15)
    .heightIs(20)
    .topSpaceToView(self.contentView,15);
    [_timeLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _view0.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_timeLable,10)
    .heightIs(100);
    
    _totleLable.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_view0,10)
    .heightIs(20);
    [_totleLable setSingleLineAutoResizeWithMaxWidth:300];
    
    _taoCanShu.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_view0,10)
    .heightIs(20);
    [_taoCanShu setSingleLineAutoResizeWithMaxWidth:300];

    
    
    [self setupAutoHeightWithBottomView:_totleLable bottomMargin:10];
    
}

-(void)setModel:(YeJiModel *)model{
    _model=model;
    _timeLable.text=model.time;
    _totleLable.text=[NSString stringWithFormat:@"总计%@份",model.totleFenShu];
    _taoCanShu.text=[NSString stringWithFormat:@"总计%@份/%@套",model.totleFenShu,model.taoCanShu];
    NSLog(@"输出%@",model.taoCanShu);
    for (int i = 0; i<model.menuArr.count; i++)
    {
        NSDictionary * dic =model.menuArr[i];
        UILabel * nameLable =[UILabel new];
        UILabel * fenShu =[UILabel new];
        nameLable.alpha=.6;
        fenShu.alpha=.6;
        nameLable.font=[UIFont systemFontOfSize:14];
        fenShu.font=[UIFont systemFontOfSize:14];
        nameLable.text=[dic objectForKey:@"menu_name"];
        fenShu.text=[NSString stringWithFormat:@"%@份",[dic objectForKey:@"number"]];
        [_view0 sd_addSubviews:@[nameLable,fenShu]];
        
        nameLable.sd_layout
        .leftSpaceToView(_view0,15)
        .heightIs(20)
        .topSpaceToView(_view0,0+(20+5)*i);
        [nameLable setSingleLineAutoResizeWithMaxWidth:300];
        
        fenShu.sd_layout
        .rightSpaceToView(_view0,15)
        .heightIs(20)
        .topSpaceToView(_view0,0+(20+5)*i);
        [fenShu setSingleLineAutoResizeWithMaxWidth:300];
        
        
        
        _view0.sd_layout.heightIs((21+5)*i+15);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
