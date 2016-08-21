//
//  ViewController.h
//  Coreprac
//
//  Created by haridasan on 18/07/16.
//  Copyright © 2016 Tcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <coredata/CoreData.h>
#import "DetailViewController.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

