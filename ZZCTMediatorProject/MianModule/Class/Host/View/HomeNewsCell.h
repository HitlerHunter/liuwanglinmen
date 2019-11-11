//
//  HomeNewsCell.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/26.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewsCell : LZBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *readNumberLabel;

@end

NS_ASSUME_NONNULL_END
