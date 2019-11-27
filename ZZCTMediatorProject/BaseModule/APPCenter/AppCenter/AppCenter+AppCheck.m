//
//  AppCenter+AppCheck.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppCenter+AppCheck.h"
#import "ShowNeedAuthenViewController.h"
#import "RealNameOneViewController.h"
#import "LFLivenessManager.h"
#import "LZEmptyViewController.h"
#import "ShowNeedLevelViewController.h"

@implementation AppCenter (AppCheck)

/**是否是放到分发平台*/
+ (BOOL)checkAppIsToHoc{
    return NO;
}

/**是否在开发*/
+ (BOOL)checkAppIsDevelopment{
    return NO;
}

+ (void)checkModuleNotOpenToMemberUser{
    
    if ([self checkMerchant]) {
        [self figerNotOpen];
    }
}

+ (void)checkModuleNotOpenToAllUser{
    [self figerNotOpen];
}

+ (void)figerNotOpen{
    if (self.isDevelopmentNumber) {
        [self toEmptyController];
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂未开放!"];
    }
}

+ (BOOL)isDevelopmentNumber{
    if(self.checkAppIsDevelopment) return NO;
    return [CurrentUser.mobile isEqualToString:@"13779799999"];
}

+ (void)toEmptyController{
    LZEmptyViewController *vc = [LZEmptyViewController new];
    [[AppCenter getCurrentVC].navigationController pushViewController:vc animated:YES];
    
    NSString *registerId = [[NSUserDefaults standardUserDefaults] objectForKey:@"JPUSHServiceRegisterid"];
    [[UIPasteboard generalPasteboard] setString:registerId];
}

+ (void)setEmptyControllerTitle:(NSString *)title{
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"EmptyControllerTitle"];
}

+ (BOOL)checkMerchant{
    
    if ([self checkAppIsDevelopment]) {
        return YES;
    }
    
    if ([CurrentUser.usrType isEqualToString:@"merchant"]
        || [CurrentUser.usrType isEqualToString:@"system"]) {
        return YES;
    }
    
    UIViewController *vc = [self getCurrentVC];
   
    [ShowNeedAuthenViewController showNeedAuthenWithController:vc];
    return NO;
}

+ (BOOL)checkLevel:(NSInteger)level{
    
    if ([self checkAppIsDevelopment]) {
        return YES;
    }
    
    if (CurrentUser.userLvl >= level) {
        return YES;
    }
    
    UIViewController *vc = [self getCurrentVC];
   
    [ShowNeedLevelViewController showNeedAuthenWithController:vc];
    return NO;
}

+ (BOOL)checkRealName{
    
    if (CurrentUser.rlFlag){
        return YES;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"实名认证"
                                                                   message:@"请先实名认证！"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIViewController *VC = [AppCenter getCurrentVC];
    
    if (![VC isKindOfClass:[UIViewController class]]) {
        return YES;
    }
    
    @weakify(VC);
    UIAlertAction *toRealName = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(VC);
        [AppCenter goRealNameWithViewController:VC];
    }];
    
    [alert addAction:cancel];
    [alert addAction:toRealName];
    
    [VC presentViewController:alert animated:YES completion:nil];
    SDLog(@"实名认证VC == %@",VC);
    return NO;
}

static LFLivenessManager *LFManager = nil;
+ (void)goRealNameWithViewController:(UIViewController *)VC{
    
    LFManager = [LFLivenessManager new];
    [LFManager setViewController:VC];
    @weakify(VC);
    LFManager.block = ^(BOOL isSuccess, UIImage *image) {
        @strongify(VC);
        LFManager = nil;
        if (isSuccess) {
            RealNameOneViewController *realVC = [[UIStoryboard storyboardWithName:@"SM" bundle:nil] instantiateViewControllerWithIdentifier:@"smrz"];
            realVC.livingImage = image;
            [VC.navigationController pushViewController:realVC animated:YES linearBackId:LinearBackId_realName];
        }else{
            RealNameOneViewController *realVC = [[UIStoryboard storyboardWithName:@"SM" bundle:nil] instantiateViewControllerWithIdentifier:@"smrz"];
            realVC.livingImage = [AppCenter appIcon];
            [VC.navigationController pushViewController:realVC animated:YES linearBackId:LinearBackId_realName];
        }
        
    };
    
    [LFManager startDetect];
    
//       [VC.navigationController pushViewController:realVC animated:YES linearBackId:LinearBackId_realName];
}
@end
