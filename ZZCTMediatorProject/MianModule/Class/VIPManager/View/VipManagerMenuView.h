//
//  VipManagerMenuView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VipManagerMenuStatus) {
    VipManagerMenuStatusNoSelected,
    VipManagerMenuStatusUp,
    VipManagerMenuStatusDown,
    
    /**无交互*/
    VipManagerMenuStatusUnableStatus,
};

@protocol VipManagerMenuDelegate <NSObject>

- (void)VipManagerMenuDidSelectedWithTitle:(NSString *)title status:(VipManagerMenuStatus)status;

@end

@interface VipManagerMenuModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) VipManagerMenuStatus status;
+ (VipManagerMenuModel *)initWithTitle:(NSString *)title status:(VipManagerMenuStatus)status;
@end

@interface VipManagerMenuBtn : UIButton
@property (nonatomic, strong) VipManagerMenuModel *model;
@end

@interface VipManagerMenuView : SDBaseView

@property (nonatomic, weak) id <VipManagerMenuDelegate> delegate;

- (void)setSelectedAtIndex:(NSInteger)index;
- (void)initUIWithMenuModelArray:(NSArray <VipManagerMenuModel *>*)menuModelArray;
@end

NS_ASSUME_NONNULL_END
