//
//  SYHomeViewModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/13.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYHomeViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *type;

+(void)getTypeList:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
