//
//  SpeechViewController.m
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SpeechViewController.h"

#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface SpeechViewController () <SFSpeechRecognizerDelegate>

@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;

@property (nonatomic,strong) AVAudioEngine *audioEngine;

@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;

@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;

@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *resultStringLable;

@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordButton.enabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SFSpeechRecognizer  requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    self.recordButton.enabled = NO;
                    [self.recordButton setTitle:@"语音识别未授权" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    self.recordButton.enabled = NO;
                    [self.recordButton setTitle:@"用户未授权使用语音识别" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    self.recordButton.enabled = NO;
                    [self.recordButton setTitle:@"语音识别在这台设备上受到限制" forState:UIControlStateDisabled];
                    
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    self.recordButton.enabled = YES;
                    [self.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            
        });
    }];
}

- (IBAction)recordButtonClicked:(UIButton *)sender {
    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        if (_recognitionRequest) {
            [_recognitionRequest endAudio];
        }
        self.recordButton.enabled = NO;
        [self.recordButton setTitle:@"正在停止" forState:UIControlStateDisabled];
        
    }
    else{
        [self startRecording];
        [self.recordButton setTitle:@"停止录音" forState:UIControlStateNormal];
        
    }
}

- (void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
            strongSelf.resultStringLable.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            strongSelf.recognitionTask = nil;
            strongSelf.recognitionRequest = nil;
            strongSelf.recordButton.enabled = YES;
            [strongSelf.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
        }
        
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.recognitionRequest) {
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.resultStringLable.text = @"正在录音。。。";
}
#pragma mark - lazy load
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}

- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        //要为语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        self.recordButton.enabled = YES;
        [self.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
    }
    else{
        self.recordButton.enabled = NO;
        [self.recordButton setTitle:@"语音识别不可用" forState:UIControlStateDisabled];
    }
}


@end
