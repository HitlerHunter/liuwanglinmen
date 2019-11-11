//
//  HomeMessageModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/5/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMessageModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createdTime;

@end

NS_ASSUME_NONNULL_END
