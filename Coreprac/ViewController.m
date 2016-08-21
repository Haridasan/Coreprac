//
//  ViewController.m
//  Coreprac
//
//  Created by haridasan on 18/07/16.
//  Copyright © 2016 Tcs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong) NSMutableArray *devices;
@end

@implementation ViewController
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   self.table.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
    //self.table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpg"]];
    // self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
   // self.table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpg"]];
   
    //UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    //self.table.contentInset = inset;// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Devicedetail"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.table reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.devices.count;
}



//- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger rowCount = [self tableView:[self table] numberOfRowsInSection:0];
//    NSInteger rowIndex = indexPath.row;
//    UIImage *background = nil;
//    
//    if (rowIndex == 0) {
//        background = [UIImage imageNamed:@"cell_top.jpg"];
//    } else if (rowIndex == rowCount - 1) {
//        background = [UIImage imageNamed:@"cell_bottom.jpg"];
//    } else {
//        background = [UIImage imageNamed:@"cell_middle.jpg"];
//    }
//    
//    return background;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //UITableViewCell *cell = [[UITableViewCell alloc]init];
    // Configure the cell...
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"], [device valueForKey:@"version"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"company"]]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
//    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
//    
//    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
//    cellBackgroundView.image = background;
//    cell.backgroundView = cellBackgroundView;
    return cell;
   // [self.table reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.devices removeObjectAtIndex:indexPath.row];
        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
