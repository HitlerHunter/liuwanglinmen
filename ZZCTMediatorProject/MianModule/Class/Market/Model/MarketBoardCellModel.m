//
//  MarketBoardCellModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardCellModel.h"

@implementation MarketBoardCellModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (MarketBoardCellModel *)modelCopy{
    MarketBoardCellModel *model = [MarketBoardCellModel new];
    model.templateHead = self.templateHead;
    model.templateName = self.templateName;
    model.templateContent = self.templateContent;
    model.targetType = self.targetType;
    model.cellType = self.cellType;
    model.templateStatus = self.templateStatus;
    model.userId = self.userId;
    model.Id = self.Id;
    return model;
}

@end
