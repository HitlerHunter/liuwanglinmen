//
//  API.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#ifndef API_h
#define API_h

#define CodeValidtyTime @"1000" //验证码有效时间

#define BaseURL @"http://gateway.6wang666.com:8080"
//#define BaseURL @"http://192.168.1.123:8099"
//#define BaseURL @"http://192.168.1.190:8099"

//用户协议
#define UserDelegateURL @"http://139.9.76.21/new6wH5/html/userAgreement.html"
#define DelegateFuYeURL @"http://139.9.76.21/new6wH5/html/sidelineAgreement.html"
#define DelegateChuangYeURL @"http://139.9.76.21/new6wH5/html/startAgreement.html"
#define URL_RegisterHTML @"http://admin.6wang666.com/new6wH5/html/register.html"

#pragma mark - 通用
//登录注册
static NSString * const API_sendMessageCode = @"/public/sendMessageCode";
static NSString * const API_refreshToken = @"/auth/refresh";//ddtk
static NSString * const API_Login = @"/auth/login";
static NSString * const API_LoginWithCode = @"/auth/sms/login";

static NSString * const API_getUserInfo = @"/user-biz/sysUser";//ddtk
static NSString * const API_register = @"/admin/merchant/merchantRegister";//ddtk

static NSString * const API_getRolePermission = @"/permissionRole/getRolePermission";
static NSString * const API_getOemInfo = @"/outside-biz/appUpgrade/upgrade";
//身份验证用
static NSString * const API_sendCode = @"/outside-biz/sms"; //ddtk
static NSString * const API_infoVerify = @"/operator/infoVerify";
static NSString * const API_setPassWord = @"/operator/setPassWord";
static NSString * const API_reSetPassWord = @"/admin/user/open/resetPW";//ddtk

#pragma mark - 账目
static NSString * const API_getOrderListVo = @"/payment-biz/order/getOrderListVo";//ddtk
static NSString * const API_getMerchantAccountList = @"/admin/merchant/getMerchantAccountList";
static NSString * const API_getOrderVoByLastFourWords = @"/payment-biz/order/getOrderVoByLastFourWords";//ddtk
static NSString * const API_getOrderDetailVoByOrderNo = @"/payment-biz/order/getOrderDetail";//ddtk

#pragma mark - 我的 - 报表
static NSString * const API_getOrderReportForm = @"/admin/tradeOrder/getOrderReportForm";//ddtk
static NSString * const API_getTradingTrends = @"/admin/tradeOrder/getTradingTrends";//ddtk

#pragma mark - 商户进件
static NSString * const API_getFirstGoodsTypeInfo= @"/rpGoodsType/getFirstGoodsTypeInfo";
static NSString * const API_getSecondGoodsTypeInfo = @"/rpGoodsType/getSecondGoodsTypeInfo";
static NSString * const API_getThridGoodsTypeInfo = @"/rpGoodsType/getThridGoodsTypeInfo";
//进件
static NSString * const API_upMerchantUser = @"/admin/merchant/addMerchantInfoNose";//ddtk
static NSString * const API_editMerchantInfo = @"/admin/merchant/editMerchantInfo";//ddtk
static NSString * const API_getMerchantInfo = @"/admin/merchant/getMerchantInfoByUserNoNose";//ddtk

static NSString * const API_getAllAgentUsers = @"/agentUser/getAllAgentUsers";

#pragma mark - 地址获取
static NSString * const API_getProvinceList = @"/UpCommonInfo/getAreaInfo";
static NSString * const API_getCityList = @"/UpCommonInfo/getCityInfo";
static NSString * const API_getBankList = @"/UpCommonInfo/getHeadbankInfo";
static NSString * const API_getSubBankList = @"/UpCommonInfo/getBranchBankInfo";

#pragma mark - 上传图片
static NSString * const API_uploadFile = @"/file/uploadFile";

#pragma mark - 订单
static NSString * const API_getDayOrderInfo = @"/shop/order/open/getDayOrderInfo";



#endif /* API_h */
