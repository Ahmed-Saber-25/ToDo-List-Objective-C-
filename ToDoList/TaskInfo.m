//
//  TaskInfo.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "TaskInfo.h"

@interface TaskInfo ()
@property (weak, nonatomic) IBOutlet UILabel *nameInfo;
@property (weak, nonatomic) IBOutlet UILabel *priorityInfo;
@property (weak, nonatomic) IBOutlet UILabel *conditionInfo;
@property (weak, nonatomic) IBOutlet UILabel *reminderInfo;
@property (weak, nonatomic) IBOutlet UITextView *descInfo;

@end

@implementation TaskInfo


- (void)viewWillAppear:(BOOL)animated{
    _nameInfo.text = _nameStr;
    _priorityInfo.text=_priorityStr;
    _conditionInfo.text = _conditionStr;
    _reminderInfo.text=_reminderStr;
    _descInfo.text = _descStr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
