//
//  ViewController.h
//  MyAudioRecorderCordovaPlugin
//
//  Created by Jupiter Li on 5/10/2016.
//  Copyright (c) 2016 Jupiter Li. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "MyAudioRecorder.h"

@interface ViewController : UIViewController

- (IBAction) playBGM;
- (IBAction) pauseBGM;
- (IBAction) resumeBGM;
- (IBAction) stopBGM;

- (IBAction) startRecording;
- (IBAction) stopRecording;
- (IBAction) playback;

@end
