//
//  ToDoTable.h
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDoTable : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;

@end

NS_ASSUME_NONNULL_END
