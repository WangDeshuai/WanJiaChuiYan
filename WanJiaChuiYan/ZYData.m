//
//  ZYData.m
//  WanJiaChuiYan
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ZYData.h"

@implementation ZYData
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TheMenu.sqlite"];
    NSLog(@"%@",path);
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil]) {
        _context = [[NSManagedObjectContext alloc]init];
        [_context setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }else{
        abort();
    }
    
    
}
//向表中插入一条新数据
//插入数据
- (void)insertPeopleWithName:(NSString *)name1 Name2:(NSString *)name2 Name3:(NSString *)name3 Price1:(NSString*)pric1 Price2:(NSString*)pric2 Price3:(NSString*)pric3 FenShu:(NSString*)fenshu MenID:(NSString*)menuid MenID1:(NSString*)caiId1 MenID2:(NSString*)caiId2 MenID3:(NSString*)caiID3 {
    
    The_Menu *p = [NSEntityDescription insertNewObjectForEntityForName:@"The_Menu" inManagedObjectContext:_context];

    p.name1=name1;
    p.name2=name2;
    p.name3=name3;
    p.price1=pric1;
    p.price2=pric2;
    p.price3=pric3;
    p.fenShu=fenshu;
    p.menuId=menuid;
    p.menID1=caiId1;
    p.menID2=caiId2;
    p.menID3=caiID3;
    NSError *error = nil;
   
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"The_Menu" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}


//更新
-(void)updateWithPeople:(The_Menu *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(The_Menu *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
//根据套餐ID去查询菜品,有这种菜返回YES，没有返回NO
-(BOOL)searchTaoCanID:(NSString*)taoCanID{
    NSArray * ar =[self searchAllPeople];
    for (The_Menu * p in ar)
    {
        if ([p.menuId isEqualToString:taoCanID])
        {
            NSLog(@"是统一种菜");
            return YES;
        }
    }
    return NO;
}

//根据套餐ID查出份数来 ，然后去修改
-(The_Menu*)taoCanIDsearchFenShu:(NSString*)taoCanID{
    NSArray * ar =[self searchAllPeople];
    NSMutableArray * fenShu=[NSMutableArray new];
    for (The_Menu * p in ar){
       
        if ([p.menuId isEqualToString:taoCanID]) {
            [fenShu addObject:p];
        }
    }
    The_Menu * pp =fenShu[0];
    return pp;
}


-(NSMutableArray * )quiteAllMenName{
   NSMutableArray * array =[NSMutableArray new];
   NSArray * arr= [self searchAllPeople];
    for (The_Menu * men in arr)
    {
        [array addObject:men.name1];
        [array addObject:men.name2];
        [array addObject:men.name3];
    }
    
     NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        
        NSString *string = array[i];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:string];
        
        for (int j = i+1; j < array.count; j ++) {
            
            NSString *jstring = array[j];
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:jstring];
                
                [array removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [dateMutablearray addObject:tempArray];
        
    }
    
    return dateMutablearray;
    
}

////根据菜的名字在所有菜中查询，看看有没有相同的，相同添加到数组中
//-(NSMutableArray*)searchMenuName:(NSString*)menuname {
//    NSMutableArray * array =[NSMutableArray new];
//    NSArray * aray =[self searchAllPeople];
//    for (The_Menu * menu in aray) {
//        if ([menu.name1 isEqualToString:menuname]) {
//            [array addObject:menu.name1];
//        }
//    }
//    return array;
//}
//
//-(NSMutableArray*)searchMenuName2:(NSString*)menuname {
//    NSMutableArray * array =[NSMutableArray new];
//    NSArray * aray =[self searchAllPeople];
//    for (The_Menu * menu in aray) {
//        if ([menu.name2 isEqualToString:menuname]) {
//            [array addObject:menu.name1];
//        }
//    }
//    return array;
//}
//-(NSMutableArray*)searchMenuName3:(NSString*)menuname {
//    NSMutableArray * array =[NSMutableArray new];
//    NSArray * aray =[self searchAllPeople];
//    for (The_Menu * menu in aray) {
//        if ([menu.name3 isEqualToString:menuname]) {
//            [array addObject:menu.name1];
//        }
//    }
//    return array;
//}


//查找主表
//-(NSMutableArray*)LookTableViewLeft{
//    NSArray * ar =[self searchAllPeople];
//    NSMutableArray * array=[NSMutableArray new];
//    for (HYPeople * p in ar) {
//        if (p.name1) {
//            NSLog(@"p有值可以添加");
//            [array addObject:p];
//            
//        }
//    }
//    return array;
//}
//-(NSMutableArray*)genJuPid:(NSString*)pid{
//    NSArray * arr =[self searchAllPeople];
//    NSMutableArray * array=[NSMutableArray new];
//    for (int i = 0; i<arr.count; i++)
//    {
//        HYPeople * p = arr[i];
//        if ([p.name2 isEqualToString:pid])
//        {
//            [array addObject:p];
//            NSLog(@"我查出行业来了，并且加进去了");
//        }
//    }
//    
//    return array;
//}

@end
