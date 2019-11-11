//
//  CouponVipViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponVipViewModel.h"
#import "CouponVipModel.h"

@implementation CouponVipViewModel

- (void)getAllVipWithBlock:(SimpleBoolBlock)block{
    
    @weakify(self);
    [self getVipWithBlock:^(id  _Nullable obj) {
        @strongify(self);
        self.dataArray = obj;
        if (block) {
            block(YES);
        }
    }];
}

- (void)searchVipWithBlock:(SimpleBoolBlock)block{
    
    @weakify(self);
    [self getVipWithBlock:^(id  _Nullable obj) {
        @strongify(self);
        self.searchDataArray = obj;
        [self.searchDataArray enumerateObjectsUsingBlock:^(CouponVipSectionModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isShow = YES;
        }];
        if (block) {
            block(YES);
        }
    }];
}

- (void)getVipWithBlock:(SimpleObjBlock)block{
    
    NewParams;
    [params setSafeObject:self.searchStr forKey:@"param"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
    
    ZZNetWorker.GET.zz_param(params)
    .zz_url(@"/admin/app/choose/member")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSDictionary *dic = model_net.data[@"result"];
            NSArray *keys = dic.allKeys;
            
            NSMutableArray *sectionArray = [NSMutableArray array];
            for (NSString *key in keys) {
                NSArray *dicArray = dic[key];
                CouponVipSectionModel *section = [CouponVipSectionModel new];
                section.tagsName = key;
                
                NSArray *vips = [CouponVipModel mj_objectArrayWithKeyValuesArray:dicArray];
                section.vipArray = vips;
                [sectionArray addObject:section];
            }
            
            if (block) {
                block(sectionArray);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.msg];
        }
        
        
    });
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)searchDataArray{
    if (!_searchDataArray) {
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}

@end
