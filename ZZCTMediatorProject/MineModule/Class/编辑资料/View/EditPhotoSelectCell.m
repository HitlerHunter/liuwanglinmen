//
//  EditPhotoSelectCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditPhotoSelectCell.h"
#import "EditPhotoModel.h"

@implementation EditPhotoSelectCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(242, 242, 242);
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
    }
    return self;
}



- (void)setModel:(EditPhotoModel *)model{
    _model = model;
    
    if (model.cellType == EditPhotoCellTypeAdd) {
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else{
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    if (model.image) {
        _imageView.image = model.image;
    }else if (model.url) {
        [_imageView sd_setImageWithURL:TLURL(model.url)];
    }
}

@end
