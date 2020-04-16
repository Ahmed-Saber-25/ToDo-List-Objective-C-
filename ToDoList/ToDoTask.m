//
//  ToDoTask.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "ToDoTask.h"

@implementation ToDoTask
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.taskName forKey:@"name"];
    [encoder encodeObject:self.taskDesc forKey:@"desc"];
    [encoder encodeObject:self.taskPriority forKey:@"priority"];
    [encoder encodeObject:self.taskReminder forKey:@"reminder"];
    [encoder encodeObject:self.taskCondition forKey:@"condition"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.taskName = [decoder decodeObjectForKey:@"name"];
        self.taskDesc = [decoder decodeObjectForKey:@"desc"];
        self.taskPriority = [decoder decodeObjectForKey:@"priority"];
        self.taskReminder = [decoder decodeObjectForKey:@"reminder"];
        self.taskCondition = [decoder decodeObjectForKey:@"condition"];
       
        
    }
    return self;
}
@end
