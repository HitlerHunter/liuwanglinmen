//
//  BillViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "BillViewController.h"
#import "NinaPagerView.h"
#import "HooDatePicker.h"
#import "NinaPagerSonDelegate.h"

@interface BillViewController ()<NinaPagerViewDelegate,HooDatePickerDelegate>
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@property (nonatomic, strong) HooDatePicker *datePicker;
@property (nonatomic, weak) id <NinaPagerSonDelegate> currentVC;
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账单";
    
    [self.view addSubview:self.ninaPagerView];
    
    HooDatePicker *datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    datePicker.delegate = self;
    datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    
    _datePicker = datePicker;
    
    @weakify(self);
    [self addRightItemWithImage:@"calendar" title:nil font:nil color:nil block:^{
        @strongify(self);
        [self.datePicker show];
    }];
    
    _datePicker.title = @"选择时间";
}

- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    NSString *month = [NSString stringWithFormat:@"%lu",(unsigned long)date.month];
    NSString *year = [NSString stringWithFormat:@"%lu",(unsigned long)date.year];
    
    if (_currentVC && [_currentVC respondsToSelector:@selector(requestWithYear:month:)]) {
        [_currentVC requestWithYear:year month:month];
    }
}

- (NSArray *)ninaTitleArray {
    return @[
             @"收款",
             @"总收益",
             ];
}

- (NSArray *)ninaVCsArray {
    return @[
             @"BillRepayViewController",
             @"BillAllViewController",
             ];
}

#pragma mark - LazyLoad
- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        /**
         *  创建ninaPagerView，控制器第一次是根据您划的位置进行相应的添加的，类似网易新闻虎扑看球等的效果，后面再滑动到相应位置时不再重新添加，如果想刷新数据，您可以在相应的控制器里加入刷新功能。需要注意的是，在创建您的控制器时，设置的frame为FUll_CONTENT_HEIGHT，即全屏高减去导航栏高度，如果这个高度不是您想要的，您可以去在下面的frame自定义设置。
         *  A tip you should know is that when init the VCs frames,the default frame i set is FUll_CONTENT_HEIGHT,it means fullscreen height - NavigationHeight - TabbarHeight.If the frame is not what you want,just set frame as you wish.
         */
        CGRect pagerRect = CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithObjects:vcsArray];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
        _ninaPagerView.delegate = self;
        
        _ninaPagerView.underlineColor = UIColorHex(0x9D854C);
        _ninaPagerView.selectTitleColor = UIColorHex(0x9D854C);
        _ninaPagerView.unSelectTitleColor = UIColorHex(0xCAA74A);
        _ninaPagerView.topTabBackGroundColor = UIColorHex(0xF4EFDF);
        
    }
    return _ninaPagerView;
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage
               currentObject:(id <NinaPagerSonDelegate>)currentObject
                  lastObject:(id)lastObject{
    
    _currentVC = currentObject;
}

@end
