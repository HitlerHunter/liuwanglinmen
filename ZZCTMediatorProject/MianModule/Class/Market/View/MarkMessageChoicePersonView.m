//
//  MarkMessageChoicePersonView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarkMessageChoicePersonView.h"
#import "ChoicePersonViewController.h"

@implementation MarkMessageChoicePersonView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"发送会员" textColor:rgb(101,101,101)];
    UILabel *label_person = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"选择发送对象" textColor:rgb(255,81,0)];
    label_person.textAlignment = NSTextAlignmentRight;
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"more_orange")];
    
    _label_person = label_person;
    
    [self addSubview:label_title];
    [self addSubview:label_person];
    [self addSubview:moreIcon];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self);
    }];
    
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(6, 9));
    }];
    
    [label_person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(moreIcon.mas_left).offset(-5);
        make.left.mas_equalTo(label_title.mas_right);
        make.height.mas_equalTo(self);
    }];
    
    [self addBottomLine];
    
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTapClick)];
    [self addGestureRecognizer:topTap];
    
    self.personTag = @"";
    self.personType = @"";
    
}

- (void)topTapClick{
    
    ChoicePersonViewController *vc = [ChoicePersonViewController new];
    @weakify(self);
    vc.selectedBlock = ^(NSString * _Nonnull title, NSString * _Nonnull Id) {
        @strongify(self);
        self.personTag = title;
        self.personType = Id;
        self.label_person.text = title;
    };
    PushController(vc);
    
    
}

@end
