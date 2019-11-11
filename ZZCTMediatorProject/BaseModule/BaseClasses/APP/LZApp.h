//
//  LZApp.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/11.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZApp : NSObject
@property (nonatomic, assign, readonly) CGFloat app_statusBarHeight;
@property (nonatomic, assign) CGFloat app_navigationBarHeight;
@property (nonatomic, assign) CGFloat app_tabbarHeight;

+ (LZApp *)shareInstance;
+ (void)launch;
@end

NS_ASSUME_NONNULL_END
