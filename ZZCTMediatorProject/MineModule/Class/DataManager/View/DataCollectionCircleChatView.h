//
//  DataCollectionCircleChatView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCollectionCircleChatView : SDBaseView

@property (nonatomic, assign) CGFloat alipayProgress;

- (void)refreshAlipayProgress:(CGFloat)progress;
- (void)refreshProgress;
@end

NS_ASSUME_NONNULL_END
