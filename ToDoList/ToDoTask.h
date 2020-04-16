//
//  ToDoTask.h
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTask : NSObject<NSCoding>

@property NSString *taskName , *taskPriority , *taskDesc , *taskCondition,*savedEventId;
@property NSDate *taskReminder;

@end

NS_ASSUME_NONNULL_END
