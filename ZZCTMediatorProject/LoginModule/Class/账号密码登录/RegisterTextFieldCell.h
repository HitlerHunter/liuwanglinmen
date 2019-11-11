//
//  RegisterTextFieldCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RegisterTextFieldCellStyle) {
    RegisterTextFieldCellStyleNomal,
    RegisterTextFieldCellStyleSecureTextEntry,
    RegisterTextFieldCellStyleCode,
};

@interface RegisterTextFieldCell : SDBaseView

@property (nonatomic, strong) void (^getCodeBlock)(void);
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *getCodeBtn;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (assign, nonatomic) NSInteger maxLength;

- (instancetype)initWithStyle:(RegisterTextFieldCellStyle)style;
@end

NS_ASSUME_NONNULL_END
