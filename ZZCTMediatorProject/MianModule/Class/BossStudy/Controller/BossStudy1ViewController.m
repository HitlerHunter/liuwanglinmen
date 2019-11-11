//
//  BossStudy1ViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BossStudy1ViewController.h"
#import "BossStudyViewModel.h"
#import "BossStudyCell.h"
#import "BossStudyModel.h"

@interface BossStudy1ViewController ()
@property (nonatomic, strong) BossStudyViewModel *viewModel;
@end

@implementation BossStudy1ViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (instancetype)initWithType:(NSString *)type{
    self = [super init];
    if (self) {
        self.viewModel.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.tableView.height -= 44;
    
    self.tableView.rowHeight = 110;
    [self.tableView registerNib:[UINib nibWithNibName:@"BossStudyCell" bundle:nil] forCellReuseIdentifier:@"BossStudyCell"];
    
    self.viewModel.tableView = self.tableView;
    
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
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
    BossStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BossStudyCell"];
    
    cell.titleLab.text = model.title;
    cell.infoLabel.text = model.content;
    cell.timeLabel.text = model.showTime;
    
    [cell.avatar sd_setImageWithURL:TLURL(model.picture)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
    [AppCenter openURL:model.jumpUrl];
   
};

- (BossStudyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [BossStudyViewModel new];
    }
    return _viewModel;
}

@end
