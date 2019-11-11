//
//  EditTagCollectionCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EditShopTagsModel;
@interface EditTagCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) EditShopTagsModel *model;
@end

NS_ASSUME_NONNULL_END
