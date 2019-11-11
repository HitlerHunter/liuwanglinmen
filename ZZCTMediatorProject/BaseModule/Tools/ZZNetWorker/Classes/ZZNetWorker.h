//
//  NetworkHelper.h
//  FlowerField
//
//  Created by 郑佳 on 2017/8/20.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ZZNetWorkHandler.h"

typedef NS_ENUM(NSUInteger, ZZNetWorkerMethod) {
    GET = 0,
    POST = 1,
    FormData = 5,//表单上传
    DELETE = 2,
    UpLoadFile = 3,
    PUT = 4,
};

typedef NS_ENUM(NSUInteger, ZZNetWorkerParamType) {
    ZZNetWorkerParamTypeNormalBody,
    ZZNetWorkerParamTypeAppendAfterURL,
    ZZNetWorkerParamTypeFormData,
};

@class ZZNetWorker;

typedef void(^ZZNetWorkerCompletionBlock)(NSDictionary *data, NSError *error);
typedef void(^ZZNetWorkerManagerBlock)(AFHTTPSessionManager *manager);
typedef id(^ZZNetWorkerParamBlock)(id param ,ZZNetWorker *worker);
typedef void(^ZZNetWorkerUploadImageFinishBlock)(BOOL isSuccess, NSString *url);
typedef void(^ZZNetWorkerDefaultBlock)(ZZNetWorker *worker);

@interface ZZNetWorker : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) id param;
@property (nonatomic, assign) ZZNetWorkerMethod method;
@property (nonatomic, assign) BOOL isOpenLog;
@property (nonatomic, assign) BOOL willHandlerParam;
@property (nonatomic, assign) BOOL isPostByURLSession;
@property (nonatomic, assign) ZZNetWorkerParamType paramType;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSString *Authorization;

@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_url)(NSString *url);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_baseUrl)(NSString *baseUrl);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_param)(id param);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_log)(BOOL isOpenLog);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_willHandlerParam)(BOOL willHandlerParam);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_isPostByURLSession)(BOOL isPostByURLSession);

@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_completion)(ZZNetWorkerCompletionBlock block);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_setContentTypeJson)(void);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_setParamType)(ZZNetWorkerParamType);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_setContentTypeNil)(void);
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_authorization)(NSString *Authorization);

/**
  设置manager.
 */
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_manager)(ZZNetWorkerManagerBlock block);
/**
 设置param后, 每次都会调用.
 */
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_handlerParam)(ZZNetWorkerParamBlock block);
/**
 对worker 初始化.
 请求开始前, 每次都会调用.
 */
@property (nonatomic, strong, readonly) ZZNetWorker * (^zz_defaultRequest)(ZZNetWorkerDefaultBlock block);

+ (ZZNetWorker *)POST;
+ (ZZNetWorker *)GET;
+ (ZZNetWorker *)DELETE;
+ (ZZNetWorker *)PUT;
+ (ZZNetWorker *)FormData;

/**
 获取单例对象
 @return ZZNetWorker.new
 */
+ (ZZNetWorker *)woker;

- (void)requestMethod:(ZZNetWorkerMethod)method
                  url:(NSString *)url
           parameters:(id)parameters
          finishBlock:(ZZNetWorkerCompletionBlock)finishBlock;

- (NSURLSessionDataTask *)UploadImage:(NSString *)URLString
         parameters:(id)parameters
               data:(NSData *)data
           progress:(void (^)(NSProgress * uploadProgress))progress
        finishBlock:(ZZNetWorkerCompletionBlock)finishBlock;

+ (void)uploadImage1:(UIImage *)image1
               block:(ZZNetWorkerUploadImageFinishBlock)block;
+ (void)uploadImage1:(UIImage *)image1
  compressionQuality:(CGFloat)compressionQuality
               block:(ZZNetWorkerUploadImageFinishBlock)block;
@end
