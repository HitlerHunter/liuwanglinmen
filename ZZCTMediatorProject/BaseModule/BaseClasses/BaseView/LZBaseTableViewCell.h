//
//  LZBaseTableViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/12.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;

@property (nonatomic, assign) CGFloat toplineSpacingX;
@property (nonatomic, assign) CGFloat toplineSpacingRightX;
@property (nonatomic, assign) CGFloat bottomlineSpacingX;
@property (nonatomic, assign) CGFloat bottomlineSpacingRightX;

- (void)initUI;
- (void)setBottomLineX:(CGFloat)spacingX;
- (void)setTopLineX:(CGFloat)spacingX;


- (void)addTopLine;
- (void)addBottomLine;
@end

NS_ASSUME_NONNULL_END
