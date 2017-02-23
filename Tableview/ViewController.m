//
//  ViewController.m
//  Tableview
//
//  Created by Nagam Pawan on 2/21/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define EDIT_TAG 100
#define ADD_TAG 101
@interface ViewController ()

@end

@implementation ViewController{
    
    NSIndexPath *path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];
    
    [self.tableView reloadData];
    self.addbutton.tag = ADD_TAG;
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSManagedObjectContext *)getContext{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    return context;
    
}

-(void)fetchData{
    
    NSManagedObjectContext *context = [self getContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    self.nameArray = [[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:nil]];
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add:(UIButton*)sender {
    
    if (sender.tag == EDIT_TAG) {
        path = [self.tableView indexPathForSelectedRow];
        NSManagedObjectContext *cotext = [self getContext];
        NSManagedObject *object = [self.nameArray objectAtIndex:path.row];
        [object setValue:self.nameTextField.text forKey:@"name"];
        self.addbutton.tag = ADD_TAG;
        NSError *error = nil;
        
        if (![cotext save:&error]) {
            
            NSLog(@"Data is not saved");
            
        }
        
        else{
            
            NSLog(@"data is saved");
            
        }
//        [self fetchData];
//        [self.tableView reloadData];
    }
    else{
    
    NSManagedObjectContext *context = [self getContext];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
    [object setValue:self.nameTextField.text forKey:@"name"];
    NSError *error = nil;
    if (![context save:&error]) {
        
        NSLog(@"Data not saved");
        
    }
    
    else{
        
        NSLog(@"Data is saved");
        
    }
        [self fetchData];
        [self.tableView reloadData];
    }
    [self fetchData];
    [self.tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.nameArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSManagedObject *object = [self.nameArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [object valueForKey:@"name"];
    return cell;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        NSManagedObjectContext *context = [self getContext];
//        [context deleteObject:[self.nameArray objectAtIndex:indexPath.row]];
//        NSError *error = nil;
//        [context save:&error];
//        [self.nameArray removeObjectAtIndex:indexPath.row];
//        
//    }
//    [self.tableView reloadData];
//}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSManagedObject *object = [self.nameArray objectAtIndex:indexPath.row];
        self.nameTextField.text = [object valueForKey:@"name"];
        self.addbutton.tag = EDIT_TAG;
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self fetchData];
        
    }];
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSManagedObjectContext *context = [self getContext];
        [context deleteObject:[self.nameArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        [context save:&error];
        [self.nameArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
//    [self.tableView reloadData];
    return @[delete, edit];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSManagedObject *object = [self.nameArray objectAtIndex:indexPath.row];
//    self.nameTextField.text = [object valueForKey:@"name"];
//    self.addbutton.tag = EDIT_TAG;
//    
//}
@end
