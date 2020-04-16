//
//  AddView.h
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "ToDoTask.h"
#import "ToDoTable.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddView : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate , MyProtocol >{
    NSMutableArray *prioritylist;
    NSMutableArray *conditionlist;
}
@property id <MyProtocol> P;
@end

NS_ASSUME_NONNULL_END
