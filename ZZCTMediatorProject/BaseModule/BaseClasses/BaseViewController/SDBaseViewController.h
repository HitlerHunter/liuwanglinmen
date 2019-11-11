//
//  SDBaseViewController.h
//  YaYingInternational
//
//  Created by 曾立志 on 2017/12/24.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDBaseItemBtn : UIButton

@end

@interface SDBaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL hiddenNavgationBar;
/** 是否隐藏 TabBar */
@property (nonatomic, assign, readonly) BOOL hasHiddenTabBar;
@property (nonatomic, assign, readonly) BOOL willAddTap;
@property (nonatomic, assign, readonly) BOOL needDismissHUD;
@property (nonatomic, assign, readonly) BOOL willAddBackButton;

@property (nonatomic, assign,readonly) CGFloat contentHeight;

- (instancetype)initWithStyle:(UITableViewStyle)style;
/** to endEditing */
- (void)selfViewTap;
/** 返回按钮的图标 */
- (NSString *)backIconName;
/** 设置状态栏颜色 */
- (void)setStatusBarBackgroundColor:(UIColor *)color;

- (void)addLeftItemWithImage:(NSString *)imageName
                       title:(NSString *)title
                        font:(UIFont *)font
                       color:(UIColor *)color
                       block:(void (^)(void))block;

- (void)replaceLeftItemWithImage:(NSString *)imageName
                           title:(NSString *)title
                            font:(UIFont *)font
                           color:(UIColor *)color
                           block:(void (^)(void))block;

- (void)addRightItemWithImage:(NSString *)imageName
                        title:(NSString *)title
                         font:(UIFont *)font
                        color:(UIColor *)color
                        block:(void (^)(void))block;

- (void)addLeftDismissBtn;
- (void)addLeftCancelBtn;
-(void)lz_popController;
-(void)lz_popControllerAfterDelay:(NSTimeInterval)delay;

- (void)showMessage:(NSString *)message;
- (void)zz_dealloc;
- (void)updateDefaultConfig;

    //加载
- (void)showLoadingDataView;
- (void)dismissLoadingDataView;
- (void)selfViewTap;
@end
