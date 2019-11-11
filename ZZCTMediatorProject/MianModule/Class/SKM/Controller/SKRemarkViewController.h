//
//  SKRemarkViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/15.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RemarkFinishReturn)(NSString *text);

@interface SKRemarkViewController : SDBaseViewController

- (instancetype)initWithBlock:(RemarkFinishReturn)block;
@end

NS_ASSUME_NONNULL_END
