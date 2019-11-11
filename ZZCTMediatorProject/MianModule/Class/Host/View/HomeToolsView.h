//
//  HomeToolsView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomeToolsView;
@protocol HomeToolsViewDelegate <NSObject>
- (void)HomeToolsView:(HomeToolsView *)toolsView clickTitle:(NSString *)title;
@end

@interface HomeToolsView : SDBaseView

@property (nonatomic, strong) NSArray *toolsArray;
@property (nonatomic, weak) id <HomeToolsViewDelegate> delegate;

@property (nonatomic, assign) NSInteger maxCountOneLine;
@property (nonatomic, assign) CGFloat topSpacing;

- (void)updateToolsArray:(NSArray *)toolsArray;
@end

NS_ASSUME_NONNULL_END
