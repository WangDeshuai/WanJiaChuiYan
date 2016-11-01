//
//  OrderTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "OrderTableViewCell.h"
@interface OrderTableViewCell()
//@property(nonatomic,retain)UIButton * imageLeft;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UIImageView * image1;//定位图标
@property(nonatomic,retain)UIImageView * image2;//更换图标
@property(nonatomic,retain)UILabel * label1;//定位地点
@property(nonatomic,retain)UILabel * label2;//点击更换取餐点
@property(nonatomic,retain)UILabel * distance;//距离


@end
@implementation OrderTableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView{
    OrderTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
       
      //  self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initStar];
        
    }
    
    
    return self;
}
#pragma mark -- 初始化参数
-(void)initStar{
    _imageLeft=[UIButton new];
    _nameLabel=[UILabel new];
    _image1=[UIImageView new];
    _image2=[UIImageView new];
    _label1=[UILabel new];
    _label2=[UILabel new];
    _distance=[UILabel new];
    _changeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _label1.font=[UIFont systemFontOfSize:14];
    _distance.font=[UIFont systemFontOfSize:15];
    _label2.font=[UIFont systemFontOfSize:14];
    _label1.alpha=.8;
    _label2.alpha=.6;
    //固定值
    // _imageLeft.image=[UIImage imageNamed:@"pic1"];
    _image1.image=[UIImage imageNamed:@"adress"];
    // _distance.text=@"1.0km";
    // _label1.text=@"广安大街安侨商务";
     _image2.image=[UIImage imageNamed:@"shop"];
     _label2.text=@"点击可更换为取餐点";
    [_changeBtn setBackgroundImage:[UIImage imageNamed:@"change_button"] forState:0];
    
    
    [self.contentView sd_addSubviews:@[_imageLeft,_nameLabel,_image1,_image2,_label1,_label2,_distance,_changeBtn]];
    [self framCreat];
}
#pragma mark --创建坐标
-(void)framCreat{
    UIView * bgView =self.contentView;
    //leftImage
    _imageLeft.sd_layout
    .leftSpaceToView(bgView,10)
    .topSpaceToView(bgView,10)
    .bottomSpaceToView(bgView,10)
    .widthIs(80);
    //距离
    _distance.sd_layout
    .rightSpaceToView(bgView,5)
    .centerYEqualToView(_nameLabel)
    .heightIs(15);
    [_distance setSingleLineAutoResizeWithMaxWidth:70];
    
    //titleName
    _nameLabel.sd_layout
    .leftSpaceToView(_imageLeft,15)
    .topEqualToView(_imageLeft)
    .heightIs(20)
    .rightSpaceToView(_distance,3);
    //image1(定位)
    _image1.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,10)
    .widthIs(26/2)
    .heightIs(34/2);
    //label1
    _label1.sd_layout
    .leftSpaceToView(_image1,5)
    .topEqualToView(_image1)
    .heightRatioToView(_image1,1)
    .rightSpaceToView(bgView,5);
    //image2（更换）
    _image2.sd_layout
    .leftEqualToView(_image1)
    .topSpaceToView(_image1,10)
    .widthIs(26/2)
    .heightIs(24/2);
    //立即更换
    _changeBtn.sd_layout
    .rightEqualToView(_distance)
    .centerYEqualToView(_image2)
    .widthIs(133/2)
    .heightIs(40/2);
    
    
    //label2
    _label2.sd_layout
    .leftSpaceToView(_image2,5)
    .topEqualToView(_image2)
    .heightRatioToView(_image2,1)
    .rightSpaceToView(_changeBtn,5);
   
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(OrderTableViewModel *)model
{
    _model=model;

   // [_imageLeft setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    [_imageLeft setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"icon1"]];
    
    _nameLabel.text=model.name;
    _label1.text=model.diZhi;
    _distance.text=model.juLi;
//    int distance;
//    int juLi =[model.juLi intValue];
//    if (juLi>=1000) {
//       distance=juLi/1000;
//        _distance.text=[NSString stringWithFormat:@"%dkm",distance];
//    }else{
//       distance=juLi;
//        _distance.text=[NSString stringWithFormat:@"%dm",distance];
//    }
}
#pragma mark -- 重新cell frame
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
@end
