//
//  EditBgImageSelectCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditBgImageSelectCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UILabel *text_label;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSArray *imageArray;

@end

NS_ASSUME_NONNULL_END
