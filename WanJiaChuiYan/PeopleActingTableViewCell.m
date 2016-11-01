//
//  PeopleActingTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PeopleActingTableViewCell.h"
@interface PeopleActingTableViewCell()
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UILabel * phoneLabel;

@end
@implementation PeopleActingTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    PeopleActingTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[PeopleActingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.alpha=.7;
    _nameLabel.textAlignment=1;
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    
    _phoneLabel=[UILabel new];
    _phoneLabel=[UILabel new];
    _phoneLabel.font=[UIFont systemFontOfSize:15];
    _phoneLabel.alpha=.7;
    _phoneLabel.textAlignment=1;
    [self.contentView sd_addSubviews:@[_phoneLabel]];
    _phoneLabel.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [_phoneLabel setSingleLineAutoResizeWithMaxWidth:100];

    
    _switchbtn=[[UISwitch alloc]init];
    //设置ON一边的背景颜色，默认是绿色
//   _switchbtn.onTintColor=[UIColor yellowColor];
//    //设置OFF一边的背景颜色，默认是灰色，发现OFF背景颜色其实也是控件”边框“颜色
//    _switchbtn.tintColor=[UIColor purpleColor];
    //设置滑块颜色
   // _switchbtn.thumbTintColor=[UIColor greenColor];
    //设置成开启病设置动画形式出现，当然也可以直接用[swi1 setOn:YES];
    _switchbtn.frame=CGRectMake(ScreenWidth-15-45, 15, 45, 21);
    _switchbtn.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [_switchbtn setOn:NO animated:YES];
    [self.contentView addSubview:_switchbtn];

    
}
-(void)setModel:(PeopleDaiLingModel *)model
{
    _model=model;
    _nameLabel.text=model.name;
    _phoneLabel.text=model.account;
    if (model.isSwitch==YES) {
        [_switchbtn setOn:YES animated:YES];
    }else{
        [_switchbtn setOn:NO animated:YES];
    }
}

-(void)setModel2:(FuZhanZhangModel *)model2
{
    _model2=model2;
    
    _nameLabel.text=model2.name;
    _phoneLabel.text=model2.phoneNumber;
    if (model2.isSwitch==YES) {
       [_switchbtn setOn:YES animated:YES];
    }else{
         [_switchbtn setOn:NO animated:YES];
    }
    
    
    
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
