//
//  VipPersonDetailCellView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, VipPersonDetailCellStyle) {
    VipPersonDetailCellStyleVauleRight = 0,
    VipPersonDetailCellStyleVauleBottom,
    /**性别选择*/
    VipPersonDetailCellStyleVauleSexChioce,
    VipPersonDetailCellStyleVauleTextField,
    VipPersonDetailCellStyleVauleBottomImage,
};
@interface VipPersonDetailCellModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *vaule;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIColor *vauleTextColor;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) BOOL canTap;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, strong) NSString *tapImage;

@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) VipPersonDetailCellStyle cellStyle;

@property (nonatomic, strong) void (^clickBlock)(NSString *vauleStr);
@end

@interface VipPersonDetailCell : SDBaseView
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_vaule;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) VipPersonDetailCellModel *model;

@end

@interface VipPersonDetailCellView : SDBaseView

@property (nonatomic, strong) NSArray <VipPersonDetailCellModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
