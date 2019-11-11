//
//  GeneralizeCodeImageCell.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/2.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "GeneralizeCodeImageCell.h"
#import "GeneralizeCodeImageModel.h"
#import "ImageCodeTools.h"

@implementation GeneralizeCodeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.borderColor = LZGreenColor.CGColor;
}

- (void)setModel:(GeneralizeCodeImageModel *)model{
    _model = model;
    
    @weakify(self);
    if (!model.image) {
        
        [self.imageView sd_setImageWithURL:TLURL(model.picUrl) placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            @strongify(self);
            image = [ImageCodeTools addGeneralizeCodeImageModel:model toImage:image];
            model.image = image;
            self.imageView.image = image;
            
            if (self.finishImageBlock && model.isSelected) {
                self.finishImageBlock(image);
            }
        }];
    }else{
        self.imageView.image = model.image;
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"模版%ld",model.index];
    self.imageView.layer.borderWidth = model.isSelected?1:0;
    
    [RACObserve(model, isSelected) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.imageView.layer.borderWidth = model.isSelected?1:0;
    }];
}


@end
