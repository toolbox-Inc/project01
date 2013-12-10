//
//  Proj01DetailViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/1/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface Proj01DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) NSManagedObject *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *deltaTextfield;
@property (weak, nonatomic) IBOutlet UITextField *messageTextfield;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)dismissKeyboard:(UIButton *)sender;
- (IBAction)changeBackgroundColor:(UIButton *)sender;
- (IBAction)changeMessage:(UIButton *)sender;
- (IBAction)mapButton:(UIButton *)sender;

@end
