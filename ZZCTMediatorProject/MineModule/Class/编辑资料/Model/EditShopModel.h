//
//  EditShopModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, EditShopType) {
    EditShopTypeEdit,//修改
    EditShopTypeAdd,//添加
    EditShopTypeShow,
};

@class EditPhotoModel,EditShopTagsModel;
@interface EditShopModel : NSObject

@property (nonatomic, assign) EditShopType editType;

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopMobile;
/**logo*/
@property (nonatomic, strong) NSString *shopLog;
@property (nonatomic, strong) NSString *shopDesc;
/**省*/
@property (nonatomic, strong) NSString *shopProvince;
/**省的code*/
@property (nonatomic, strong) NSString *shopProvinceCode;

/**市*/
@property (nonatomic, strong) NSString *shopCity;
/**市的code*/
@property (nonatomic, strong) NSString *shopCityCode;

/**区*/
@property (nonatomic, strong) NSString *shopArea;
/**区的code*/
@property (nonatomic, strong) NSString *shopAreaCode;

/**shopAddress*/
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, strong, readonly) NSString *shopProvinceCityArea;


@property (nonatomic, strong) NSString *shopFlag;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSArray <EditShopTagsModel *>*tbShopStruct;
@property (nonatomic, strong) NSArray <EditPhotoModel *>*tbStorePic;
/**是否已传资质*/
@property (nonatomic, assign,readonly) BOOL hasCertificate;
/**资质*/
@property (nonatomic, strong) EditPhotoModel *certificateModel;

- (void)addCertificate:(EditPhotoModel *)certificate;
@end

NS_ASSUME_NONNULL_END
