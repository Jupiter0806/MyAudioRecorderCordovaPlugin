//
//  ViewController.m
//  MyAudioRecorderCordovaPlugin
//
//  Created by Jupiter Li on 5/10/2016.
//  Copyright (c) 2016 Jupiter Li. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

{
    MyAudioRecorder *_recorder;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _recorder = [[MyAudioRecorder alloc] init];
    [_recorder prepare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playBGM {
    [_recorder playBGM: [self getAudioFilePath]];
}

- (IBAction)pauseBGM {
    [_recorder pauseBGM];
}

- (IBAction) resumeBGM {
    [_recorder resumeBGM];
}

- (IBAction)stopBGM {
    [_recorder stopBGM];
}

- (IBAction)setVolume {
    [_recorder setVolume:(arc4random() % 101)];
}


- (IBAction)startRecording {
    [_recorder startRecording];
}

- (IBAction)stopRecording {
    [_recorder stopRecording];
}

- (IBAction)playback {
    [_recorder playBGM:[_recorder getRecordFilePath]];
}


// helpers
- (NSString *) getAudioFilePath {
    return [[NSBundle mainBundle] pathForResource:@"audio1" ofType:@"mp3"];
}

@end