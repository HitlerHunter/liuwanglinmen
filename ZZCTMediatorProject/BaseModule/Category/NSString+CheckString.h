//
//  NSString+CheckString.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/16.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckString)

@property (nonatomic, strong, readonly) NSString *notNull;
@property (nonatomic, strong, readonly) NSString *MD5;
/**15555555555 -> 155****5555 */
@property (nonatomic, strong, readonly) NSString *phoneTakeSecure;
@property (nonatomic, strong, readonly) NSString *phoneRemoveM;

@property (nonatomic, assign, readonly) BOOL isMobilePhone;
/**合法身份证*/
@property (nonatomic, assign, readonly) BOOL isUserId;
/**银行卡验证*/
@property (nonatomic, assign, readonly) BOOL isBankCard;
/**字符串表情检测*/
@property (nonatomic, assign, readonly) BOOL hasEmoji;

/**电话号码*/
+(BOOL)isMobilePhone:(NSString *)phoneNum;
/**身份证*/
+(BOOL)checkUserID:(NSString *)userID;
/**车牌号*/
+(BOOL)checkCarID:(NSString *)carID;
/**核对密码格式,6~16位数字/字母/下划线*/
+(BOOL)checkPsw:(NSString *)pswStr;
//银行卡验证
+(BOOL)isBankCard:(NSString *)bankCard;
//验证邮箱地址
+(BOOL)isEmail:(NSString *)email;

+ (NSString *)formatIntString:(NSString *)str;
+ (NSString *)formatFloatString:(NSString *)str;
+ (NSString *)formatFloatValue:(CGFloat)value;
/**金额：分转元*/
+ (NSString *)formatMoneyCentToYuanString:(NSString *)str;
@end
