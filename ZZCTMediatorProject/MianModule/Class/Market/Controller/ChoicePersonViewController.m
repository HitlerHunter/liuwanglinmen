//
//  ChoicePersonViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChoicePersonViewController.h"
#import "ChoicePersonCell.h"
#import "PersonTagsModel.h"

@interface ChoicePersonViewController ()

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation ChoicePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择发送对象";
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    
    [self.tableView registerClass:[ChoicePersonCell class] forCellReuseIdentifier:@"ChoicePersonCell"];
    
    [self requestData];
}

- (void)requestData{
    
    NSArray *arr = @[@{@"name":@"未交易用户",@"type":@"trade"},
                     @{@"name":@"领劵用户",@"type":@"coupon"},
                     @{@"name":@"直推用户",@"type":@"direct"}];
    
    self.dataArray = [PersonTagsModel mj_objectArrayWithKeyValuesArray:arr];
    
    [self.tableView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    if (self.selectedBlock && self.dataArray.count) {
        PersonTagsModel *model = self.dataArray[0];
        self.selectedBlock(model.name, model.type);
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
    PersonTagsModel *model = self.dataArray[indexPath.row];
    
    ChoicePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChoicePersonCell"];

    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedIndex = indexPath.row;
    
    if (self.selectedBlock) {
        PersonTagsModel *model = self.dataArray[indexPath.row];
        self.selectedBlock(model.name, model.type);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
