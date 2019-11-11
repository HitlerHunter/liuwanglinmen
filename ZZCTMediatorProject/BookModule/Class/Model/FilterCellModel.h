//
//  FilterCellModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FilterModel;
@interface FilterCellModel : NSObject

@property (nonatomic, assign) BOOL canShowMore;
@property (nonatomic, strong) NSMutableArray *filterModelArray;
@property (nonatomic, strong) NSArray *filterTextArray;

@property (nonatomic, strong) FilterModel *seletedModel;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat cellHeight;
@end
