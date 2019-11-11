//
//  LZUser.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenInfoModel.h"



@class SysUserModel,MemberDetailModel;
@interface LZUser : NSObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userType;//boss
@property (nonatomic, strong) NSString *authType;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *idCard;
@property (nonatomic, assign) NSInteger idType;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *nickUrl;
@property (nonatomic, strong) NSString *prov;
@property (nonatomic, strong) NSString *provName;
@property (nonatomic, strong) NSString *roles;
@property (nonatomic, assign) NSInteger refNo;
@property (nonatomic, assign) NSInteger rlFlag;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger userLvl;
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *usrNo;
@property (nonatomic, strong) NSString *usrType;

@property (nonatomic, assign) LZUserType lzUserType;

@property (nonatomic, strong,readonly) NSString *token;
/**是否开启语音播报*/
@property (nonatomic, assign) BOOL isCloseTTS;
/**是否开启消息推送*/
@property (nonatomic, assign) BOOL isOpenAppNotification;
- (void)OpenAppNotification:(BOOL)isOpen;
/**
 是否已经认证
 */
@property (nonatomic, assign, readonly) BOOL isAuthen;


- (void)loginOut;

@property (nonatomic, assign) CGFloat money;

////////// --- >废弃
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *agent;
@property (nonatomic, strong) NSString *cashier;
@property (nonatomic, strong) NSString *member;
@property (nonatomic, strong) MemberDetailModel *memberDetail;
@property (nonatomic, strong) NSString *merchant;

@property (nonatomic, strong) AuthenInfoModel *merchantFirst;
@property (nonatomic, strong) NSArray <AuthenInfoModel *> *merchantList;
@property (nonatomic, strong) NSArray *permissions;
@property (nonatomic, strong) SysUserModel *sysUser;
////////// <-----废弃

//是否认证
@property (nonatomic, assign) BOOL hasAuthen;
@end

@interface SysUserModel : NSObject

@property (nonatomic, strong) NSString *agent;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *cashier;
@property (nonatomic, strong) NSString *delFlag;
@property (nonatomic, strong) NSString *deptId;
@property (nonatomic, strong) NSString *member;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *systemAdmin;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *username;

@property (nonatomic, assign) LZUserType lzUserType;

@end

@interface MemberDetailModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *bindMerchant;
@property (nonatomic, strong) NSString *idCardCode;
@property (nonatomic, strong) NSString *isCashier;
@property (nonatomic, strong) NSString *isSalesman;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *qrcode;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *upUserNo;
@property (nonatomic, strong) NSString *jgRegistrationId;

@end
