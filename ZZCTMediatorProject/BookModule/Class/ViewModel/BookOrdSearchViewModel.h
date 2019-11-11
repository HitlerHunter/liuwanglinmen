//
//  BookOrdSearchViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class BookListModel;
@interface BookOrdSearchViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *searchStr;

@end

NS_ASSUME_NONNULL_END
