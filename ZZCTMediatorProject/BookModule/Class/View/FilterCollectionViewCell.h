//
//  FilterCollectionViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterModel;
@interface FilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FilterModel *model;

@property (nonatomic, copy) void (^clickBlock)(FilterModel *clickModel);
@end
