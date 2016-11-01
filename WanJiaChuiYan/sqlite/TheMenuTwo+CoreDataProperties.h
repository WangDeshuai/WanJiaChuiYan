//
//  TheMenuTwo+CoreDataProperties.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TheMenuTwo.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheMenuTwo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *menID;
@property (nullable, nonatomic, retain) NSString *menName;
@property (nullable, nonatomic, retain) NSString *menPrice;
@property (nullable, nonatomic, retain) NSString *caiID;
@property (nullable, nonatomic, retain) NSString *xuhao;
@property (nullable, nonatomic, retain) NSString *other;

@end

NS_ASSUME_NONNULL_END
