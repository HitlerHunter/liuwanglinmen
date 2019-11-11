//
//  DataCollectionLineChatView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DataLineCellStyle) {
    DataLineCellStyleSingle = 0,
    DataLineCellStyleDouble = 1,
};

typedef NS_ENUM(NSUInteger, LineChatDataType) {
    LineChatDataTypeMoney = 0,
    LineChatDataTypeCount = 1,
};

@interface DataLineCellModel : NSObject

@property (nonatomic, strong) NSString *dateYMD;
@property (nonatomic, strong) NSString *dateMD;
@property (nonatomic, strong) NSString *dateDay;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat vaule;
@property (nonatomic, assign) CGFloat percent;

//show
@property (nonatomic, strong) NSString *vauleText;
@property (nonatomic, assign) CGPoint point;

@property (nonatomic, assign) DataLineCellStyle cellStyle;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) LineChatDataType dataType;
@end

@interface DataCollectionLineCell : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *point;
@property (nonatomic, strong) DataLineCellModel *model;

@end

@interface ChartScrollView : UIScrollView


@end

@interface ChartVauleShowView : UIView


@end

@interface DataCollectionLineChatView : UIView

- (void)refreshDataWithDataArray:(NSArray <DataLineCellModel *>*)dataArray;
@end

NS_ASSUME_NONNULL_END
