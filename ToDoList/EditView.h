//
//  EditView.h
//  ToDoList
//
//  Created by Ahmed Saber on 12/23/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "ToDoTable.h"
#import "ToDoTask.h"

@interface EditView : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate ,MyProtocol>{
    
    NSMutableArray *prioritylist;
    NSMutableArray *conditionlist;
}

@property NSString *tsName , *tsDesc , *tsCondition , *tsPriority;
@property NSData *tsReminder;
@property id <MyProtocol> editP;

@end
