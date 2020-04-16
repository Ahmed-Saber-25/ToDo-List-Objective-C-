//
//  PriorityVC.m
//  ToDoList
//
//  Created by Ahmed Saber on 12/24/19.
//  Copyright © 2019 ahmedsaber. All rights reserved.
//

#import "PriorityVC.h"

@interface PriorityVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;

@property (weak, nonatomic) IBOutlet UITableView *sortedTable;

@end

@implementation PriorityVC{
    NSMutableArray *priorityarray;
    NSMutableArray *allTasks;
    NSString *header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)prioritySegChanged:(id)sender {
    switch (_prioritySegment.selectedSegmentIndex)
    {
    case 0:
            priorityarray = [NSMutableArray new];
            for (int i =0 ; i<[allTasks count]; i++) {
                if ([[[allTasks objectAtIndex:i] taskPriority] isEqualToString:@"High"]) {
                    [priorityarray addObject:[allTasks objectAtIndex:i]];
                }
            }
            header = @"High Priority Tasks";
            
            [_sortedTable reloadData];
            break ;
    case 1:
            priorityarray = [NSMutableArray new];
            for (int i =0 ; i<[allTasks count]; i++) {
                if ([[[allTasks objectAtIndex:i] taskPriority] isEqualToString:@"Medium"]) {
                    [priorityarray addObject:[allTasks objectAtIndex:i]];
                }
            }
            header = @"Medium Priority Tasks";
            [_sortedTable reloadData];
            break ;
    case 2:
            priorityarray = [NSMutableArray new];
            for (int i =0 ; i<[allTasks count]; i++) {
                if ([[[allTasks objectAtIndex:i] taskPriority] isEqualToString:@"Low"]) {
                    [priorityarray addObject:[allTasks objectAtIndex:i]];
                }
            }
            header = @"Low Priority Tasks";
            [_sortedTable reloadData];
            break ;
    default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    allTasks = [NSMutableArray new];
    priorityarray = [NSMutableArray new];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if([[def objectForKey:@"a"] count] != 0){
        NSMutableArray *retrieved = [def objectForKey:@"a"];
        for (int i =0 ; i<[[def objectForKey:@"a"]count]; i++) {
            [allTasks addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[retrieved objectAtIndex:i]]];
        }
    }
    for (int i =0 ; i<[allTasks count]; i++) {
        if ([[[allTasks objectAtIndex:i] taskPriority] isEqualToString:@"High"]) {
            [priorityarray addObject:[allTasks objectAtIndex:i]];
        }
    }
    header = @"High Priority List";
    
    [_sortedTable reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriorityCell" forIndexPath:indexPath];
    cell.textLabel.text = [[priorityarray objectAtIndex:indexPath.row] taskName];
    if([[[priorityarray objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"High"]){
        cell.imageView.image =[UIImage imageNamed:@"1.png"] ;
    }
    else if([[[priorityarray objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"Medium"]){
        cell.imageView.image =[UIImage imageNamed:@"2.png"] ;
    }
    else  {
        cell.imageView.image =[UIImage imageNamed:@"3.png"] ;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [priorityarray count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return header;
}


@end
