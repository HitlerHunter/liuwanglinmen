//
//  EditTagsCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTagsCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;

@property (strong,nonatomic) NSMutableArray * dataArray;

- (void)reloadData;
- (void)setMineDataArray:(NSArray *)array;
- (NSArray *)getSelectedTags;
@end

NS_ASSUME_NONNULL_END
