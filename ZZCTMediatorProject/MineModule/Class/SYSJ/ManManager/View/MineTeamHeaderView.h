//
//  MineTeamHeaderView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineTeamHeaderView : SDBaseView

@property (nonatomic, strong) UILabel *numberLabelLeft;
@property (nonatomic, strong) UILabel *numberLabelRight;

@property (nonatomic, strong) void (^btnClick)(NSInteger index);

@property (nonatomic, assign) NSInteger mineUserCount;
@property (nonatomic, assign) NSInteger otherCount;
@end

NS_ASSUME_NONNULL_END
