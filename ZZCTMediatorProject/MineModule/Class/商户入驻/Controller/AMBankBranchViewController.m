//
//  AMBankBranchViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AMBankBranchViewController.h"
#import "AuthenBankManager.h"
#import "SDCityPickerViewController.h"
#import "LZSearchBarView.h"
#import "SDCityModel.h"

@interface AMBankBranchViewController ()

@property (nonatomic, strong) AuthenBankManager *manager;
@property (nonatomic, strong) LZSearchBarView *searchBar;

@property (nonatomic, strong) SDCityPickerViewController *cityVc;
@property (nonatomic, strong) NSString  *bankName;
@end

@implementation AMBankBranchViewController

- (instancetype)initWithBankName:(NSString *)bankName{
    self = [super init];
    if (self) {
        self.bankName = bankName;
    }
    return self;
}

- (AuthenBankManager *)manager{
    if (!_manager) {
        _manager = [AuthenBankManager new];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"选择支行";
    
    _searchBar = [[LZSearchBarView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, 44)];
    [self.view addSubview:_searchBar];
    
    SDCityPickerViewController *city =[[SDCityPickerViewController alloc]init];
    city.cityPickerBlock = ^(SDCityModel *city){
        if (self.block) {
            self.block(city.name);
        }
    };
    
    @weakify(self);
    _searchBar.didReturnBlock = ^(NSString * _Nonnull str) {
        @strongify(self);
        self.manager.searchStr = str;
        [self search];
    };
    
    [self addChildViewController:city];
    [self.view addSubview:city.view];
    
    city.view.frame = CGRectMake(0, _searchBar.bottom, kScreenWidth, kScreenHeight-_searchBar.bottom);
    _cityVc = city;
    
    [self search];
    
}

- (void)search{
    @weakify(self);
    [self.manager SearchBankBranchListWithBankName:self.bankName block:^(NSArray * _Nonnull dataArray) {
        @strongify(self);
        self.cityVc.dataArr = (NSMutableArray *)dataArray;
    }];
}




@end
