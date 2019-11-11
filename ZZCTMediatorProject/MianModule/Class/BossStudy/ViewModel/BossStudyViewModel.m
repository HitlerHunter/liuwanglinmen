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
    NSArray *arr = @[@{@"createTime":@"2019-10-25",
                       @"content":@"实体店营销新玩法！“智慧商圈”时代来临，老板需要知道这些事",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/oAjRUJ4ofMiD8gGYuTQcow",
                       @"picture":@"https://mmbiz.qpic.cn/mmbiz_jpg/tZIcUZ3uSxIiaJtlbZwhmdln2rI7nibO4TP3zbyuWfhrFP4GbficARz2kapAhicthvTpfkGiabboTl5ibBpP66QZYE7g/640",
                       @"title":@"实体店营销新玩法！“智慧商圈”时代来临，老板需要知道这些事",
                       },
                     @{@"createTime":@"2019-10-25",
                       @"content":@"实体店应该这样经营，满篇干货，值得收藏",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/It2WTVw7g1-JYv3V7d4DIA",
                       @"picture":@"https://mmbiz.qpic.cn/mmbiz_jpg/tZIcUZ3uSxIiaJtlbZwhmdln2rI7nibO4TDGWhrJdC89b0J8bZt1IGzpdx4VytqfImA49m6mNdHUiceM8s2USm5hg/640",
                       @"title":@"实体店应该这样经营，满篇干货，值得收藏",
                       },
                     @{@"createTime":@"2019-10-25",
                       @"content":@"不管你是哪一行，实体店要想生意好，都得学学这些经营套路",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/8g65jmTAua9FrVEloXO-3A",
                       @"picture":@"https://mmbiz.qpic.cn/mmbiz_jpg/tZIcUZ3uSxIiaJtlbZwhmdln2rI7nibO4TnXxFcib1EicnZmw3HOVYvneBBbOaicHjz0H8Spp7XMcYwVKa75FPKEWxg/640",
                       @"title":@"不管你是哪一行，实体店要想生意好，都得学学这些经营套路",
                       },
                     @{@"createTime":@"2019-10-25",
                       @"content":@"实体店老板须知的7个经营技巧，学会让你顾客爆满，产品大卖",
                       @"jumpUrl":@"https://mp.weixin.qq.com/s/7gfVIlzyamIsJO1ZLUqWIQ",
                       @"picture":@"https://mmbiz.qpic.cn/mmbiz_jpg/tZIcUZ3uSxIiaJtlbZwhmdln2rI7nibO4Tnxic2RWthTZm9KjQe1FEePGaL0pSyGviczXocPY42qQrKevNZJINQ6mw/640",
                       @"title":@"实体店老板须知的7个经营技巧，学会让你顾客爆满，产品大卖",
                       },
                     ];
   
    self.dataArray = [BossStudyModel mj_objectArrayWithKeyValuesArray:arr];
    if (handler) {
        handler(YES,NO,self.dataArray);
    }
}

@end
