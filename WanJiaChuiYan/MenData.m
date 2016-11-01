//
//  MenData.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MenData.h"

@implementation MenData
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TheMenuTwo.sqlite"];
    NSLog(@"TheMenuTwo>%@",path);
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil]) {
        _context = [[NSManagedObjectContext alloc]init];
        [_context setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }else{
        abort();
    }
    
    
}
//插入数据
- (void)insertPeopleWithName:(NSString *)nameTwo menu:(NSString*)price menid:(NSString*)menID CaiId:(NSString*)caiID XuHao:(NSString*)xuhao QiTa:(NSString*)other{
    
    TheMenuTwo *p = [NSEntityDescription insertNewObjectForEntityForName:@"TheMenuTwo" inManagedObjectContext:_context];
    p.menName=nameTwo;
    p.menID=menID;
    p.menPrice=price;
    p.caiID=caiID;
    p.xuhao=xuhao;
    p.other=other;
    NSError *error = nil;
    
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"TheMenuTwo" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}


//更新
-(void)updateWithPeople:(TheMenuTwo *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(TheMenuTwo *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
//查询所有菜名
-(NSMutableArray*)allMenName
{
    NSArray * Menarr=[self searchAllPeople];
    NSMutableArray *array=[NSMutableArray new];
    for (TheMenuTwo * men in Menarr) {
        [array addObject:men.menName];
    }
    
  /*
    把所有的菜名排序，相同的放到一个数组，在相同的放到另一个数组
    然后统一在放到一个大数组中NSMutableArray * array =[[NSMutableAaary alloc]initWith:array1,array2];
   */
   
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++)
    {
        
        NSString *string = array[i];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:string];
        
        for (int j = i+1; j < array.count; j ++)
        {
            
            NSString *jstring = array[j];
            if([string isEqualToString:jstring])
            {
                [tempArray addObject:jstring];
                
                [array removeObjectAtIndex:j];
                j -= 1;
                
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    //NSLog(@"dateMutable:%@",dateMutablearray);
    
    return dateMutablearray;
}
//根据套餐ID去移除
-(void)delegateTaoCanID:(NSString*)menIdD{
    
    NSArray * allArr =[self searchAllPeople];
    for (TheMenuTwo * men  in allArr) {
        //NSLog(@">>%@",men.menID);
        //NSLog(@"看看%@",menIdD);
        if ([menIdD isEqualToString:men.menID])
        {
           [self deleteWithPeople:men];
           // NSLog(@"删了吗");
        }
    }
    
}

//根据名字去查询相应的价格
-(NSString*)searNameWithMenuName:(NSString*)menuName{
    NSString*  price ;
    NSArray * array =[self searchAllPeople];
    for (TheMenuTwo * menu in array) {
        
        if ([menuName isEqualToString:menu.menName]) {
            price=menu.menPrice ;
        }
    }
    
    return price;
}


//根据菜名去查询ID
-(NSString*)caiNameWithMenuNam:(NSString*)caiMing{
    
    NSString * idd;
    NSArray * array =[self searchAllPeople];
    for (TheMenuTwo * menu in array) {
        
        if ([caiMing isEqualToString:menu.menName]) {
            idd=menu.caiID;
        }
    }
    
    
    return idd;
}

@end
