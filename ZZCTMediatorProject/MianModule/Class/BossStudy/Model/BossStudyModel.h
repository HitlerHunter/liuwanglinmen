//
//  BossStudyModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BossStudyModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *jumpUrl;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *showTime;

@end

NS_ASSUME_NONNULL_END
