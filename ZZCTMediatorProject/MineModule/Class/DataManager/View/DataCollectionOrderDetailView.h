//
//  DataCollectionOrderDetailView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCollectionOrderDetailView : SDBaseView

@property (nonatomic, strong) UILabel *label_alipay;
@property (nonatomic, strong) UILabel *label_wechat;

- (void)refreshAlipayProgress:(CGFloat)progress;
- (void)refreshChatAnimation;
@end

NS_ASSUME_NONNULL_END
