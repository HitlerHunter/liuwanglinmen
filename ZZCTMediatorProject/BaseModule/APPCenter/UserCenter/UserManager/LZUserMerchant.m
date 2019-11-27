//
//  LZUserMerchant.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZUserMerchant.h"

@implementation MerchantInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (AuthenMerchantStatus)status_lz{
    if (_status.integerValue == 0
        || _status.integerValue == 1
        || _status.integerValue == 3) {
        return AuthenMerchantStatusReviewing;
    }else if (_status.integerValue == 2
        || _status.integerValue == 8) {
        return AuthenMerchantStatusRefund;
    }else if (_status.integerValue == 5
              || _status.integerValue == 9
              || _status.integerValue == 7
              || _status.integerValue == 11) {
        return AuthenMerchantStatusSuccess;
    }else if (_status.integerValue == -1) {
        return AuthenMerchantStatusNoSubmit;
    }
    
    return AuthenMerchantStatusNoSubmit;
}

@end

@implementation MerchantPicture
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
@end

@implementation Settlement
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
@end

@implementation Sharecomp
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
@end

@implementation LZUserMerchant
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

+ (LZUserMerchant *)creatMerchant{
    LZUserMerchant *merchant = [LZUserMerchant new];
    merchant.pmsMerchantInfo = [MerchantInfo new];
    merchant.pmsMerchantPicture = [MerchantPicture new];
    merchant.pmsMerchantSharecomp = [Sharecomp new];
    merchant.pmsMerchantSettlement = [Settlement new];
    
    merchant.pmsMerchantInfo.status = @"-1";
    return merchant;
}
@end

NSString* getMerchantTypeNameWithType(NSString *type){
    if (type.intValue == 1) {
        return @"政府机构";
    }else if (type.intValue == 2) {
        return @"国营企业";
    }else if (type.intValue == 3) {
        return @"私营企业";
    }else if (type.intValue == 4) {
        return @"外资企业";
    }else if (type.intValue == 5) {
        return @"个体工商户";
    }else if (type.intValue == 7) {
        return @"事业单位";
    }
    
    return @"";
}

NSString* checkMerchantVauleWithMerchant(LZUserMerchant *merchant){
    
    if (merchant.pmsMerchantInfo.merchantName) {
        return @"请填写";
    }
    
    return @"";
}
