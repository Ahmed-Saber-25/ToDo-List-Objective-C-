//
//  DoneVC.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/24/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "DoneVC.h"

@interface DoneVC ()
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

@implementation DoneVC{
    NSMutableArray *allTasks;
    NSMutableArray *doneTasks;
    TaskInfo *info;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    allTasks = [NSMutableArray new];
    doneTasks = [NSMutableArray new];
    info = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if([[def objectForKey:@"a"] count] != 0){
        NSMutableArray *retrieved = [def objectForKey:@"a"];
        for (int i =0 ; i<[[def objectForKey:@"a"]count]; i++) {
            [allTasks addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[retrieved objectAtIndex:i]]];
        }
    }
    for (int i =0 ; i<[allTasks count]; i++) {
        if ([[[allTasks objectAtIndex:i] taskCondition ]isEqualToString:@"Done"]) {
            [doneTasks addObject:[allTasks objectAtIndex:i]];
        }
    }
    [_doneTable reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated{
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneCell" forIndexPath:indexPath];
    cell.textLabel.text = [[doneTasks objectAtIndex:indexPath.row] taskName];
    cell.accessoryType= UITableViewCellAccessoryDetailButton;
    if([[[doneTasks objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"High"]){
        cell.imageView.image =[UIImage imageNamed:@"1.png"] ;
    }
    else if([[[doneTasks objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"Medium"]){
        cell.imageView.image =[UIImage imageNamed:@"2.png"] ;
    }
    else  {
        cell.imageView.image =[UIImage imageNamed:@"3.png"] ;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [doneTasks count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"Done Tasks";
    return header;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *result = [formatter stringFromDate:[[doneTasks objectAtIndex:indexPath.row] taskReminder]];
    
    info.nameStr = [[doneTasks objectAtIndex:indexPath.row] taskName];
    info.descStr = [[doneTasks objectAtIndex:indexPath.row] taskDesc];
    info.reminderStr =result;
    info.priorityStr =[[doneTasks objectAtIndex:indexPath.row] taskPriority];
    info.conditionStr=[[doneTasks objectAtIndex:indexPath.row] taskCondition];
    [self.navigationController pushViewController:info animated:YES];
}



@end
