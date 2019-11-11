//
//  SYHomeTypeView.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SYHomeTypeView;
@protocol SYHomeTypeViewDelegate <NSObject>

- (void)view:(SYHomeTypeView *)view clickBtnAtIndex:(NSInteger)index;

@end

@interface SYHomeTypeMaker : NSObject

@property (nonatomic, assign) CGFloat spaceX;
@property (nonatomic, assign) CGFloat firstItemSpaceX;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIFont *titleFontNormal;
@property (nonatomic, strong) UIColor *titleColorNormal;
@property (nonatomic, strong) UIColor *titleColorSelected;
@property (nonatomic, strong) UIColor *lineColor;
/**按钮最小width*/
@property (nonatomic, assign) CGFloat minItemW;
/**line的width 与 title width 的比值*/
@property (nonatomic, assign) CGFloat lineWScale;
@property (nonatomic, assign) CGFloat titleSelectedScale;
@property (nonatomic, assign) UIEdgeInsets lineEdgeInsets;
@end

@interface SYHomeTypeView : UIView


@property (nonatomic, weak) id <SYHomeTypeViewDelegate> delegate;

- (void)initWithTitleArray:(NSArray *)array;
- (instancetype)initWithFrame:(CGRect)frame
                        maker:(void (^)(SYHomeTypeMaker *maker))maker;
@end

NS_ASSUME_NONNULL_END
