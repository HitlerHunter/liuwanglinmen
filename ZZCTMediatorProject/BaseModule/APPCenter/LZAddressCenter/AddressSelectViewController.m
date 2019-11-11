//
//  AddressSelectViewController.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "AddressSelectViewController.h"
#import "LZAddressCenter.h"
#import "LZAddressModelProtocol.h"

@interface AddressSelectViewController ()
@property (nonatomic, assign) AddressSelectType type;
@property (nonatomic, strong) NSString *superId;
@end

@implementation AddressSelectViewController

- (instancetype)initWithType:(AddressSelectType)type
                     superId:(NSString *)superId
                      center:(LZAddressCenter *)center{
    self = [super init];
    if (self) {
        _type = type;
        _superId = superId;
        _center = center;
    }
    return self;
}

- (BOOL)hasHiddenTabBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地区";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddressCell"];
    
    [self.center getDataWithType:_type superId:_superId block:^(NSArray *datas) {
        [self.dataArray addObjectsFromArray:datas];
        [self.tableView reloadData];
    }];
    
    if (self.navigationController.viewControllers.count == 1) {
        WeakSelf(weakSelf);
        [self addRightItemWithImage:nil title:@"取消" font:nil color:nil block:^{
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
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
    id <LZAddressModelProtocol> address = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    
    cell.textLabel.text = address.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id <LZAddressModelProtocol> address = self.dataArray[indexPath.row];
    
    AddressSelectType nextType = AddressSelectTypeProvince;
    if (self.type == AddressSelectTypeProvince) {
        
        nextType = AddressSelectTypeCity;
        self.center.apiRequest.province = address.name;
        self.center.apiRequest.provinceCode = address.code;
    }else if (self.type == AddressSelectTypeCity) {
        
        nextType = AddressSelectTypeDistrict;
        self.center.apiRequest.city = address.name;
        self.center.apiRequest.cityCode = address.code;
    }else if (self.type == AddressSelectTypeDistrict) {
        
        self.center.apiRequest.district = address.name;
        self.center.apiRequest.districtCode = address.code;
        [self.center finishBack];
        return;
    }
    
    if (self.center.finishStep == self.type) {
        [self.center finishBack];
        return;
    }
    
    AddressSelectViewController *nextAddress = [[AddressSelectViewController alloc] initWithType:nextType superId:address.code center:self.center];
    
    PushController(nextAddress);
};


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
