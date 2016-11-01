//
//  The_Menu.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface The_Menu : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSString *fenShu;
@property (nullable, nonatomic, retain) NSString *kitchenId;
@property (nullable, nonatomic, retain) NSString *menuId;
@property (nullable, nonatomic, retain) NSString *name1;
@property (nullable, nonatomic, retain) NSString *name2;
@property (nullable, nonatomic, retain) NSString *name3;
@property (nullable, nonatomic, retain) NSString *price1;
@property (nullable, nonatomic, retain) NSString *price2;
@property (nullable, nonatomic, retain) NSString *price3;
@property (nullable, nonatomic, retain) NSString *menID1;
@property (nullable, nonatomic, retain) NSString *menID2;
@property (nullable, nonatomic, retain) NSString *menID3;
@end

NS_ASSUME_NONNULL_END

#import "The_Menu+CoreDataProperties.h"
