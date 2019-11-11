//
//  LZLodingButton.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/5/8.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LZLodingButtonState) {
    LZLodingButtonStateNormal = 10,
    LZLodingButtonStateLoading,
};

@interface LZLodingButton : UIButton

@property (nonatomic, assign) LZLodingButtonState loadState;

@property (nonatomic, strong) NSString *normalText;
@property (nonatomic, strong) NSString *loadingText;

@property (nonatomic, strong) UIColor *normalBackGroundColor;
@property (nonatomic, strong) UIColor *loadingBackGroundColor;
@property (nonatomic, strong) UIColor *disabledColor;

@property (nonatomic, strong) void (^clickReturn)(LZLodingButton *sender);

- (void)loading;
- (void)stopLoading;

- (void)configText:(NSString *)text
       loadingText:(NSString *)loadingText;



- (void)configInit;
@end
