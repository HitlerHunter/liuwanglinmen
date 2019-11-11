//
//  LZAddressEnum.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/24.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#ifndef LZAddressEnum_h
#define LZAddressEnum_h

typedef NS_ENUM(NSUInteger, AddressSelectType) {
    /**省*/
    AddressSelectTypeProvince = 2,
    /**市*/
    AddressSelectTypeCity,
    /**区*/
    AddressSelectTypeDistrict,
    /**乡、街道*/
    AddressSelectTypeStreet,
};

#endif /* LZAddressEnum_h */
