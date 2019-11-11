//
//  LZBaseTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/12.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

@interface LZBaseTableViewCell ()

@end

@implementation LZBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)initUI{
    
}

- (CALayer *)line{
    CALayer *line = [CALayer layer];
    line.backgroundColor = UIColorHex(0xF2ECE8).CGColor;
    return line;
}

- (CALayer *)topLine{
    if (!_topLine) {
        _topLine = [self line];
    }
    return _topLine;
}

- (CALayer *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [self line];
    }
    return _bottomLine;
}


- (void)addTopLine{
    [self.contentView.layer addSublayer:self.topLine];
}

- (void)addBottomLine{
    [self.contentView.layer addSublayer:self.bottomLine];
}

- (void)setBottomLineX:(CGFloat)spacingX{
    _bottomlineSpacingX = spacingX;
}

- (void)setTopLineX:(CGFloat)spacingX{
    _toplineSpacingX = spacingX;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _bottomLine.frame = CGRectMake(_bottomlineSpacingX, self.contentView.height-0.5, kScreenWidth-_bottomlineSpacingX-_bottomlineSpacingRightX, 0.5);
    _topLine.frame = CGRectMake(_toplineSpacingX, 0, kScreenWidth-_toplineSpacingX-_toplineSpacingRightX, 0.5);
}
@end
