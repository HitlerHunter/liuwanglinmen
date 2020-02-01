//
//  LevelInfoView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LevelInfoType) {
    LevelInfoTypeNomal,
    LevelInfoTypeVIP = 1,
    LevelInfoTypeServer,
    LevelInfoTypeAreaServer,
};

@interface LevelInfoCellModel : NSObject

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *tagInfo;

@end

@interface LevelInfoModel : NSObject

@property (nonatomic, assign) LevelInfoType type;

@property (nonatomic, strong) NSString *delegateUrl;
@property (nonatomic, strong) NSString *text_xy;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, strong) NSAttributedString *btnAttributedTitle;
@property (nonatomic, assign) BOOL isBtnAble;
@property (nonatomic, strong) NSArray <LevelInfoCellModel *> *cellModelArray;
@property (nonatomic, strong) void (^submitBlock)(void);

+ (LevelInfoModel *)modelWithType:(LevelInfoType)type
                              dic:(NSDictionary *)dic;
@end

@interface LevelInfoCell : SDBaseView

@property (nonatomic, strong) LevelInfoCellModel *model;
@end

@interface LevelInfoView : SDBaseView
@property (nonatomic, strong) LevelInfoModel *model;
@end

NS_ASSUME_NONNULL_END
