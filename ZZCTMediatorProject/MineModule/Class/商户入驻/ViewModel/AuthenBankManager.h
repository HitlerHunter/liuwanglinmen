//
//  AuthenBankManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/23.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthenBankModel : NSObject

@property (nonatomic, strong) NSString *bankId;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *bankCode;
@property (nonatomic, strong) NSString *bankBranch;
@property (nonatomic, strong) NSString *upCode;

@end

@interface AuthenBankManager : NSObject

@property (nonatomic, strong) NSString  *searchStr;

/**带支行数据*/
//@property (nonatomic, strong) NSArray <AuthenBankModel *> *bankBranchArray;

//- (void)getBankName:(void (^)(NSArray <AuthenBankModel *> *bankArray))block;

#pragma mark - 获取银行
+ (void)ShowBankListChoiceController:(UINavigationController *)nav
                               block:(void (^)(NSString *bankName))block;

- (void)SearchBankListWithBlock:(void (^)(NSArray *dataArray))block;

#pragma mark - 获取支行
+ (void)ShowBankBranchListChoiceControllerWithBankName:(NSString *)bankName
                                                   nav:(UINavigationController *)nav
                                                 block:(void (^)(NSString *bankName))block;
/**获取支行*/
- (void)SearchBankBranchListWithBankName:(NSString *)bankName
                                   block:(void (^)(NSArray *dataArray))block;
@end

NS_ASSUME_NONNULL_END
