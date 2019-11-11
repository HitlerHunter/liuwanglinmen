//
//  SYHomeListModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/13.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeListModel.h"

@implementation SYHomeListModel


- (NSString *)showType{
    if (!_showType) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"localProfitTypeDic"];
        _showType = [dic objectForKey:[NSString stringWithFormat:@"%@",self.flowType]];
    }
    return _showType;
}
@end
