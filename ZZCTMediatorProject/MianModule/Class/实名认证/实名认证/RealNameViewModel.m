//
//  RealNameViewModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "RealNameViewModel.h"
#import "LZAddressCenter.h"

@implementation RealNameViewModel

- (void)submitStep1:(SimpleBoolBlock)block{
    
        //实名认证请求
    NSString *userName = CurrentUser.userName;
    NSString *ssId = @"";
    
    NSArray *loadArrary;
    
    NSData *imgDatag1 = UIImageJPEGRepresentation(self.cardFrontImage,0.5);
    NSData *imgDatag2 = UIImageJPEGRepresentation(self.cardBackImage,0.5);
    NSData *imgDatag3 = UIImageJPEGRepresentation(self.personImage,0.5);
    NSData *imgDatag4 = UIImageJPEGRepresentation(self.livingImage,0.1);
    imgDatag4 = imgDatag4?imgDatag4:[NSData data];
    
    loadArrary = @[@{@"idfrontpic":imgDatag1},//身份证正面
                   @{@"idbackpic":imgDatag2},// 身份证反面
                   @{@"idhandlepic":imgDatag3},
                   @{@"livingbody":imgDatag4}
                   ];
    
    NewParams;
    [params setSafeObject:userName forKey:@"usrTel"];
    [params setSafeObject:self.name forKey:@"usrName"];
    [params setSafeObject:self.IDCardNumber forKey:@"idNo"];
    [params setSafeObject:ssId forKey:@"sessionId"];
    
    [SVProgressHUD showWithStatus:@"正在上传..."];
//    [RequestTools uploadWithUrlString:zzf_real1 parameters:params uploadArrary:loadArrary success:^(NSDictionary *responseDic) {
//        [SVProgressHUD dismiss];
//        NSString *str = responseDic[@"resCode"];
//        NSString *str2 = responseDic[@"resMsg"];
//
//        if ([str isEqualToString:@"0"]) {
//            if(block)block(YES);
//        }else{
//            [SVProgressHUD showErrorWithStatus:str2];
//        }
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        [SVProgressHUD showImage:nil status:@"上传失败,请重试"];
//    }];
}
@end
