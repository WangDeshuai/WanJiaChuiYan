//
//  ZYData.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "The_Menu.h"
@interface ZYData : NSObject
{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    The_Menu * _dao;
}

//连接数据库
-(void)connectSqlite;
//插入数据
- (void)insertPeopleWithName:(NSString *)name1 Name2:(NSString *)name2 Name3:(NSString *)name3 Price1:(NSString*)pric1 Price2:(NSString*)pric2 Price3:(NSString*)pric3 FenShu:(NSString*)fenshu MenID:(NSString*)menuid MenID1:(NSString*)caiId1 MenID2:(NSString*)caiId2 MenID3:(NSString*)caiID3;
//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(The_Menu *)people;
//删除数据
- (void)deleteWithPeople:(The_Menu *)p;

//根据套餐ID去查询有没有这种菜(如果有则份数+1,如果没有则存储)
-(BOOL)searchTaoCanID:(NSString*)taoCanID;

//根据套餐ID去查询份数
-(NSString*)searchFenShuWithTaoCanID:(NSString*)taoCanID;




//根据套餐ID查出份数来 ，然后去修改
-(The_Menu*)taoCanIDsearchFenShu:(NSString*)taoCanID;
-(NSMutableArray * )quiteAllMenName;
////根据菜的名字在所有菜中查询，看看有没有相同的，相同添加到数组中
//-(NSMutableArray*)searchMenuName:(NSString*)menuname;
//-(NSMutableArray*)searchMenuName2:(NSString*)menuname;
//-(NSMutableArray*)searchMenuName3:(NSString*)menuname;
@end
