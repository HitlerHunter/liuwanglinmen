//
//  CommenEnum.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#ifndef CommenEnum_h
#define CommenEnum_h

typedef NS_ENUM(NSUInteger, LZUserType) {
    /**商户*/
    LZUserTypeMerchant,
    /**会员*/
    LZUserTypeMember,
    /**系统用户*/
    LZUserTypeSystem,
    LZUserTypeUnknow,
};

static LZUserType getLZUserTypeWithType(NSString *str){
    if ([str isEqualToString:@"merchant"]) {
        return LZUserTypeMerchant;
    }else if ([str isEqualToString:@"member"]) {
        return LZUserTypeMember;
    }else if ([str isEqualToString:@"system"]) {
        return LZUserTypeSystem;
    }
    return LZUserTypeUnknow;
}


static NSString * getRoleNameWithLZUserTypeAndLevel(LZUserType type,NSInteger level){
    
    if (type == LZUserTypeMember) {
        switch (level) {
            case 0:
                return @"普通用户";
                break;
            case 1:
                return @"VIP用户";
                break;
            case 2:
                return @"服务商";
                break;
            case 3:
                return @"县/区独家运营商";
                break;
            case 4:
                return @"市级分公司";
                break;
            default:
                return @"";
                break;
        }
    }else if (type == LZUserTypeMerchant) {
        switch (level) {
            case 0:
                return @"商户";
                break;
            case 1:
                return @"VIP商户";
                break;
            case 2:
                return @"服务商";
                break;
            case 3:
                return @"县/区独家运营商";
                break;
            case 4:
                return @"市级分公司";
                break;
            default:
                return @"";
                break;
        }
    }else if (type == LZUserTypeSystem) {
        return @"系统用户";
    }
    
    return @"";
}

static NSString * getRoleIconWithLevel(NSInteger level){
    
    switch (level) {
        case 0:
            return @"level_0";
            break;
        case 1:
            return @"level_1";
            break;
        case 2:
            return @"level_2";
            break;
        case 3:
            return @"level_3";
            break;
        case 4:
            return @"level_4";
            break;
        default:
            return @"";
            break;
    }
    
    return @"";
}

#endif /* CommenEnum_h */
