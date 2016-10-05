//
// Created by Jupiter Li on 5/10/2016.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MyAudioRecorder.h"

#define RECORD_FILENAME "record.caf"

@interface MyAudioRecorder() {
    AVAudioPlayer *_bgmPlayer;
    AVAudioPlayer *_effectPlayer;// remain for future use

    AVAudioSession *_audioSession;

    AVAudioRecorder *_audioRecorder;
}
@end

@implementation MyAudioRecorder {

}

- (void) prepare {
    _audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        [self standerErrorHandler:error];
    }
    [_audioSession setActive:YES error:&error];
    if (error) {
        [self standerErrorHandler:error];
    }

    NSMutableDictionary * recordSettings = [[NSMutableDictionary alloc] init];
    [self setupRecordSettingWithDefault:recordSettings];

    NSString *recordFilePath = [[self getTemporaryDirectory] stringByAppendingFormat:@"%s", RECORD_FILENAME];

    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:recordFilePath] settings:recordSettings error:&error];
    if (!_audioRecorder) {
        [self standerErrorHandler:error];
    }
    _audioRecorder.delegate = self;
    _audioRecorder.meteringEnabled = YES;
    [_audioRecorder prepareToRecord];

    [self setupRecordingInterruptHandler];
}

- (void) playBGM: (NSString *)audioFilePath {
    NSError *error;
    _bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioFilePath] error:&error];
    _bgmPlayer.delegate = self;
    [_bgmPlayer play];
    [self audioPlayerDidStartPlay:_bgmPlayer successfully:true];
}
- (void) pauseBGM {
    if (_bgmPlayer) {
        [_bgmPlayer pause];
    }
    [self audioPlayerDidPaused:_bgmPlayer successfully:true];
}
- (void) resumeBGM {
    if (_bgmPlayer) {
        [_bgmPlayer play];
    }
    [self audioPlayerDidResumed:_bgmPlayer successfully:true];
}
- (void) stopBGM {
    if (_bgmPlayer) {
        [_bgmPlayer stop];
    }
    [self audioPlayerDidStopped:_bgmPlayer successfully:true];
}

// other audio play event
- (void) audioPlayerDidStartPlay:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Audio player did start play");
}
- (void) audioPlayerDidPaused:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Audio player did paused play");
}
- (void) audioPlayerDidResumed:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Audio player did resumed");
}
- (void) audioPlayerDidStopped:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Audio player did stopped");
}

// implement AVAudioPlayerDelegate
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Audio player did finish playing");
}
- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Audio player decode error did occur");
}

- (void)startRecording {
    [_audioRecorder record];
    [self audioRecorderDidStartRecording:_audioRecorder successfully:true];
}

- (void)stopRecording {
    [_audioRecorder stop];
}

- (NSString *)getRecordFilePath {
    return [[self getTemporaryDirectory] stringByAppendingFormat:@"%s", RECORD_FILENAME];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"Audio recorder did finished recording");
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *__nullable)error {
    NSLog(@"Audio recorder encode error did occur");
}

- (void)audioRecorderDidStartRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"Audio recorder did start");
}

- (void)finalise {
    [_audioSession setActive:NO error:nil];
}

- (void)standerErrorHandler: (NSError *) error {
    NSLog(@"AudioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
}

- (void) setupRecordSettingWithDefault: (NSMutableDictionary *)settings {
    [settings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [settings setValue:@44100.0F forKey:AVSampleRateKey];
    [settings setValue:@2 forKey:AVNumberOfChannelsKey];

    [settings setValue:@16 forKey:AVLinearPCMBitDepthKey];
    [settings setValue:@NO forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue:@NO forKey:AVLinearPCMIsFloatKey];
}

- (NSString *) getTemporaryDirectory {
    return NSTemporaryDirectory();
}

/**
 *  no test yet
 *
 * */
- (void)setupRecordingInterruptHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:"recordingInterruptHandler" name:AVAudioSessionInterruptionNotification object:_audioRecorder];
}

/**
 *  no test yet
 *
 * */
- (void)recordingInterruptHandler {
    NSLog(@"Recording interrupted");
}

@end

























