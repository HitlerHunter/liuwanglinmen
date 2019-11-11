//
//  MarketMessagePayWayView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MarketMessagePayWayView,MarketMessagePayWayModel;
@protocol MarketMessagePayWayViewDelegate <NSObject>

- (void)lz_messagePayWaySelectedAtIndex:(NSInteger)index model:(MarketMessagePayWayModel *)model;

@end

@interface  MarketMessagePayWayModel : NSObject

@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSeleceted;
@end

@interface  MarketMessagePayWayViewCell : SDBaseView

@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) MarketMessagePayWayModel *model;
@end

@interface MarketMessagePayWayView : SDBaseView

@property (nonatomic, strong) NSArray <MarketMessagePayWayModel *> *dataArray;

@property (nonatomic, weak) id <MarketMessagePayWayViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
