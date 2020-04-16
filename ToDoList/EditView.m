//
//  EditView.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/23/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "EditView.h"

@interface EditView ()

@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextField *editPriority;
@property (weak, nonatomic) IBOutlet UITextField *editCondition;
@property (weak, nonatomic) IBOutlet UITextView *editDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *editReminder;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *conditionPicker;


@end

@implementation EditView{
    UIAlertView *alert;
    ToDoTask *editedTask;
    ToDoTable *taskTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
}
- (void)viewWillAppear:(BOOL)animated{
    editedTask = [ToDoTask new];
    taskTable =[self.storyboard instantiateViewControllerWithIdentifier:@"ToDoTable"];
    _editName.text = _tsName;
    _editPriority.text = _tsPriority;
    _editDesc.text = _tsDesc;
    _editCondition.text = _tsCondition;
    
}
- (void)viewDidAppear:(BOOL)animated{
  
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        editedTask.taskName = _editName.text;
        editedTask.taskDesc = _editDesc.text;
        editedTask.taskPriority = _editPriority.text;
        editedTask.taskCondition = _editCondition.text;
        editedTask.taskReminder = _editReminder.date;
        [_editP editTask:editedTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveEditing:(id)sender {
    alert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@"data will change" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Save",@"Cancel",nil];
    [alert show];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger *numOfSections = 0 ;
    switch (pickerView.tag) {
        case 0:
            numOfSections = 1  ;
            break;
        case 1:
            numOfSections = 1  ;
            break;
    }
    return numOfSections ;
    
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
            _editPriority.text = prioritylist[row] ;
            break;
        case 1:
            _editCondition.text = conditionlist[row] ; ;
            break;
    }
    
}
@end
