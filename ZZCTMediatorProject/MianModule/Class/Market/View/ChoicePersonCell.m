//
//  ChoicePersonCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChoicePersonCell.h"

@interface ChoicePersonCell ()

@property (nonatomic, strong) UIImageView *moreIcon;
@end

@implementation ChoicePersonCell

- (void)initUI{
    self.textLabel.font = Font_PingFang_SC_Medium(14);
    self.textLabel.textColor = rgb(53,53,53);
    
    [self addBottomLine];
    [self setBottomlineSpacingX:15];
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"checkmark_white")];
    moreIcon.highlightedImage = UIImageName(@"checkmark_orange");
    [self addSubview:moreIcon];

    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(14, 11));
    }];
    _moreIcon = moreIcon;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    _moreIcon.highlighted = selected;
}

@end
