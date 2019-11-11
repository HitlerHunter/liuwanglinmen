//
//  ChoicePersonViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChoicePersonViewController : SDBaseViewController

@property (nonatomic, strong) void (^selectedBlock)(NSString *title,NSString *Id);
@end

NS_ASSUME_NONNULL_END
