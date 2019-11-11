//
//  StudyCollectionViewCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/8.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "StudyCollectionViewCell.h"

@implementation StudyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.lz_setView.lz_cornerRadius(4).lz_border(0.75, SDColor(0, 0, 0, 0.18));
    }
    return self;
}

- (void)initUI{
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label = [UILabel labelWithFontSize:14 textColor:rgb(18,18,18) textAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:label];
    
    _imageView = imageView;
    _label = label;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(115);
    }];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
}

@end
