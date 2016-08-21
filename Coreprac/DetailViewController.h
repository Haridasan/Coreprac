//
//  DetailViewController.h
//  Coreprac
//
//  Created by haridasan on 19/07/16.
//  Copyright © 2016 Tcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Devicedetail.h"
@interface DetailViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *version;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
//@property(nonatomic,retain) NSManagedObjectContext *context;
//-(void)setmanagedobjectcontext:(NSManagedObjectContext*)objcontext;
@end
