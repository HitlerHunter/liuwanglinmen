//
//  LFLivenessManager.h
//  LFLivenessSample
//
//  Created by zenglizhi on 2018/8/9.
//  Copyright © 2018年 SunLin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LFLivenessManagerBlock)(BOOL isSuccess,UIImage *image);

@class UIViewController;
@interface LFLivenessManager : NSObject

@property (nonatomic, strong) LFLivenessManagerBlock block;

- (void)setViewController:(UIViewController *)viewController;
- (void)startDetect;
- (void)restart;
@end
