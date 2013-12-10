//
//  UtilitiesViewController.h
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 12/9/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UtilitiesViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, strong) UIImagePickerController *chooseExisting;

@property (nonatomic, strong) UIImage *image;


- (IBAction)camera:(UIButton *)sender;

- (IBAction)voiceMemo:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
