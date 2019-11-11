//
//  ListChoiceView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ListChoiceViewDelegate <NSObject>

- (void)lz_listClickAtIndex:(NSInteger)index title:(NSString *)title;

@end
@interface ListChoiceView : SDBaseView

@property (nonatomic, weak) id <ListChoiceViewDelegate> delegate;

- (void)showWithSuperView:(UIView *)superView;
- (void)dismiss;

- (void)refreshDataWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
