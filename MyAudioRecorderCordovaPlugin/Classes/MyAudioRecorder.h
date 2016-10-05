//
// Created by Jupiter Li on 5/10/2016.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MyAudioRecorder : NSObject <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

- (void) prepare;

- (void) playBGM: (NSString *)audioUrl;
- (void) pauseBGM;
- (void) resumeBGM;
- (void) stopBGM;

- (void)startRecording;
- (void)stopRecording;
- (NSString *)getRecordFilePath;

@end