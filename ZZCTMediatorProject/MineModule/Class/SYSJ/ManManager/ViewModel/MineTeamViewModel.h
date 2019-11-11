//
//  MineTeamViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ManManagerModel;
@interface MineTeamViewModel : NSObject

+ (void)getMineTeamData:(void (^)(NSDictionary *dic
                                  ,NSArray <ManManagerModel *>*elseUserList
                                  ,NSArray <ManManagerModel *>*myUserList))block;
@end

NS_ASSUME_NONNULL_END
