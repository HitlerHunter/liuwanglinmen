//
//  GeneralizeCodeImageCell.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/2.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeneralizeCodeImageModel;
@interface GeneralizeCodeImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) GeneralizeCodeImageModel *model;
@property (nonatomic, strong) SimpleObjBlock finishImageBlock;
@end
