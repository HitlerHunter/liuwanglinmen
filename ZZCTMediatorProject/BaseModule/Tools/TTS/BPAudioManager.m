//
//  BPAudioManager.m
//  PushAudioDemo
//
//  Created by Winter on 2018/5/31.
//  Copyright © 2018年 www.bestpay.com.cn. All rights reserved.
//

#import "BPAudioManager.h"
#import "BDSSpeechSynthesizer.h"
#import "BDSBuiltInPlayer.h"

@import AVFoundation ;
@import MediaPlayer ;

static BOOL isSpeak = NO;

NSString* APP_ID = @"16823346";
NSString* API_KEY = @"L9jNDqCqjsz27GG1oEgAYff0";
NSString* SECRET_KEY = @"zzkdtRLk28l1IzAhb3kyIEIsuk6LLnFa";

@interface BPAudioManager() <AVAudioPlayerDelegate,BDSSpeechSynthesizerDelegate,BDSBuiltInPlayerDelegate>

@property(nonatomic, copy) BPAudioPlayCompleted completed ;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer ;
@property(nonatomic, strong) NSMutableArray *moneyTextArray;
@property (nonatomic, strong) BDSBuiltInPlayer *textPlayer;

@property (nonatomic, strong) NSData *currentPcmData;
@end

@implementation BPAudioManager

+ (instancetype)sharedPlayer {
    static BPAudioManager *_instance = nil ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[BPAudioManager alloc] init];
        [_instance configureSDK];
    }) ;
    return _instance ;
}

-(void)configureSDK{

    [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_OFF];
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    [self configureOnlineTTS];
    
}

-(void)configureOnlineTTS{
    
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];
    
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(BDS_SYNTHESIZER_SPEAKER_FEMALE) forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
        //    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:@(10) forKey:BDS_SYNTHESIZER_PARAM_ONLINE_REQUEST_TIMEOUT];
    
}

- (void)willPlayWithMoney:(NSString *)money{
    
    NSString *text = [NSString stringWithFormat:@"副业吧进账%@元",money];
    [self willPlayWithText:text];
}

- (void)willPlayWithText:(NSString *)text{
    
    [self.moneyTextArray addObject:text];
    
    [self checkToPlay];
}

- (void)checkToPlay{
    
    if (isSpeak) {
        return;
    }
    
    if (self.moneyTextArray.count) {
        [self activePlayback];
        isSpeak = YES;
        [self playWithText:self.moneyTextArray.firstObject];
    }
}

- (void)playWithText:(NSString *)text{
    
    NSError *error = nil;
    [[BDSSpeechSynthesizer sharedInstance] synthesizeSentence:text withError:&error];
    
    if (error) {
        isSpeak = NO;
    }
    
}

//播放头音效
- (void)palyHeaderAudio{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"tts_pre.mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    _audioPlayer.numberOfLoops = 0 ;
    _audioPlayer.delegate = self;
    
    [self.audioPlayer prepareToPlay];
    if (![self.audioPlayer play]) {//iOS 12.2 AVAudioPlayer 后台无效
        [self audioPlayerDidFinishPlaying:self.audioPlayer successfully:YES];
    }
    
    
}


#pragma mark ---------- BDSSpeechSynthesizerDelegate -----------------
- (void)synthesizerNewDataArrived:(NSData *)newData
                       DataFormat:(BDSAudioFormat)fmt
                   characterCount:(int)newLength
                   sentenceNumber:(NSInteger)SynthesizeSentence{
    
    _currentPcmData = newData;
    
    [self palyHeaderAudio];
    
}

#pragma mark ----------------- AVAudioPlayerDelegate -----------------
// 播放完成回调
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [self disactivePlayback];
    if (!_textPlayer) {
        _textPlayer = [[BDSBuiltInPlayer alloc] init];
        _textPlayer.delegate = self;
    }
    NSError *error = nil;
    [_textPlayer playPcmData:_currentPcmData error:&error];
    
    if (error) {
        isSpeak = NO;
    }
}

#pragma mark ----------------- BDSBuiltInPlayerDelegate -----------------
- (void)playerDidFinished:(BDSBuiltInPlayer *)player{
    isSpeak = NO;
    if (self.moneyTextArray.count) {//播放完成 ，移除
        [self.moneyTextArray removeObjectAtIndex:0];
    }
    
    [self checkToPlay];
}

- (void)playerDidPaused:(BDSBuiltInPlayer *)player{}

- (void)playerErrorOccured:(BDSBuiltInPlayer *)player error:(NSError*)error{
    _textPlayer = nil;
    isSpeak = NO;
}

#pragma mark ----------------- AVAudioPlayer -----------------
- (void)activePlayback {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
}

- (void)disactivePlayback {
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
}


- (NSMutableArray *)moneyTextArray{
    if (!_moneyTextArray) {
        _moneyTextArray = [NSMutableArray array];
    }
    return _moneyTextArray;
}

@end
