//
//  SDBaseViewController.m
//  YaYingInternational
//
//  Created by 曾立志 on 2017/12/24.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

#import "SDBaseViewController.h"
#import "ZZDataLodingView.h"
#import <objc/runtime.h>
@interface SDBaseItemBtn ()

@end

@implementation SDBaseItemBtn

- (CGSize)intrinsicContentSize{
    return CGSizeMake(60, 44);
}
@end

@interface SDBaseViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) NSMutableArray *leftItems;
@property (nonatomic, strong) NSMutableArray *leftItemBlocks;
@property (nonatomic, strong) void (^rightBlock)(void);

@property (nonatomic, assign) BOOL hasConfig;

@property (nonatomic, strong) ZZDataLodingView *loadingView;
@end

@implementation SDBaseViewController

- (void)dealloc{
    
    SDLog(@"dealloc-%@",NSStringFromClass([self class]));
    [self zz_dealloc];
}

- (void)zz_dealloc{
    if (self.needDismissHUD) {
        [SVProgressHUD dismiss];
    }
}

- (BOOL)needDismissHUD{
    return NO;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super init];
    if (self) {
        _tableViewStyle = style;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}



#pragma mark - viewDidLoad

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_hasConfig) {
        _hasConfig = YES;
        
        if (self.willAddBackButton) {
            WeakSelf(weakSelf);
            [self addLeftItemWithImage:self.backIconName title:@"" font:nil color:nil block:^{
                [weakSelf lz_popController];
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    if (@available(iOS 11.0, *)) {
        
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (self.willAddTap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTap)];
        tap.delegate = self;
        [self.view addGestureRecognizer:tap];
    }
    
    self.view.backgroundColor = LZBackgroundColor;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

-(void)lz_popController{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)lz_popControllerAfterDelay:(NSTimeInterval)delay{
    [self performSelector:@selector(lz_popController) withObject:nil afterDelay:delay];
}

- (void)updateDefaultConfig{
    
}

- (NSString *)backIconName{
    return @"fanhui_hui";
}

- (void)addLeftDismissBtn{
    WeakSelf(weakSelf);
    [self addLeftItemWithImage:[self backIconName] title:@"" font:nil color:nil block:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)addLeftCancelBtn{
    WeakSelf(weakSelf);
    [self addLeftItemWithImage:nil title:@"取消" font:nil color:nil block:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)selfViewTap{
    [self.view endEditing:YES];
}

- (BOOL)willAddTap{
    return NO;
}

- (BOOL)willAddBackButton{
    return self.navigationController.viewControllers.count>1;
}

#pragma mark tapGestureRecgnizerdelegate 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view == self.view) {
        return YES;
    }
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    if ([touch.view isKindOfClass:[UITableView class]]){
        return YES;
    }
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}


#pragma mark - navBarItems
- (void)replaceLeftItemWithImage:(NSString *)imageName
                       title:(NSString *)title
                        font:(UIFont *)font
                       color:(UIColor *)color
                       block:(void (^)(void))block{
    
    [self.leftItems removeAllObjects];
    
    [self addLeftItemWithImage:imageName
                         title:title
                          font:font
                         color:color
                         block:block];
}
- (void)addLeftItemWithImage:(NSString *)imageName
                       title:(NSString *)title
                        font:(UIFont *)font
                       color:(UIColor *)color
                       block:(void (^)(void))block{
    
    //定制左按钮
    SDBaseItemBtn *but = [SDBaseItemBtn buttonWithType:UIButtonTypeCustom];
    but.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    but.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    but.frame = CGRectMake(0,0, 60, 44);
    
    if (title) {
        [but setTitle:title forState:UIControlStateNormal];
    }
    
    if (imageName) {
        [but setImage:UIImageName(imageName) forState:UIControlStateNormal];
    }
    
    if (font) {
        but.titleLabel.font = font;
    }else{
        but.titleLabel.font = kfont(14);
    }
    
    if (color) {
        [but setTitleColor:color forState:UIControlStateNormal];
    }else{
        [but setTitleColor:LZNavBarTitleColor forState:UIControlStateNormal];
    }
    
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [but addTarget:self action:@selector(leftItemAction:)forControlEvents:UIControlEventTouchUpInside];

    objc_setAssociatedObject(but, @"block", block, OBJC_ASSOCIATION_COPY);
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    
    [self.leftItems addObject:barBut];
//    self.navigationItem.hidesBackButton = YES; 
    [self.navigationItem setLeftBarButtonItems:self.leftItems];
    
}

- (void)leftItemAction:(UIButton *)btn{
    
    void (^block)(void) = objc_getAssociatedObject(btn, @"block");
    
    if (block) {
        block();
    }
}

- (void)addRightItemWithImage:(NSString *)imageName
                       title:(NSString *)title
                        font:(UIFont *)font
                       color:(UIColor *)color
                       block:(void (^)(void))block{
    
    //定制左按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0,0, 70, 44);
   
    if (title) {
         [but setTitle:title forState:UIControlStateNormal];
        but.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (imageName) {
        [but setImage:UIImageName(imageName) forState:UIControlStateNormal];
        but.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    }
    
    if (font) {
        but.titleLabel.font = font;
    }else{
        but.titleLabel.font = Font_PingFang_SC_Regular(14);
    }
    
    if (color) {
        [but setTitleColor:color forState:UIControlStateNormal];
    }else{
        [but setTitleColor:rgb(101,101,101) forState:UIControlStateNormal];
    }
    
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [but addTarget:self action:@selector(rightItemAction:)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
    
    _rightBlock = block;
}

- (void)rightItemAction:(UIButton *)btn{
    
    if (_rightBlock) {
        _rightBlock();
    }
}

#pragma mark - 加载
- (void)showLoadingDataView{
    if (!self.loadingView.superview) {
        [self.view addSubview:self.loadingView];
    }
    [_loadingView loading];
}

- (void)dismissLoadingDataView{
    [_loadingView stopLoding];
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

- (ZZDataLodingView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[ZZDataLodingView alloc] initWithFrame:CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight, kScreenWidth, [self contentHeight])];
    }
    return _loadingView;
}
#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - setting
- (BOOL)hiddenNavgationBar{
    return NO;
}

- (BOOL)hasHiddenTabBar{
    return self.navigationController.viewControllers.count>1;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)fd_prefersNavigationBarHidden{
    return self.navigationController.isNavigationBarHidden;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)showMessage:(NSString *)message{
    [SVProgressHUD showImage:nil status:message];
}

#pragma mark - lazyLoad
- (CGFloat)contentHeight{
    CGFloat height = kScreenHeight;
    
    if (!self.hiddenNavgationBar) {
        height -= LZApp.shareInstance.app_navigationBarHeight;
    }
    
    if (!self.hasHiddenTabBar) {
        height -= LZApp.shareInstance.app_tabbarHeight;
    }
    
    return height;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        CGFloat topY = self.hiddenNavgationBar?0:LZApp.shareInstance.app_navigationBarHeight;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topY, kScreenWidth, [self contentHeight])];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.backgroundColor = LZBackgroundColor;
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (UITableView *)tableView{
    if (!_tableView) {

        CGFloat topY = self.hiddenNavgationBar?0:LZApp.shareInstance.app_navigationBarHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topY, kScreenWidth, [self contentHeight]) style:_tableViewStyle];


        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;

        _tableView.delegate = self;
        _tableView.dataSource = self;

        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;

        _tableView.allowsSelection = YES;

        _tableView.backgroundColor = LZBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)leftItems{
    if (!_leftItems) {
        _leftItems = [NSMutableArray array];
    }
    return _leftItems;
}

- (NSMutableArray *)leftItemBlocks{
    if (!_leftItemBlocks) {
        _leftItemBlocks = [NSMutableArray array];
    }
    return _leftItemBlocks;
}

#pragma mark - TableView 占位图

- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"note_list_no_data"];
}

- (NSString *)xy_noDataViewMessage {
    return @"";
}

- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
}

//- (UIView   *)xy_noDataView;                //  完全自定义占位图
//- (NSNumber *)xy_noDataViewCenterYOffset;   //  使用默认占位图, CenterY 向下的偏移量
@end
