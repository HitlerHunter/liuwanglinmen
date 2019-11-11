//
//  MineMessageDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineMessageDetailViewController.h"
#import "HomeMessageModel.h"

@interface MineMessageDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation MineMessageDetailViewController

- (instancetype)initWithModel:(HomeMessageModel *)model{
    if ([super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"通知详情";
    
    self.titleLabel.text = _model.title;
    self.timeLabel.text = _model.createdTime;
    self.infoLabel.text = _model.content;

}


@end
