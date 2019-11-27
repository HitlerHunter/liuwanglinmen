//
//  GoodsModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (NSString *)goodsSpecs{
    if (IsNull(_goodsSpecs)) {
        return @"";
    }
    return _goodsSpecs;
}

@end
