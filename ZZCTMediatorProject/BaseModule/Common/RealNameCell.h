//
//  RealNameCell.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/22.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RealNameModel;
@interface RealNameCell : LZBaseTableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) RealNameModel *model;
@property (nonatomic, strong) void (^scanBlock)(RealNameModel *scanModel);

- (void)hiddenTextField;
@end
