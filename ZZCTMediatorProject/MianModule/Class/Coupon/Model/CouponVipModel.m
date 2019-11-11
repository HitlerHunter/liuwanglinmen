//
//  CouponVipModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponVipModel.h"

@implementation CouponVipModel

@end

@implementation CouponVipSectionModel

- (void)selectAllOrNot:(BOOL)isSelected{
    
    [_vipArray enumerateObjectsUsingBlock:^(CouponVipModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = isSelected;
    }];
    
    _isSelected = isSelected;
}

- (void)checkSelect{
    
    __block BOOL isAllSelected = YES;
    [_vipArray enumerateObjectsUsingBlock:^(CouponVipModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.isSelected) {
            isAllSelected = NO;
            *stop = YES;
        }
    }];
    
    self.isSelected = isAllSelected;
}

- (void)setVipArray:(NSArray *)vipArray{
    _vipArray = vipArray;
    
    @weakify(self);
    [_vipArray enumerateObjectsUsingBlock:^(CouponVipModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.section = self;
    }];
}

- (NSInteger)didSelectCount{
    
    __block NSInteger count = 0;
    [_vipArray enumerateObjectsUsingBlock:^(CouponVipModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            count += 1;
        }
    }];
    
    return count;
    
}

@end
