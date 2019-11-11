//
//  MineMessageModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineMessageModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *contentDic;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *sourceUserId;

@property (nonatomic, strong) NSString *sourceUserName;
@property (nonatomic, strong) NSString *aimUserId;
@property (nonatomic, strong) NSString *aimUserName;
@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, assign) BOOL haveRead;
@property (nonatomic, strong) NSString *property1;
@end

NS_ASSUME_NONNULL_END
