//
//  AdvertManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, AdvertType) {
    AdvertTypeMine = 1,
    AdvertTypeHome = 2,
    AdvertTypeOther = 3,
};

@interface AdvertModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *func;
@property (nonatomic, assign) NSInteger redirectFlag;
@property (nonatomic, strong) NSString *redirectUrl;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, strong) NSString *remark;
@end

@interface AdvertManager : NSObject

+ (void)getAdvertWithType:(AdvertType)type block:(void (^)(NSArray <AdvertModel *>*arr))block;
/**跳转*/
+ (void)tapAdvertModel:(AdvertModel *)model withController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
