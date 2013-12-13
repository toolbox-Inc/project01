//
//  UtilitiesViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 12/9/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreData/CoreData.h>

@interface UtilitiesViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, strong) UIImagePickerController *chooseExisting;

@property (nonatomic, strong) UIImage *image;


- (IBAction)camera:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)recordMemo:(UIButton *)sender;
- (IBAction)stopRecord:(UIButton *)sender;
- (IBAction)playMemo:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic, strong) NSManagedObject *detailItemUtilities;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
