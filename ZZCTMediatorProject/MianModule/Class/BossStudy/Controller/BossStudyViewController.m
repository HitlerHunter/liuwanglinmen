//
//  BossStudyViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BossStudyViewController.h"
#import "BossStudy1ViewController.h"
#import "SYHomeTypeView.h"
#import "BossStudyViewModel.h"

@interface BossStudyViewController ()<SYHomeTypeViewDelegate>

@property (nonatomic, strong) SYHomeTypeView *typeScrollView;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *typeTitleArray;
@end

@implementation BossStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"财商课堂";
    
    [self.view addSubview:self.typeScrollView];
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, self.typeScrollView.bottom, kScreenWidth, kScreenHeight-self.typeScrollView.bottom);
    self.scrollView.scrollEnabled = NO;
    
    
    [BossStudyViewModel getTypeList:^(id  _Nullable obj) {
        NSArray *dicArray = obj;
        
        _typeArray = [NSMutableArray array];
        _typeTitleArray = [NSMutableArray array];
        [_typeTitleArray addObject:@"全部"];
        [_typeArray addObject:@""];
        
        
        for (NSDictionary *dic in dicArray) {
            [_typeArray addObject:dic[@"type"]];
            [_typeTitleArray addObject:dic[@"desc"]];
        }
        
        [self addUI];
    }];
    
    
    
}

- (void)addUI{
    
    [_typeScrollView initWithTitleArray:_typeTitleArray];
    
    for (int i = 0; i<_typeArray.count; i++) {
        BossStudy1ViewController *vc1 = [[BossStudy1ViewController alloc] initWithType:_typeArray[i]];
        vc1.view.frame = CGRectMake(kScreenWidth*i, 0, kScreenWidth, self.scrollView.height);
        
        [self addChildViewController:vc1];
        
        [self.scrollView addSubview:vc1.view];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*_typeArray.count, 10);
}

- (void)view:(SYHomeTypeView *)view clickBtnAtIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
    
};

- (SYHomeTypeView *)typeScrollView{
    if (!_typeScrollView) {
        _typeScrollView = [[SYHomeTypeView alloc] initWithFrame:CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight, kScreenWidth, 44) maker:^(SYHomeTypeMaker * _Nonnull maker) {
            
        }];
        
        _typeScrollView.delegate = self;
    }
    return _typeScrollView;
}

@end
