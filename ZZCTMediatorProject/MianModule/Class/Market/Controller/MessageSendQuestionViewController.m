//
//  MessageSendQuestionViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendQuestionViewController.h"
#import "MessageSendQuestionView.h"

@interface MessageSendQuestionViewController ()

@property (nonatomic, strong) MessageSendQuestionView *cellView1;
@end

@implementation MessageSendQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常见问题";
    
    [self.view addSubview:self.scrollView];
    
    [self initCellView1];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"短信发送多久后可以到达？",@"短信发送多久后可以到达？",@"发送时间",@"短信发送多久后可以到达？",@"成功发送条数",@"发送内容",];
    NSArray *vauleArray = @[@"您发送的短信需要短信渠道商人工审核后才能发出，到达时间最快是10分钟后。",
                            @"发送对象",@"发送时间",@"发送条数",@"成功发送条数",@"我是发送内容我是发送内容我是发送内容我是发送内容我是发送内容我是发送内容,我是发送内容我是发送内容我是发送内容我是发送内容我是发送内容我是发送内容",];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        MessageSendQuestionModel *model = [MessageSendQuestionModel new];
        model.title = titleArray[i];
        model.info = vauleArray[i];
        
        [arr1 addObject:model];
    }
    
    _cellView1 = [MessageSendQuestionView new];
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-15);
    }];
    
    _cellView1.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}

@end
