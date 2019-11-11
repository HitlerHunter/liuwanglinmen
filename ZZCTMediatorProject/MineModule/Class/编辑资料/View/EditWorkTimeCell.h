//
//  EditWorkTimeCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditWorkTimeCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *end;

- (void)setStart:(NSString *)start End:(NSString *)end;

@end

NS_ASSUME_NONNULL_END
