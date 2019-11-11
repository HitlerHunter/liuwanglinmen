//
//  DataCollectionNavBar.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCollectionNavBar : SDBaseView

@property (nonatomic, strong) void (^rightBtnBlock)(UIButton *btn);
@property (nonatomic, strong) NSString *rightTitle;
@property (nonatomic, strong) UIButton *rightBtn;
@end

NS_ASSUME_NONNULL_END
