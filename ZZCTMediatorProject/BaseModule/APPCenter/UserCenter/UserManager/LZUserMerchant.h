//
//  LZUserMerchant.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AuthenMerchantStatus) {
    AuthenMerchantStatusNoSubmit,
        //拒绝
    AuthenMerchantStatusRefund,
        //审核中
    AuthenMerchantStatusReviewing,
        //通过
    AuthenMerchantStatusSuccess,
};

@class LZUserMerchant;
extern NSString* getMerchantTypeNameWithType(NSString *type);
extern NSString* checkMerchantVauleWithMerchant(LZUserMerchant *merchant);

@interface MerchantInfo : NSObject

@property (nonatomic, assign) AuthenMerchantStatus status_lz;

@property (nonatomic, strong) NSString *alipayTypeId;
@property (nonatomic, strong) NSString *applyNo;
@property (nonatomic, strong) NSString *businessEhours;
@property (nonatomic, strong) NSString *businessShours;
/**备注说明*/
@property (nonatomic, strong) NSString *checkRemark;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *closeStatus;
@property (nonatomic, strong) NSString *contactIdEdate;
@property (nonatomic, strong) NSString *contactIdSdate;
@property (nonatomic, strong) NSString *corporationIdcard;
@property (nonatomic, strong) NSString *corporationIdcardEdate;
@property (nonatomic, strong) NSString *corporationIdcardSdate;
@property (nonatomic, strong) NSString *corporationMobile;
@property (nonatomic, strong) NSString *corporationName;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *countyId;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *merchantType;

@property (nonatomic, strong) NSString *pnrpayMerType;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *shortMerchantName;
/**进件状态(0未审核1本地审核通过2本地审核拒5审核通过8上游入驻失败9开通业务失败)*/
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *wechatTypeId;
@property (nonatomic, strong) NSString *upUserName;
@property (nonatomic, strong) NSString *upUserNo;

@property (nonatomic, strong) NSString *creditCode;
@property (nonatomic, strong) NSString *isCreditCode;

@property (nonatomic, strong) NSString *licensenumber;
@property (nonatomic, strong) NSString *licEdate;
@property (nonatomic, strong) NSString *licSdate;
@property (nonatomic, strong) NSString *address;

/**店主名称*/
@property (nonatomic, strong) NSString *linkmanName;
@property (nonatomic, strong) NSString *linkmanMobile;
@property (nonatomic, strong) NSString *linkmanIdCard;

@property (nonatomic, strong) NSString *tellerId;

@property (nonatomic, strong) NSString *salesMan;

@property (nonatomic, strong) NSString *createName;
@property (nonatomic, strong) NSString *createNo;
@property (nonatomic, strong) NSString *userNo;


@end

@interface MerchantPicture : NSObject
@property (nonatomic, strong) NSString *accountAuthFile;
@property (nonatomic, strong) NSString *authCardBack;
@property (nonatomic, strong) NSString *authCardFront;
@property (nonatomic, strong) NSString *authbankcardback;
@property (nonatomic, strong) NSString *authbankcardfront;
@property (nonatomic, strong) NSString *authcertphoto;
@property (nonatomic, strong) NSString *cashierFile;
@property (nonatomic, strong) NSString *goodsPhoto;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *idCardBack;
@property (nonatomic, strong) NSString *idCardFront;
@property (nonatomic, strong) NSString *idcardinhand;
@property (nonatomic, strong) NSString *licensePhoto;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *openLicense;
@property (nonatomic, strong) NSString *orgPhoto;
@property (nonatomic, strong) NSString *rentalAgreement;
@property (nonatomic, strong) NSString *shopPhoto;
@property (nonatomic, strong) NSString *taxPhoto;

@end

@interface Settlement : NSObject
@property (nonatomic, strong) NSString *accountIdEdate;
@property (nonatomic, strong) NSString *accountIdSdate;
@property (nonatomic, strong) NSString *accountIdNo;
@property (nonatomic, strong) NSString *balanceUserFlag;
@property (nonatomic, strong) NSString *balanceUserType;
@property (nonatomic, strong) NSString *bankAccount;
@property (nonatomic, strong) NSString *bankBranch;
@property (nonatomic, strong) NSString *bankCity;
@property (nonatomic, strong) NSString *bankCityId;
@property (nonatomic, strong) NSString *bankCode;
@property (nonatomic, strong) NSString *bankProvince;
@property (nonatomic, strong) NSString *bankProvinceId;
@property (nonatomic, strong) NSString *bankUser;
@property (nonatomic, strong) NSString *checkRemark;
@property (nonatomic, strong) NSString *fee01;
@property (nonatomic, strong) NSString *headBankName;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *settleBusiness;

@end

@interface Sharecomp : NSObject
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *shareComp1;
@property (nonatomic, strong) NSString *shareComp13;
@property (nonatomic, strong) NSString *shareComp14;
@property (nonatomic, strong) NSString *shareComp3;
@property (nonatomic, strong) NSString *shareComp8;
@end

@interface LZUserMerchant : NSObject

@property (nonatomic, strong) Sharecomp *pmsMerchantSharecomp;
@property (nonatomic, strong) Settlement *pmsMerchantSettlement;
@property (nonatomic, strong) MerchantPicture *pmsMerchantPicture;
@property (nonatomic, strong) MerchantInfo *pmsMerchantInfo;

@property (nonatomic, assign) BOOL canEdit;

+ (LZUserMerchant *)creatMerchant;
@end

NS_ASSUME_NONNULL_END
