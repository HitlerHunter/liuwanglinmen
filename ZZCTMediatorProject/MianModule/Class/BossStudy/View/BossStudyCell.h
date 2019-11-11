//
//  BossStudyCell.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossStudyCell : LZBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

NS_ASSUME_NONNULL_END
