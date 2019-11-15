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
    model.templateContent = self.templateContent;
    model.businessType = self.businessType;
    model.cellType = self.cellType;
    model.status = self.status;
    model.usrNo = self.usrNo;
    model.Id = self.Id;
    model.delFlag = self.delFlag;
    return model;
}

@end
