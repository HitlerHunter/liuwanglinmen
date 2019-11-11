//
//  IntegralRecordSectionHeader.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/9.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) void (^selectDateBlock)(NSString *lastDate);

@end

NS_ASSUME_NONNULL_END
