//
//  ToApplyForModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ToApplyForModel.h"

@implementation ToApplyForModel
-(id)initWithReviewDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {

        NSString * jili =[self stringid:[dic objectForKey:@"distance"]];
        int ju =[jili intValue];
        if (ju>1000) {
            _distance=[NSString stringWithFormat:@"%dkm",ju/1000];
        }else{
            _distance=[NSString stringWithFormat:@"%dm",ju];
        }
        _idd=[self stringid:[dic objectForKey:@"id"]];
        _account=[self stringid:[dic objectForKey:@"master_account"]];
        _address=[self stringid:[dic objectForKey:@"addr"]];
        _phoneNumber=[self stringid:[dic objectForKey:@"connect_tel"]];
        NSString * str =[self stringid:[dic objectForKey:@"selfPraised"]];
        if ([str isEqualToString:@"1"]) {
            _isMyself=YES;
        }else{
            _isMyself=NO;
        }
        _selfPraised=str;
        
        
        
        _praiseNumber=[self stringid:[dic objectForKey:@"praise_number"]];
        _headImage=[self stringid:[dic objectForKey:@"station_image"]];
        _titleName=[self stringid:[dic objectForKey:@"name"]];
        
        

    }
    
    return self;
}
-(NSString*)stringid:(id)str
{
    NSString * strr =[NSString stringWithFormat:@"%@",str];
    NSString * string;
    if (strr==nil) {
        string=@"";
    }else{
        string=strr;
    }
    
    return string;
    
}
@end
