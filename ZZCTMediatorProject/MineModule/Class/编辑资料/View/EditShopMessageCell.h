//
//  EditShopMessageCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class CMInputView;
@interface EditShopMessageCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) CMInputView *textView;

@property (nonatomic, strong) NSString *text;
@end

NS_ASSUME_NONNULL_END
