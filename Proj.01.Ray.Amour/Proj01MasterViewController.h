//
//  Proj01MasterViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/1/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Proj01DetailViewController;

#import <CoreData/CoreData.h>

@interface Proj01MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Proj01DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
