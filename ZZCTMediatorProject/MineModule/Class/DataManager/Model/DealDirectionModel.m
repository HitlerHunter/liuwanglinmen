//
//  DealDirectionModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "DealDirectionModel.h"

@implementation DealDirectionModel

@end

@implementation DealDirectionSectionModel

- (void)setDatas:(NSArray<DealDirectionModel *> *)datas{
    _datas = datas;
    [self.titles removeAllObjects];
    [self.values removeAllObjects];
    for (DealDirectionModel *model in datas) {
        [self.titles insertObject:model.time atIndex:0];
        if (self.type == DealDirectionTypeMoney) {
           [self.values insertObject:@(model.tradingAmount) atIndex:0];
        }else{
           [self.values insertObject:@(model.tradingCount) atIndex:0];
        }
        
    }
}

- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)values{
    if (!_values) {
        _values = [NSMutableArray array];
    }
    return _values;
}
@end


