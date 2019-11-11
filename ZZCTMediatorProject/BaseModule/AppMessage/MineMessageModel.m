//
//  MineMessageModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineMessageModel.h"

@implementation MineMessageModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (NSDictionary *)contentDic{
    if (!_contentDic) {
        NSData *data = [_content dataUsingEncoding:NSUTF8StringEncoding];
        _contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if(!_contentDic)_contentDic = @{};
    }
    
    return _contentDic;
}
@end
