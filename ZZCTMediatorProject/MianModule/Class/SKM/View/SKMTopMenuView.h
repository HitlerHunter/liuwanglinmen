//
//  SKMTopMenuView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKMTopMenuView : SDBaseView
/** index = 0,1 */
@property (nonatomic, strong) void (^btnClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
