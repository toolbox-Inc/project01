//
//  UtilitiesViewController.m
//  Proj.01.Ray.Amour
//
//  Created by Ray Amour on 12/9/13.
//  Copyright (c) 2013 Ray Amour. All rights reserved.
//

#import "UtilitiesViewController.h"



@interface UtilitiesViewController ()


@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation UtilitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpRecorder];
	
    self.picker = [[UIImagePickerController alloc] init];
    [self.picker setDelegate:self];
    
    self.chooseExisting = [[UIImagePickerController alloc]init];
    [self.chooseExisting setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)camera:(UIButton *)sender {
    
    
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:NULL];
    
    
}

- (IBAction)chooseExisting:(UIButton *)sender {
    
    [self.chooseExisting setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [self presentViewController:self.chooseExisting animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:self.image];
    
    UIImageWriteToSavedPhotosAlbum(self.image , nil, nil, nil);
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)setUpRecorder
{
    [self.stopButton setEnabled:NO];
    [self.playButton setEnabled:NO];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"MyAudioMemo.m4a", nil];
    
    NSURL *outputFile = [NSURL fileURLWithPathComponents:pathComponents];
    
    NSError *error = [[NSError alloc]init];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    self.recorder = [[AVAudioRecorder alloc]initWithURL:outputFile settings:recordSettings error:&error];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}






- (IBAction)recordMemo:(UIButton *)sender {
    
    NSError *error = [[NSError alloc]init];
    
    if (self.player.playing) {
        [self.player stop];
    }
    
    if (!self.recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:&error];
        
        [self.recorder record];
        
        
    }
    else {
        
        [self.stopButton setEnabled:YES];
        [self.playButton setEnabled:NO];
    }
}

- (IBAction)stopRecord:(UIButton *)sender {
    
    NSError *error = [[NSError alloc]init];
    
    [self.recorder stop];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:&error];
    
    
    
}

- (IBAction)playMemo:(UIButton *)sender {
    
    NSError *error = [[NSError alloc]init];
    
    if (!self.recorder.recording) {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:&error];
        self.player.delegate = self;
        self.player.volume = 70;
        
        [self.player play];
        
    }
    
}


- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    [self.stopButton setEnabled:YES];
    [self.playButton setEnabled:YES];
}
@end










