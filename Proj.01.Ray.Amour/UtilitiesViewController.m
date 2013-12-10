//
//  UtilitiesViewController.m
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 12/9/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import "UtilitiesViewController.h"

@interface UtilitiesViewController ()


@end

@implementation UtilitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.picker = [[UIImagePickerController alloc] init];
    [self.picker setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)camera:(UIButton *)sender {
    
    
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:NULL];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)voiceMemo:(UIButton *)sender {
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}






@end










