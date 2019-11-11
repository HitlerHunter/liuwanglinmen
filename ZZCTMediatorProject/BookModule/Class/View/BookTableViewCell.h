//
//  BookTableViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookListModel;

@interface BookTableViewCell : LZBaseTableViewCell

@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UILabel *label_money;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) BookListModel *model;
@end
