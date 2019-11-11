//
//  LFLivenessManager.m
//  LFLivenessSample
//
//  Created by zenglizhi on 2018/8/9.
//  Copyright © 2018年 SunLin. All rights reserved.
//

#import "LFLivenessManager.h"
#import "LFLivefaceViewController.h"
#import "LFMultipleLivenessController.h"
#import "LFAlertView.h"

@interface LFLivenessManager ()<LFMultipleLivenessDelegate>
@property (nonatomic, copy) NSString *outType;
@property (nonatomic, copy) NSString *strJson;
@property (nonatomic, assign) LivefaceComplexity complexity;
@property (nonatomic, copy) NSArray *sequence;
@property (nonatomic, weak) LFMultipleLivenessController *multipleLiveVC;
@property (nonatomic, weak) UIViewController *showViewController;
@end


@implementation LFLivenessManager

- (void)dealloc{
    SDLog(@"LFLivenessManager - dealloc");
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.outType = @"singleImg";
        self.complexity = LIVE_COMPLEXITY_NORMAL;
        self.sequence = @[@"BLINK", @"MOUTH", @"NOD", @"YAW"];
    }
    return self;
}

- (void)setViewController:(id)viewController{
    _showViewController = viewController;
}
#pragma mark - Actions
- (void)startDetect
{
    [self.showViewController presentViewController:[self setupMultiController] animated:NO completion:^{
        [self restart];
    }];
}

- (void)handleResultWithData:(NSData *)data lfImages:(NSArray *)arrLFImage lfVideoData:(NSData *)lfVideoData SDKVersion:(NSString *)strVersion
{
    
    if (arrLFImage.count) {
        LFImage *stImage = arrLFImage.firstObject;
        UIImage *image = stImage.image;
        //需要上传？
        [self.multipleLiveVC dismissViewControllerAnimated:NO completion:nil];
        if (self.block) {
            self.block(YES, image);
        }
    }
}

- (void)restart
{
    [self.multipleLiveVC restart];
}

#pragma - mark LFMultipleLivenessDelegate

- (void)multiLivenessDidStart
{
    
}

- (void)multiLivenessDidSuccessfulGetData:(NSData *)encryTarData lfImages:(NSArray *)arrLFImage lfVideoData:(NSData *)lfVideoData
{
    [self handleResultWithData:encryTarData lfImages:arrLFImage lfVideoData:lfVideoData SDKVersion:@""];
}

- (void)multiLivenessDidFailWithType:(LFMultipleLivenessError)iErrorType DetectionType:(LFDetectionType)iDetectionType DetectionIndex:(NSInteger)iIndex Data:(NSData *)encryTarData lfImages:(NSArray *)arrLFImage lfVideoData:(NSData *)lfVideoData
{
        //第一个动作跟丢不弹框
    if (iErrorType == LFMultipleLivenessFaceChanged && iIndex == 0) {
        [self restart];
        return;
    }
    switch (iErrorType) {
            
        case LFMultipleLivenessInitFaild: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"算法SDK初始化失败：可能是授权文件或模型路径错误，SDK权限过期，包名绑定错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        case LFMultipleLivenessCameraError: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"相机权限获取失败或权限被拒绝" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        case LFMultipleLivenessFaceChanged: {
            LFAlertView *alert = [[LFAlertView alloc] initWithTitle:@"采集失败，再试一次吧" delegate:self];
            [alert showOnView:[UIApplication sharedApplication].keyWindow];
        }
            break;
            
        case LFMultipleLivenessTimeOut: {
            LFAlertView *alert = [[LFAlertView alloc] initWithTitle:@"动作超时" delegate:self];
            [alert showOnView:[UIApplication sharedApplication].keyWindow];
            
        }
            break;
            
        case LFMultipleLivenessWillResignActive: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"活体检测失败, 请保持前台运行,点击确定重试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
            break;
            
        case LFMultipleLivenessInternalError: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"内部错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        case LFMultipleLivenessBadJson: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"bad json"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
            break;
            
        case LFMultipleLivenessBundleIDError: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"未替换包名或包名错误"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
            break;
        case LFMultipleLivenessAuthExpire: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"授权文件过期"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        default:
            break;
    }
}

- (void)multiLivenessDidCancel
{
    [self.showViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.block) {
        self.block(NO, nil);
    }
}

#pragma - mark AlertViewDelegate

- (void)alertView:(LFAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            [self.multipleLiveVC cancel];
        }
            break;
        case 1: {
            [self restart];
        }
            break;
            
        default: {
            [self.multipleLiveVC cancel];
        }
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            [self.multipleLiveVC cancel];
        }
            break;
        case 1: {
            [self restart];
        }
            break;
            
        default: {
            [self.multipleLiveVC cancel];
        }
            break;
    }
}

#pragma mark - Properties

- (NSString *)strJson
{
    if (!_strJson) {
        NSDictionary *dictJson = @{@"sequence": self.sequence,
                                   @"outType": self.outType,
                                   @"Complexity": @(self.complexity)};
        _strJson = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictJson options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    return _strJson;
}

- (LFMultipleLivenessController *)setupMultiController
{
    LFMultipleLivenessController *multipleLiveVC = [[LFMultipleLivenessController alloc] init];
    self.multipleLiveVC = multipleLiveVC;
//    self.version = [multipleLiveVC getLivenessVersion];
    multipleLiveVC.delegate = self;
//    [multipleLiveVC setVoicePromptOn:self.openVoice];
    [multipleLiveVC setJsonCommand:self.strJson];
    return multipleLiveVC;
}
@end
