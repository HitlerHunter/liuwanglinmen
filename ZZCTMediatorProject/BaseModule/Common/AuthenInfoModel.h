//
//  AuthenInfoModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/25.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//商户状态（20：未认证，0：待审核，5：审核通过，（2或者7:审核不通过））
typedef NS_ENUM(NSUInteger, AuthenStatus) {
    AuthenStatusNoAuthen = 20,
    /**待审核*/
    AuthenStatusWaitAuthen = 0,
    AuthenStatusDidAuthen = 5,
    /**审核不通过*/
    AuthenStatusAuthenNoPass1 = 2,
    /**审核不通过*/
    AuthenStatusAuthenNoPass2 = 7,
    /**审核不通过*/
    AuthenStatusAuthenNoPass3 = 8,
};

@interface AuthenInfoModel : NSObject

@property (nonatomic, strong) NSString *acountAuthFile;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *authbankcardfront;
@property (nonatomic, strong) NSString *authcertphoto;
@property (nonatomic, strong) NSString *authedcardback;
@property (nonatomic, strong) NSString *authedcardfront;

@property (nonatomic, strong) NSString *balanceUserFlag;
@property (nonatomic, strong) NSString *balanceUserType;
@property (nonatomic, strong) NSString *bankCity;
/**
 开户城市编号
 */
@property (nonatomic, strong) NSString *bankCityId;
@property (nonatomic, strong) NSString *bankProvince;
//@property (nonatomic, strong) NSString *bankprovince;
/**
 开户省份编号
 */
@property (nonatomic, strong) NSString *bankProvinceId;
@property (nonatomic, strong) NSString *bankSubbranch;

@property (nonatomic, strong) NSString *bankaccount;
//@property (nonatomic, strong) NSString *bankcity;
@property (nonatomic, strong) NSString *bankcode;
@property (nonatomic, strong) NSString *bankmobile;
@property (nonatomic, strong) NSString *bankname;
/**
 开户支行名称编号
 */
@property (nonatomic, strong) NSString *banknameid;
/**
 01对私(D+1)，02对公(T+1)
 */
@property (nonatomic, strong) NSString *banktype;
@property (nonatomic, strong) NSString *bankuser;

@property (nonatomic, strong) NSString *businessShours;
@property (nonatomic, strong) NSString *businessEhours;

@property (nonatomic, strong) NSString *cashierFile;
@property (nonatomic, strong) NSString *checkRemark;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *closestatus;

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *corporationIdcard;
@property (nonatomic, strong) NSString *corporationIdcardEdate;
@property (nonatomic, strong) NSString *corporationIdcardSdate;
@property (nonatomic, strong) NSString *corporationMobile;

@property (nonatomic, strong) NSString *corporationName;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createname;
@property (nonatomic, strong) NSString *createno;
@property (nonatomic, strong) NSString *currentIncome;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *goodsphoto;
/**
 所属总行编号
 */
@property (nonatomic, strong) NSString *headbanknameid;
@property (nonatomic, strong) NSString *headbankname;

@property (nonatomic, strong) NSString *hybmachid;
@property (nonatomic, strong) NSString *hybstatus;
@property (nonatomic, strong) NSString *hybupstatus;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *idcardback;
@property (nonatomic, strong) NSString *idcardfront;
@property (nonatomic, strong) NSString *idcardinhand;

@property (nonatomic, strong) NSString *isunion;

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *licensename;
@property (nonatomic, strong) NSString *licensenumber;
@property (nonatomic, strong) NSString *licensephoto;
@property (nonatomic, strong) NSString *linkmanName;
@property (nonatomic, strong) NSString *linkmanidcard;

@property (nonatomic, strong) NSString *machType;
@property (nonatomic, strong) NSString *machid;
@property (nonatomic, strong) NSString *mccCd;
@property (nonatomic, strong) NSString *mchntid;
@property (nonatomic, strong) NSString *mercode;
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *oemType;
@property (nonatomic, strong) NSString *openlicense;
@property (nonatomic, strong) NSString *orgphoto;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceid;

@property (nonatomic, strong) NSString *qrcode;

@property (nonatomic, strong) NSString *saleId;
@property (nonatomic, strong) NSString *salesType;
@property (nonatomic, strong) NSString *salesType1;
@property (nonatomic, strong) NSString *salesType2;
@property (nonatomic, strong) NSString *salesTypeName;
@property (nonatomic, strong) NSString *salesTypeName1;
@property (nonatomic, strong) NSString *salesTypeName2;

@property (nonatomic, strong) NSString *salesmanMobile;

@property (nonatomic, strong) NSString *shareComp1;
@property (nonatomic, strong) NSString *shareComp10;
@property (nonatomic, strong) NSString *shareComp11;
@property (nonatomic, strong) NSString *shareComp12;
@property (nonatomic, strong) NSString *shareComp13;

@property (nonatomic, strong) NSString *shareComp14;
@property (nonatomic, strong) NSString *shareComp2;
@property (nonatomic, strong) NSString *shareComp3;
@property (nonatomic, strong) NSString *shareComp4;
@property (nonatomic, strong) NSString *shareComp5;

@property (nonatomic, strong) NSString *shareComp6;
@property (nonatomic, strong) NSString *shareComp7;
@property (nonatomic, strong) NSString *shareComp8;
@property (nonatomic, strong) NSString *shareComp9;

@property (nonatomic, strong) NSString *sharealipay;
@property (nonatomic, strong) NSString *sharewechat;

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopphoto;

@property (nonatomic, strong) NSString *shoptypeId;
@property (nonatomic, strong) NSString *shoptypeId1;
@property (nonatomic, strong) NSString *shoptypeId2;
@property (nonatomic, strong) NSString *shoptypeName;
@property (nonatomic, strong) NSString *shoptypeName1;
@property (nonatomic, strong) NSString *shoptypeName2;
@property (nonatomic, strong) NSString *shortUserName;

@property (nonatomic, assign) AuthenStatus status;

@property (nonatomic, strong) NSString *subMchId;
@property (nonatomic, strong) NSString *subshopdesc;

@property (nonatomic, strong) NSString *taskCode;
@property (nonatomic, strong) NSString *taxphoto;

@property (nonatomic, strong) NSString *upMobile;
@property (nonatomic, strong) NSString *upUserName;
@property (nonatomic, strong) NSString *upUserNo;
@property (nonatomic, strong) NSString *upcop;
@property (nonatomic, strong) NSString *upstatus;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userNo;
@property (nonatomic, strong) NSString *usertype;
@property (nonatomic, strong) NSString *wechatTypeId;

@property (nonatomic, strong) NSString *share_comp1;
@property (nonatomic, strong) NSString *share_comp2;
@property (nonatomic, strong) NSString *share_comp3;
@property (nonatomic, strong) NSString *share_comp4;
@property (nonatomic, strong) NSString *share_comp5;
@property (nonatomic, strong) NSString *share_comp7;

@end

NS_ASSUME_NONNULL_END
