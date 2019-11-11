//
//  SPKeyBoard.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SPKeyBoardHeight kScreenWidth*0.8

@protocol SPKeyBoardProtocol <NSObject>

- (void)makeSureWithNumber:(NSString *)number;

@optional
- (void)willDismiss;
@end


@interface SPKeyBoard : UIView

@property (nonatomic, weak) UILabel *inputView;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UIColor *sureBtnColor;
@property (nonatomic, strong) UIColor *sureBtnEmptyColor;
@property (nonatomic, strong) NSString *sureText;

@property (nonatomic, assign) double maxValue;
@property (nonatomic, assign) double minValue;

@property (nonatomic, weak) id <SPKeyBoardProtocol> delegate;

- (void)makeSureBtnEnable;
- (void)setNumber:(NSString *)number;

- (void)show;
- (void)dismiss;
@end
