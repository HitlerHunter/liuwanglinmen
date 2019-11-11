//
//  BossStudyViewModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossStudyViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *classify;

+(void)getTypeList:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
