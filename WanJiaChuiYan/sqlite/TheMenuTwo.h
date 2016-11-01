//
//  TheMenuTwo.h
//  WanJiaChuiYan
//
//  Created by Macx on 16/9/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheMenuTwo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSString *menID;
@property (nullable, nonatomic, retain) NSString *menName;
@property (nullable, nonatomic, retain) NSString *menPrice;
@property (nullable, nonatomic, retain) NSString *caiID;
@property (nullable, nonatomic, retain) NSString *xuhao;
@property (nullable, nonatomic, retain) NSString *other;
@end

NS_ASSUME_NONNULL_END

#import "TheMenuTwo+CoreDataProperties.h"
