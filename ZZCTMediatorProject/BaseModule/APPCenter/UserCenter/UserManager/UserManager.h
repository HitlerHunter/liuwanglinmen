//
//  UserManager.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZUser.h"
#import "LZUserWallet.h"
#import "LZUserMerchant.h"

#define CurrentUser [UserManager shareInstance].user
#define CurrentUserWallet [UserManager shareInstance].wallet
#define CurrentUserMerchant [UserManager shareInstance].merchant

@interface UserManager : NSObject

@property (nonatomic, strong) LZUser *user;
@property (nonatomic, strong) LZUserWallet *wallet;
@property (nonatomic, strong) LZUserMerchant *merchant;

+ (UserManager *)shareInstance;

- (void)refreshToken:(void (^)(BOOL isTokenValid))block;
- (void)refreshUserLevelAndTypeInfo;
- (void)getUserInfo:(void (^)(BOOL isSuccess))block;
- (void)getUserWallet;
- (void)getUserMerchant:(void (^)(LZUserMerchant *merchant))block;

- (void)changeUserInfo:(NSDictionary *)params block:(void (^)(void))block;
@end
