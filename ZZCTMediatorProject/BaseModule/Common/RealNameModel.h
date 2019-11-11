//
//  RealNameModel.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/22.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RealNameCellType) {
    RealNameCellTypeTextField,
    RealNameCellTypeSelect,
    RealNameCellTypeScan,
    RealNameCellTypeSelectNoTitle,
    RealNameCellTypeLabel,
};
@interface RealNameModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *content2;
@property (nonatomic, strong) NSString *content3;
@property (nonatomic, strong) NSString *vaule;
@property (nonatomic, strong) NSString *vaule2;
@property (nonatomic, strong) NSString *vaule3;
@property (nonatomic, strong) NSString *placeholder;

/**
 是否必须有内容
 */
@property (nonatomic, assign) BOOL isRequested;

@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic, assign) RealNameCellType type;
@end
