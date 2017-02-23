//
//  ViewController.h
//  Tableview
//
//  Created by Nagam Pawan on 2/21/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)add:(UIButton*)sender;
@property (strong, nonatomic) NSMutableArray *nameArray;
@property (strong, nonatomic) IBOutlet UIButton *addbutton;

@end

