//
//  AddView.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "AddView.h"


@interface AddView ()
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UILabel *priorityChosen;

@property (weak, nonatomic) IBOutlet UIPickerView *conditionPicker;
@property (weak, nonatomic) IBOutlet UILabel *conditionChosen;

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextView *taskDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
@end

@implementation AddView{
    ToDoTask *addedTask;
    NSMutableArray *todoArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    prioritylist =[NSMutableArray new];
    [prioritylist addObject:@"High"];
    [prioritylist addObject:@"Medium"];
    [prioritylist addObject:@"Low"];
    
    conditionlist =[NSMutableArray new];
    [conditionlist addObject:@"ToDo"];
    [conditionlist addObject:@"InProgress"];
    [conditionlist addObject:@"Done"];
    
    [_priorityPicker setDelegate:self] ;
    [_priorityPicker setDataSource:self] ;
    
    [_conditionPicker setDelegate:self] ;
    [_conditionPicker setDataSource:self] ;
    
    todoArray =[NSMutableArray new];
}
- (void)viewWillAppear:(BOOL)animated{
    
    addedTask =[ToDoTask new];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
 
    return 1 ;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger *numOfRows = 0 ;
    switch (pickerView.tag) {
        case 0:
            numOfRows = [prioritylist count]  ;
            break;
        case 1:
            numOfRows = [conditionlist count]  ;
            break;
    }
    return numOfRows ;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowData ;
    switch (pickerView.tag) {
        case 0:
            rowData = prioritylist[row] ;
            break;
        case 1:
            rowData = conditionlist[row] ; ;
            break;
    }
    return rowData ;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 0:
            _priorityChosen.text = prioritylist[row] ;
            break;
        case 1:
            _conditionChosen.text = conditionlist[row] ; ;
            break;
    }
    
}
- (IBAction)addTask:(id)sender {
    addedTask.taskName = _taskName.text;
    addedTask.taskDesc = _taskDesc.text;
    addedTask.taskPriority = _priorityChosen.text;
    addedTask.taskCondition = _conditionChosen.text;
    addedTask.taskReminder = _taskDate.date;
    _taskName.text = @"";
    _taskDesc.text =@"";
    _priorityChosen.text = @"" ;
    _conditionChosen.text = @"" ;
    [_P addTask:addedTask];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
