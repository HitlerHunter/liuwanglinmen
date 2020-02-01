//
//  BossStudyViewModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BossStudyViewModel.h"
#import "BossStudyModel.h"

@implementation BossStudyViewModel

+(void)getTypeList:(SimpleObjBlock)block{
    
    
}

- (BOOL)refreshable{
    return NO;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"pageSize"];
    [params setSafeObject:@"20" forKey:@"limit"];
    [params setSafeObject:self.type?self.type:@"" forKey:@"type"];
    [params setSafeObject:self.classify?self.classify:@"" forKey:@"classify"];
    //?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1
    NSArray *arr = @[@{@"createTime":@"",
                       @"content":@"男人床上的秘密武器，效果立竿见影从此欲罢不能",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/bWdEW8y_ZtE2jqhAgSnwJQ",
                       @"picture":@"homeCell_Icon1",
                       @"title":@"男人床上的秘密武器，效果立竿见影从此欲罢不能",
                       },
                     @{@"createTime":@"",
                       @"content":@"【秒变卡神】一篇就够了，你还不知道的信用卡申请技巧！",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/w6PitpxXzF4DxmiJ_N4tsg",
                       @"picture":@"homeCell_Icon2",
                       @"title":@"【秒变卡神】一篇就够了，你还不知道的信用卡申请技巧！",
                       },
                     @{@"createTime":@"",
                       @"content":@"14家银行的信用卡提额技巧",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/j2vFqgASS_s_u956H2xncA",
                       @"picture":@"homeCell_Icon3",
                       @"title":@"14家银行的信用卡提额技巧",
                       },
                     @{@"createTime":@"",
                       @"content":@"为什么你需要有一份副业？【附干货】",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/PqPoYp6gan0uHLl9mu0xYQ",
                       @"picture":@"homeCell_Icon4",
                       @"title":@"为什么你需要有一份副业？【附干货】",
                       },
                     ];
   
    self.dataArray = [BossStudyModel mj_objectArrayWithKeyValuesArray:arr];
    if (handler) {
        handler(YES,NO,self.dataArray);
    }
}

@end
