//
//  BookSearchViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookSearchViewController.h"
#import "BookTableViewCell.h"
#import "CTMediator+ModuleBookActions.h"
#import "BookOrdSearchViewModel.h"
#import "BookSectionModel.h"

@interface BookSearchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) BookOrdSearchViewModel *viewModel;
@end

@implementation BookSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBtn.lz_setView.lz_cornerRadius(8);
    
    [self.view addSubview:self.tableView];
    self.tableView.top += 70;
    self.tableView.height -= 70;
    
    [self.tableView registerClass:[BookTableViewCell class] forCellReuseIdentifier:@"BookTableViewCell"];
    self.tableView.rowHeight = 68;
    self.searchView.lz_setView.lz_cornerRadius(15);
    
    self.viewModel = [BookOrdSearchViewModel new];
    self.viewModel.tableView = self.tableView;
  
    [self.viewModel refreshData];
}



- (IBAction)search:(id)sender {
    
    self.viewModel.searchStr = self.textField.text;
    [self.viewModel refreshData];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookListModel *model = self.viewModel.dataArray[indexPath.row];
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookListModel *model = self.viewModel.dataArray[indexPath.row];
    [[CTMediator sharedInstance] CTMediator_ShowOrdDetailWithOrdID:model.transOrderNo nav:self.navigationController];
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
