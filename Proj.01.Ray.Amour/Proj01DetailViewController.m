//
//  Proj01DetailViewController.m
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 11/1/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import "Proj01DetailViewController.h"
#import "Coordinates.h"
#import "MapViewController.h"
#import "UtilitiesViewController.h"


@interface Proj01DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

@implementation Proj01DetailViewController

int countColor, countMessage;
bool bolVar = YES;



#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        self.latitudeTextfield.text = [[self.detailItem valueForKey:@"latitude"] description];
        self.longitudeTextfield.text = [[self.detailItem valueForKey:@"longitude"] description];
        self.deltaTextfield.text = [[self.detailItem valueForKey:@"delta"] description];
    }
    
    self.latitudeTextfield.delegate = self;
    self.longitudeTextfield.delegate = self;
    self.deltaTextfield.delegate = self;
    self.messageTextfield.delegate = self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self.detailItem setValue:[NSNumber numberWithDouble:[self.latitudeTextfield.text doubleValue]] forKey:@"latitude"];
    [self.detailItem setValue:[NSNumber numberWithDouble:[self.longitudeTextfield.text doubleValue]] forKey:@"longitude"];
    [self.detailItem setValue:[NSNumber numberWithDouble:[self.deltaTextfield.text doubleValue]] forKey:@"delta"];
    
    
    NSError *error = nil;
    
    if(![self.detailItem.managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


- (IBAction)changeBackgroundColor:(UIButton *)sender {
    
    countColor = (arc4random() %3);
    
    switch (countColor) {
        case 0:
            self.view.backgroundColor =[UIColor redColor];
            break;
        case 1:
            self.view.backgroundColor =[UIColor yellowColor];
            break;
        case 2:
            self.view.backgroundColor =[UIColor greenColor];
            break;
            
        default:
            break;
    }
    
    
}

- (IBAction)changeMessage:(UIButton *)sender {
    
    countMessage = (arc4random()%5);
    
    
    switch (countMessage) {
    case 0:
        self.messageTextfield.text = [NSString stringWithFormat:@"I got %i dollars in my bank", countMessage];
        countMessage = 0;
        break;
    case 1:
        self.messageTextfield.text = [NSString stringWithFormat:@"I only own %i car", countMessage];
        countMessage = 0;
        break;
    case 2:
        self.messageTextfield.text =[NSString stringWithFormat:@"I have %i siblings", countMessage];
        countMessage = 0;
        break;
    case 3:
        self.messageTextfield.text = [NSString stringWithFormat:@"I had %i jobs at one point", countMessage];
        countMessage = 0;
        break;
    case 4:
        self.messageTextfield.text = [NSString stringWithFormat:@" I can juggle %i soccer balls", countMessage];
        countMessage = 0;
        break;
    default:
        self.messageTextfield.text = @"count is out of range";
        break;
    }
    
    
}

- (IBAction)mapButton:(UIButton *)sender {
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.latitudeTextfield resignFirstResponder];
    [self.longitudeTextfield resignFirstResponder];
    [self.deltaTextfield resignFirstResponder];
    [self.messageTextfield resignFirstResponder];
    
    return YES;
}

- (IBAction)dismissKeyboard:(UIButton *)sender
{
    
    [self.latitudeTextfield resignFirstResponder];
    [self.longitudeTextfield resignFirstResponder];
    [self.deltaTextfield resignFirstResponder];
    [self.messageTextfield resignFirstResponder];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toMapSegue"]) {
        
        MapViewController *mapViewController = (MapViewController *)segue.destinationViewController;
        
        mapViewController.coordinatesObject = self.detailItem;
        
        NSLog(@"yes !!!!");
    }
    
    
    if([segue.identifier isEqualToString:@"toUtilities"]) {
        
        NSLog(@"yeah baby");
        
        UtilitiesViewController *utilitiesViewController = (UtilitiesViewController *)segue.destinationViewController;
        
        utilitiesViewController.detailItemUtilities = self.detailItem;
        
    }
}

@end
    
    
    
    
    
    
    
    
