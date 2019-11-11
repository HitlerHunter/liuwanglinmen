//
//  UserInfoShowView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserLevelButton : UIButton


@end

@interface UserInfoShowView : SDBaseView

@property (nonatomic, assign) BOOL showEditBtn;
@property (nonatomic, assign) BOOL showAbleInfo;
@end

NS_ASSUME_NONNULL_END
