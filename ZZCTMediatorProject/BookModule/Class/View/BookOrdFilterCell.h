//
//  BookOrdFilterCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const FilterClearAllNotificationName = @"FilterClearAllNotificationName";

@class FilterCellModel;
@interface BookOrdFilterCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) FilterCellModel *model;

@property (nonatomic, strong) void (^showBlock)(void);
@property (nonatomic, strong) void (^clickBlock)(void);
@end
