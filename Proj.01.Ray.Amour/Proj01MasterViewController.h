//
//  Proj01MasterViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/1/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Coordinates.h"
#import "Proj01DetailViewController.h"


@class Proj01DetailViewController;


@interface Proj01MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Proj01DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
