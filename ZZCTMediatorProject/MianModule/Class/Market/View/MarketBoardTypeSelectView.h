//
//  MarketBoardTypeSelectView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MarketBoardTypeSelectView;
@protocol MarketBoardTypeSelectViewDelegate <NSObject>

- (void)lz_view:(MarketBoardTypeSelectView *)selectView atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface MarketBoardTypeSelectView : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) id <MarketBoardTypeSelectViewDelegate> delegate;

//当前选中的title
@property (nonatomic, strong) NSString *selectedTitle;

- (void)selectBtnAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
