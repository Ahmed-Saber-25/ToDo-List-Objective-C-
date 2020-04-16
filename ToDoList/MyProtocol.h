//
//  MyProtocol.h
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoTask.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
-(void) addTask:(ToDoTask*)task;
-(void) editTask:(ToDoTask*)task;

@end

NS_ASSUME_NONNULL_END
