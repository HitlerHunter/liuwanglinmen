//
//  MarkMessageChoicePersonView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkMessageChoicePersonView : SDBaseView

@property (nonatomic, strong) UILabel *label_person;

@property (nonatomic, strong) NSString *personTag;
@property (nonatomic, strong) NSString *personTagId;
@property (nonatomic, strong) NSString *personType;

@end

NS_ASSUME_NONNULL_END
