//
//  FilterCellModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "FilterCellModel.h"
#import "FilterModel.h"

@implementation FilterCellModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.cellHeight = -1;
    }
    return self;
}

- (NSMutableArray *)filterModelArray{
    if (!_filterModelArray) {
        _filterModelArray = [NSMutableArray array];
        
        [self.filterModelArray removeAllObjects];
        if (self.canShowMore) {
            
            NSInteger maxNumber = kScreenWidth==320?3:4;
            
            if (_filterTextArray.count > maxNumber) {
                
                for (NSInteger i = 0; i < maxNumber-1; i++) {
                    FilterModel *model = [FilterModel new];
                    model.title = _filterTextArray[i];
                    
                    [self.filterModelArray addObject:model];
                }
                
                FilterModel *model = [FilterModel new];
                model.title = @"展开更多";
                [self.filterModelArray addObject:model];
                
                return _filterModelArray;
            }
            
        }
        
        for (NSInteger i = 0; i < _filterTextArray.count; i++) {
            FilterModel *model = [FilterModel new];
            model.title = _filterTextArray[i];
            
            [self.filterModelArray addObject:model];
        }
    }
    return _filterModelArray;
}
@end
