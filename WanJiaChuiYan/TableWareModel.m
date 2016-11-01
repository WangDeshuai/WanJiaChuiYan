//
//  TableWareModel.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TableWareModel.h"

@implementation TableWareModel
-(id)initWithCanJuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _addTime=[XYString IsNotNull:[dic objectForKey:@"addtime"]];
        _account=[XYString IsNotNull:[dic objectForKey:@"account"]];
        _money=[XYString IsNotNull:[dic objectForKey:@"total_money"]];
        _headUrl=[XYString IsNotNull:[dic objectForKey:@"tableware_imgurl"]];
        _subject=[XYString IsNotNull:[dic objectForKey:@"subject"]];
        _bianHao=[XYString IsNotNull:[dic objectForKey:@"out_trade_no"]];
        _isFafang=[XYString IsNotNull:[NSString stringWithFormat:@"%@",[dic objectForKey:@"send_status"]]];
        
    }
    
    
    return self;
}
@end
