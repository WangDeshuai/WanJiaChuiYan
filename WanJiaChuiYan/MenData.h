//
//  MenData.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheMenuTwo.h"
@interface MenData : NSObject
{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    TheMenuTwo * _dao;

}
//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)nameTwo menu:(NSString*)price menid:(NSString*)menID CaiId:(NSString*)caiID XuHao:(NSString*)xuhao QiTa:(NSString*)other;
//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(TheMenuTwo *)people;
//删除数据
- (void)deleteWithPeople:(TheMenuTwo *)p;

//查询所有菜名
-(NSMutableArray*)allMenName;

//根据套餐ID去移除
-(void)delegateTaoCanID:(NSString*)menID;

//根据名字去查询相应的价格
-(NSString*)searNameWithMenuName:(NSString*)menuName;

//根据菜名去查询ID
-(NSString*)caiNameWithMenuNam:(NSString*)caiMing;


@end
