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

@implementation AppCenter (AppCheck)

/**是否是放到分发平台*/
+ (BOOL)checkAppIsToHoc{
    return YES;
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
    if ([CurrentUser.mobile isEqualToString:@"18974908103"]) {
        SDBaseViewController *vc = [SDBaseViewController new];
        [[AppCenter getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂未开放!"];
    }
}

+ (BOOL)checkMerchant{
    
//    return YES;
    if ([CurrentUser.usrType isEqualToString:@"merchant"]
        || [CurrentUser.usrType isEqualToString:@"system"]) {
        return YES;
    }
    
    UIViewController *vc = [self getCurrentVC];
   
    [ShowNeedAuthenViewController showNeedAuthenWithController:vc];
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
