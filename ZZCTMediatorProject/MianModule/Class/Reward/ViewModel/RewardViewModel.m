//
//  RewardViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardViewModel.h"
#import "RewardViewController.h"
#import "RewardRecordViewController.h"
#import "OssService.h"
#import "NSString+OSSURL.h"
#import "RewardRecordModel.h"
#import "RewardStatusViewController.h"
#import "RewardCityViewController.h"

@implementation RewardViewModel

+ (void)pushToRewardMoudleWithNav:(UINavigationController *)nav{
    
    
    if (CurrentUser.lzUserType == LZUserTypeMember) {
        RewardCityViewController *city = [[RewardCityViewController alloc] initWithNotHiddenNavgationBar:YES];
        
        [nav pushViewController:city animated:YES];
    }else{
        [self pushToRewardViewControllerWithNav:nav];
    }
    
    
}

+ (void)pushToRewardViewControllerWithNav:(UINavigationController *)nav{
    RewardViewController *rewardVc = [[RewardViewController alloc] init];
    [nav pushViewController:rewardVc animated:YES];
}

+ (void)pushToRewardRecordViewControllerWithNav:(UINavigationController *)nav{
    
    RewardRecordViewController *rewardVc = [[RewardRecordViewController alloc] init];
    [nav pushViewController:rewardVc animated:YES];
}

+ (void)submitChangeRewardWithValue:(NSString *)value
                             image1:(UIImage *)image1
                             image2:(UIImage *)image2
                              block:(SimpleBoolBlock)block{
    [SVProgressHUD show];
    if (!image1 || !image2) {
        [self submitChangeRewardWithValue:value imageUrl1:nil imageUrl2:nil block:block];
        return;
    }
    
    NSData *imageData1 = UIImageJPEGRepresentation(image1, 0.3);
    UpLoadFileModel *file1 = [UpLoadFileModel new];
    file1.dataFromWay = OSSUpLoadDataFromWayData;
    file1.fileData = imageData1;
    file1.UpLoadType = OSSUpLoadDataTypeFile;
    file1.index = 0;
    file1.fileName = @"png".randomStrForURL;
    
    NSData *imageData2 = UIImageJPEGRepresentation(image2, 0.3);
    UpLoadFileModel *file2 = [UpLoadFileModel new];
    file2.dataFromWay = OSSUpLoadDataFromWayData;
    file2.fileData = imageData2;
    file2.UpLoadType = OSSUpLoadDataTypeFile;
    file2.index = 1;
    file2.fileName = @"png".randomStrForURL;
    
   __block NSString *imageUrl1 = nil;
   __block NSString *imageUrl2 = nil;
    
    [[OssService service] asyncPutFiles:@[file1,file2] oneCompletion:^(int index, UpLoadFileModel *backModel) {
        if (index == 0) {
            imageUrl1 = backModel.fileName;
        }else if (index == 1) {
            imageUrl2 = backModel.fileName;
        }
        
        SDLog(@"imageUrl_%d : \n%@",index,backModel.fileName);
    } allCompletion:^{
        [self submitChangeRewardWithValue:value imageUrl1:imageUrl1 imageUrl2:imageUrl2 block:block];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"上传图片失败！"];
    }];
};

+ (void)submitChangeRewardWithValue:(NSString *)value
                             imageUrl1:(NSString *)imageUrl1
                             imageUrl2:(NSString *)imageUrl2
                              block:(SimpleBoolBlock)block{
 
    NewParams;
    [params setSafeObject:value forKey:@"shareComp13"];
    [params setSafeObject:value forKey:@"shareComp14"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.memberId forKey:@"memberId"];
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.Id forKey:@"merchantId"];
    [params setSafeObject:imageUrl1 forKey:@"rentalAgreement"];
    [params setSafeObject:imageUrl2 forKey:@"handRentalAgreement"];
    
    ZZNetWorker.POST.zz_param(params)
//    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_url(@"/merchant-biz/merchantUserUpdate/addMerchantUpdateInfo")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (!model_net.success) {
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        if (block) {
            block(model_net.success);
        }
    });
}

+ (void)getLastRewardWithBlock:(void (^)(RewardRecordModel *model))block{
    
    if (CurrentUser.lzUserType == LZUserTypeMember) {
        if (block) {
            block(nil);
        }
        return;
    }
    
    NewParams;
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.Id forKey:@"merchantId"];
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/merchant-biz/merchantUserUpdate/selectMerchantUpdateInfo")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            NSArray *arr = model_net.data;
            RewardRecordModel *record;
            if (arr.count) {
                record = [RewardRecordModel mj_objectWithKeyValues:arr.lastObject];
            }
            
            if (block) {
                block(record);
            }
        }else {
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

@end
