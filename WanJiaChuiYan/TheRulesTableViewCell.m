//
//  TheRulesTableViewCell.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/7.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TheRulesTableViewCell.h"

@implementation TheRulesTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    TheRulesTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[TheRulesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStra];
    }
    return self;
}
-(void)CreatStra{
    _titleLabel=[UILabel new];
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.alpha=.8;
    
    _contentLabel=[UILabel new];
    _contentLabel.font=[UIFont systemFontOfSize:14];
    _contentLabel.textColor=[UIColor blackColor];
    _contentLabel.alpha=.6;
    _contentLabel.numberOfLines=0;
    [self.contentView sd_addSubviews:@[_titleLabel,_contentLabel]];
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView,30)
    .topSpaceToView(_titleLabel,10)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    [self.contentView setupAutoHeightWithBottomView:_contentLabel bottomMargin:10];
    
    
    
}
-(void)setName:(NSString *)name
{
    _name=name;
    if (_number==1) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:name];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,4)];
        [_contentLabel setAttributedText:[self attrStrFrom:name numberStr:@"碗" num:@"向上箭头"]];
    }else{
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        UIColor *color = [UIColor blackColor];
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:name attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
        _contentLabel.attributedText = string;
        _contentLabel.isAttributedContent = YES;
    }
    
    
   
}
-(NSMutableAttributedString *)attrStrFrom:(NSString *)titleStr numberStr:(NSString *)numberStr num:(NSString*)numberstr;
{
    NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:titleStr];
    // 设置前面几个字串的格式:红色 16.0f字号
    [arrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                               NSForegroundColorAttributeName:[UIColor redColor]
                               }
                       range:[titleStr rangeOfString:numberStr]];
    [arrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                               NSForegroundColorAttributeName:[UIColor redColor]
                               }
                       range:[titleStr rangeOfString:numberstr]];
    return arrString;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
