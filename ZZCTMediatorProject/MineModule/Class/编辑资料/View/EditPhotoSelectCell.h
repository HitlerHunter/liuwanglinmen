//
//  EditPhotoSelectCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EditPhotoModel;
@interface EditPhotoSelectCell : UICollectionViewCell
@property (nonatomic, strong) EditPhotoModel *model;
@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
