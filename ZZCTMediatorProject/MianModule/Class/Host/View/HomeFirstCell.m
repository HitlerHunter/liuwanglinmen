//
//  HomeFirstCell.m
//  ZZCTMediatorProject
//
//  Created by 曾立志 on 2020/1/17.
//  Copyright © 2020 zenglizhi. All rights reserved.
//

#import "HomeFirstCell.h"

@implementation HomeFirstCell

- (void)initUI{

    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageName(@"homeCell_Icon1")];
    [self.contentView addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];


    UILabel *lab2 = [UILabel labelWithFontSize:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    lab2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    lab2.text = @"男人床上的秘密武器，效果立竿见影从此欲罢不能";
    [self.contentView addSubview:lab2];

    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];

}

@end
