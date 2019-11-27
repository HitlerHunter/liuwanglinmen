//
//  AppInfoModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppInfoModel : NSObject

@property (nonatomic, assign) BOOL force;
/**是否生效*/
@property (nonatomic, assign) BOOL valid;
@property (nonatomic, strong) NSString *iosVersion;

@property (nonatomic, strong) NSString *iosDownUrl;
@property (nonatomic, strong) NSString *iosUrl;
@property (nonatomic, strong) NSString *remark;

@end

NS_ASSUME_NONNULL_END
