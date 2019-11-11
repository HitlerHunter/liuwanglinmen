//
//  RewardViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardViewController.h"
#import "NinaPagerView.h"
#import "RewardViewModel.h"
#import "RewardRecordModel.h"
#import "RewardStatusViewController.h"

@interface RewardViewController ()<NinaPagerViewDelegate>
@property (nonatomic, strong) NinaPagerView *pagerView;

@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"悬赏";
    
    
    NSArray *titles = @[@"同城悬赏",@"发布悬赏"];
    __block NSArray *vcs = @[@"RewardCityViewController",@"ChangeSalesPromotionVC"];
    
    [RewardViewModel getLastRewardWithBlock:^(RewardRecordModel *model) {
        
        if (model) {
            
            @weakify(self);
            [self addRightItemWithImage:nil title:@"悬赏记录" font:nil color:nil block:^{
                @strongify(self);
                [RewardViewModel pushToRewardRecordViewControllerWithNav:self.navigationController];
            }];
            
            RewardStatusViewController *vc = [[RewardStatusViewController alloc] initWithModel:model];
            vc.nav = self.navigationController;
            vcs = @[@"RewardCityViewController",vc];
        }else{
            
            
        }
        
        [self setUpPagerViewWithVCs:vcs titles:titles];
    }];
    
    
    
    
    
    
}

- (void)setUpPagerViewWithVCs:(NSArray *)vcs titles:(NSArray *)titles{
    
    _pagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:titles WithObjects:vcs];
    
    _pagerView.delegate = self;
    
    _pagerView.underlineColor = rgb(255,81,0);
    _pagerView.selectTitleColor = rgb(255,81,0);
    _pagerView.unSelectTitleColor = rgb(53,53,53);
    _pagerView.titleFont = 16;
    _pagerView.titleScale = 1;
    
    [self.view addSubview:_pagerView];
}

@end
