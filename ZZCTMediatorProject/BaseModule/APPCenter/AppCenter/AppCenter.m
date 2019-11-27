//
//  AppCenter.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "AppCenter.h"
#import "NSDate+Extensions.h"
#import "AppInfoModel.h"
#import "CYLTabBarControllerConfig.h"
#import <UShareUI/UShareUI.h>
#import <WXApi.h>

@implementation AppCenter

+ (void)callWithPhoneNumber:(NSString *)phone{
    
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
    
    [AppCenter openURL:callPhone];
}

+ (void)callKeFu{
    
    NSString *startTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuStartTime"];
    NSString *endTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuEndTime"];
    
    BOOL vaule = [self checkTimeWithStart:startTimeStr end:endTimeStr];
    if (!vaule) {
        NSString *infoMessage = [NSString stringWithFormat:@"客服服务时间:\n工作日 %@～%@",startTimeStr,endTimeStr];
        [SVProgressHUD showImage:nil status:infoMessage];
        return;
    }
    
    [AppCenter callWithPhoneNumber:[self KeFuPhone]];
}

+ (NSString *)KeFuPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuPhone"];
}

+ (void)openURL:(NSString *)urlStr{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
            // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
}

+ (BOOL)powerCheck{
  
    return YES;
}

/**绑定商户二维码code*/
+ (void)showEditCodeWithController:(UIViewController *)controller{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"绑定二维码" message:@"请输入二维码编号" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        if (userNameTextField.text.length) {
            [self bindCode:userNameTextField.text];
        }
    }]];
    
        //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
        //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入二维码编号";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
   
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

/**绑定商户w二维码code*/
+ (void)bindCode:(NSString *)code{
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"merchantUserId"];
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.shortMerchantName forKey:@"merchantName"];
    [params setSafeObject:code forKey:@"code"];
    
    ZZNetWorker.FormData.zz_param(params).zz_url(@"/distribution/tbDimensionCode/merchantBind")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功！"];
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

+ (void)toTabBarController{
    
    UIView *lastView = KeyWindow.rootViewController.view;
    
    CYLTabBarController *tabVC = [CYLTabBarControllerConfig tabBarController];
    KeyWindow.rootViewController = tabVC;
    
    if(lastView)[KeyWindow addSubview:lastView];
    
    tabVC.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        tabVC.view.alpha = 1;
        lastView.alpha = 0;
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
    }];
}

+ (BOOL)checkTimeWithStart:(NSString *)start end:(NSString *)end{
    
        //可用 时间段 判断
    NSDate *date = [NSDate date];
    NSInteger hour = date.hour;
    NSInteger minute = date.minute;
    
    NSArray *endTime = [end componentsSeparatedByString:@":"];
    if (endTime.count == 2) {
        NSInteger endHour = [endTime.firstObject integerValue];
        NSInteger endMinute = [endTime.lastObject integerValue];
        if (hour > endHour) {
            
            return NO;
        }else if (hour == endHour) {
            if (minute > endMinute) {
                
                return NO;
            }
        }
    }
    
    NSArray *startTime = [start componentsSeparatedByString:@":"];
    if (startTime.count == 2) {
        NSInteger startHour = [startTime.firstObject integerValue];
        NSInteger startMinute = [startTime.lastObject integerValue];
        if (hour < startHour) {
            
            return NO;
        }else if (hour == startHour) {
            if (minute < startMinute) {
                
                return NO;
            }
        }
    }
    
    return YES;
}


+ (UIImage *)launchImage {
    
    UIImage    *lauchImage  = nil;
    NSString    *viewOrientation = nil;
    CGSize     viewSize  = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation  = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewOrientation = @"Landscape";
        
    } else {
        
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    return lauchImage;
}

+ (UIImage *)appIcon {
    
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    UIImage* image = [UIImage imageNamed:icon];

    return image;
}

+ (UIImage *)defaultAppAvatar{  
    UIImage* image = [UIImage imageNamed:@"touxiang"];
    
    return image;
}

+ (NSString *)appName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}

#pragma mark - 版本检查
+ (void)getAppInfo{
    ZZNetWorker.GET.zz_param(@{@"appId":OEMID})
    .zz_url(API_getOemInfo).zz_authorization(@"")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            AppInfoModel *appInfo = [AppInfoModel mj_objectWithKeyValues:model_net.data];
            
            [self showUpdateWith:appInfo];
        }
    });
}

+ (void)showUpdateWith:(AppInfoModel *)appInfo{

    if (!appInfo.iosUrl.boolValue) {
        return;
    }
    
    if ([appInfo.iosVersion isEqualToString:AppVersion]) {
 
        return ;
    }
    
    HDAlertView *alert = [HDAlertView alertViewWithTitle:@"发现新版本" andMessage:appInfo.remark];
    alert.cancelButtonTitleColor = UIColorHex(0x353535);
    if (!appInfo.force) {
       [alert addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeCancel handler:nil];
    }
    
    [alert addButtonWithTitle:@"前往下载" type:HDAlertViewButtonTypeDestructive handler:^(HDAlertView *alertView) {
        NSString *str = @"https://apps.apple.com/cn/app/%E5%85%AD%E6%97%BA%E5%95%86%E5%AE%B6%E7%89%88/id1472108791";
        if ([AppCenter checkAppIsToHoc] && !IsNull(appInfo.iosDownUrl)) {
            str = appInfo.iosDownUrl;
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
            exit(0);
        }];
        
    }];
    [alert show];
}

+ (NSString *)shareRegisterURL{
    return [NSString stringWithFormat:@"%@?refNm=%@",URL_RegisterHTML,CurrentUser.mobile];
}

+ (void)shareURL:(NSString *)url{
    [self shareURL:url
             title:@"快来注册，省钱赚钱"
          subTitle:@"您已经有99个熟人在使用了"
             image:[AppCenter appIcon]];
}

+ (void)shareURL:(NSString *)url
           title:(NSString *)title
        subTitle:(NSString *)subTitle
           image:(id)image{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageToPlatformType:platformType URL:url title:title subTitle:subTitle image:image];
    }];
}

+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
                             URL:(NSString *)url
                           title:(NSString *)title
                        subTitle:(NSString *)subTitle
                           image:(id)image
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
        //创建图片内容对象
    UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
        //如果有缩略图，则设置缩略图
    shareObject.thumbImage = image;
    shareObject.webpageUrl = url;
    shareObject.title = title;
    shareObject.descr = subTitle;
        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[AppCenter getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

/**跳小程序*/
+ (void)toMiniProgram{
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = @"gh_ca5b1657f94b";//拉起的小程序的username
   id userInfo = CurrentUser.currentUserInfoDic;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;

    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    launchMiniProgramReq.path = [NSString stringWithFormat:@"pages/index/main?taken_id=%@&user_info=%@",CurrentUser.access_token,jsonString];
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease;//拉起小程序的类型
//WXMiniProgramTypeRelease
    [WXApi sendReq:launchMiniProgramReq];

}

@end
 
