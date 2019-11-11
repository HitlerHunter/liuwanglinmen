//
//  MessageSendQuestionView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageSendQuestionModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) NSInteger index;

@end

@interface MessageSendQuestionCell : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_vaule;
@property (nonatomic, strong) UILabel *label_index;

@property (nonatomic, strong) MessageSendQuestionModel *model;

@end

@interface MessageSendQuestionView : SDBaseView

@property (nonatomic, strong) NSArray <MessageSendQuestionModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
