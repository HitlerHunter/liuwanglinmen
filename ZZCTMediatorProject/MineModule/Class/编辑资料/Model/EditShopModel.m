//
//  EditShopModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditShopModel.h"
#import "EditPhotoModel.h"
#import "EditShopTagsModel.h"

@implementation EditShopModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"tbStorePic":@"EditPhotoModel",@"tbShopStruct":@"EditShopTagsModel"};
}

- (NSString *)shopProvinceCityArea{
    NSMutableString *address = [[NSMutableString alloc] init];
    if (!IsNull(self.shopProvince)) {
        [address appendString:self.shopProvince];
    }
    if (!IsNull(self.shopCity)) {
        [address appendString:self.shopCity];
    }
    if (!IsNull(self.shopArea)) {
        [address appendString:self.shopArea];
    }
    
    return address;
}

- (BOOL)hasCertificate{
    BOOL b = NO;
    for (EditPhotoModel *model  in self.tbStorePic) {
        if ([model.type isEqualToString:@"certificate"]) {
            b = YES;
        }
    }
    return b;
}

- (void)setTbStorePic:(NSArray<EditPhotoModel *> *)tbStorePic{
    _tbStorePic = tbStorePic;
    
    [tbStorePic enumerateObjectsUsingBlock:^(EditPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.shopId = self.shopId;
    }];
    
    for (EditPhotoModel *model  in tbStorePic) {
        if ([model.type isEqualToString:@"certificate"]) {
            _certificateModel = model;
        }
    }
}

- (void)addCertificate:(EditPhotoModel *)certificate{
    
    if(!certificate) return;
    
    if (self.hasCertificate) {
        [_tbStorePic enumerateObjectsUsingBlock:^(EditPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.type isEqualToString:@"certificate"]) {
                obj.url = certificate.url;
            }
        }];
    }else{
        NSMutableArray *array = [NSMutableArray arrayWithArray:_tbStorePic];
        
        certificate.shopId = self.shopId;
        [array addObject:certificate];
        [self setTbStorePic:array];
    }
    
}


- (void)setTbShopStruct:(NSArray<EditShopTagsModel *> *)tbShopStruct{
    _tbShopStruct = tbShopStruct;
    
    [tbShopStruct enumerateObjectsUsingBlock:^(EditShopTagsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.shopId = self.shopId;
    }];
}

@end
