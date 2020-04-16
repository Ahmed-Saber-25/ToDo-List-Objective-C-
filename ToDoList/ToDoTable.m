//
//  ToDoTable.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/22/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "ToDoTable.h"
#import "AddView.h"
#import "ToDoTask.h"
#import "TaskInfo.h"
#import "EditView.h"

@interface ToDoTable ()
@property (strong, nonatomic) IBOutlet UISearchBar *search;

@end

@implementation ToDoTable{
    UIAlertView *deleteAllAlert ;
    UIAlertView *toDODelete ;
    NSMutableArray *todo;
    NSMutableArray *inprog;
    NSMutableArray *done;
    NSMutableArray *filtered;
    AddView *VC;
    TaskInfo *info;
    EditView *taskEdit;
    ToDoTask *initial;
    NSMutableArray *archieve;
    int editedTaskIndex;
    int num ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    filtered = [NSMutableArray new];
    todo = [NSMutableArray new];
    inprog = [NSMutableArray new];
    done = [NSMutableArray new];
    initial = [ToDoTask new];
    initial.taskName =@"initial";
    VC =[self.storyboard instantiateViewControllerWithIdentifier:@"VC"];
    info =[self.storyboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
    taskEdit =[self.storyboard instantiateViewControllerWithIdentifier:@"editView"];
    [VC setP:self];
    [taskEdit setEditP:self];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if([[def objectForKey:@"a"] count] != 0){
        NSMutableArray *retrieved = [def objectForKey:@"a"];
        for (int i =0 ; i<[[def objectForKey:@"a"]count]; i++) {
            [todo addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[retrieved objectAtIndex:i]]];
        }
    }
    else{
         [todo addObject:initial];
    }
    filtered =todo;
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    filtered = todo;
    [_tasksTable reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[filtered objectAtIndex:indexPath.row] taskName];
    cell.accessoryType= UITableViewCellAccessoryDetailButton;
   if([[[filtered objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"High"]){
        printf("highhhhhhhhhh");
       cell.imageView.image =[UIImage imageNamed:@"1.png"] ;
    }
    else if([[[filtered objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"Medium"]){
        cell.imageView.image =[UIImage imageNamed:@"2.png"] ;
    }
    else  {
        cell.imageView.image =[UIImage imageNamed:@"3.png"] ;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filtered count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"ToDo List";
    return header;
}
- (IBAction)addBtnPressed:(id)sender {
    [self.navigationController pushViewController:VC animated:YES];
}
-(void) addTask:(ToDoTask*)task{
    
    [todo addObject:task];
    filtered = todo;
    [_tasksTable reloadData];
    
    
}

-(void) editTask:(ToDoTask*)task{
    [todo replaceObjectAtIndex:editedTaskIndex withObject:task];

}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *result = [formatter stringFromDate:[[todo objectAtIndex:indexPath.row] taskReminder]];

    info.nameStr = [[todo objectAtIndex:indexPath.row] taskName];
    info.descStr = [[todo objectAtIndex:indexPath.row] taskDesc];
    info.reminderStr =result;
    info.priorityStr =[[todo objectAtIndex:indexPath.row] taskPriority];
    info.conditionStr=[[todo objectAtIndex:indexPath.row] taskCondition];
    [self.navigationController pushViewController:info animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   toDODelete  = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@"This Activity Will Be Deleted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel",nil];
    num = indexPath.row;
  [toDODelete show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(toDODelete)
    {
    switch (buttonIndex) {
        case 0:
            [todo removeObjectAtIndex:num];
            [self.tasksTable reloadData];
            break;
            
        default:
            break;
    }
        
    }else if (deleteAllAlert)
    {
        switch (buttonIndex) {
            case 0:
        [todo removeAllObjects];
        [inprog removeAllObjects];
        [done removeAllObjects];
        [_tasksTable reloadData];
                break;
                
            default:
                break;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    editedTaskIndex = indexPath.row;
    taskEdit.tsName = [[todo objectAtIndex:indexPath.row] taskName];
    taskEdit.tsDesc = [[todo objectAtIndex:indexPath.row] taskDesc];
    taskEdit.tsReminder =[[todo objectAtIndex:indexPath.row] taskReminder];
    taskEdit.tsPriority =[[todo objectAtIndex:indexPath.row] taskPriority];
    taskEdit.tsCondition=[[todo objectAtIndex:indexPath.row] taskCondition];
    [self.navigationController pushViewController:taskEdit animated:YES];
}
    
- (void) viewWillDisappear:(BOOL)animated {
    archieve = [[NSMutableArray alloc]initWithCapacity:[todo count]];
    NSData *encodedObject=[NSData new];
    for(int i=0 ; i<[todo count];i++)
    {
        encodedObject  = [NSKeyedArchiver archivedDataWithRootObject:[todo objectAtIndex:i]] ;
        [archieve addObject:encodedObject];
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:archieve forKey:@"a"];
    
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if (searchText.length == 0) {
        filtered =todo;
        [self.search endEditing:YES];

    }

    else {
        filtered =[NSMutableArray new];
        for (int i=0 ; i<[todo count];i++) {

            NSRange range = [[[todo objectAtIndex:i] taskName] rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {

                [filtered addObject:[todo objectAtIndex:i]];

            }
        }

    }

    [_tasksTable reloadData];

}

- (IBAction)deleteAll:(id)sender {
    deleteAllAlert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@"ALL DATA WILL BE DELETED!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel",nil];
    [deleteAllAlert  show];
}




@end
