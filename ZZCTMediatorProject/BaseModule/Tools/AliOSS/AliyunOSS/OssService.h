//
//  OssService.h
//  OssIOSDemo
//
//  Created by 凌琨 on 15/12/15.
//  Copyright © 2015年 Ali. All rights reserved.
//



#ifndef OssService_h
#define OssService_h
#import <AliyunOSSiOS/OSSService.h>
#import "UpLoadFileModel.h"

#define aliyun_url @"http://wanquan888.oss-cn-shenzhen.aliyuncs.com/"

@interface OssService : NSObject

@property (nonatomic, strong) NSDate *date;

+ (OssService *)service;

- (id)init;

/**   提倡使用此方法
 *    @brief    上传多文件 (单文件 亦可)
 *    @param     files             要上传的 UpLoadFileModel 数组
 *    @param     oneCompletion     每个文件上传成功时的回调
 *    @param     allCompletion     全部完成时的回调
 使用如下：
 *  1、OssService *service = [[OssService alloc] init];
 *  2、NSArray of UpLoadFileModel
 *  3、transfer the method
 *  参考：SendYuanQuanViewController.m  line:200
 */
- (void)asyncPutFiles:(NSArray <UpLoadFileModel *> *)files
        oneCompletion:(void (^)(int index, UpLoadFileModel *backModel))oneCompletion
        allCompletion:(void (^)(void))allCompletion
              failure:(void (^)(NSError *error))failure;
    
///单个视频上传返回上传进度
- (void)asyncPutOnlyFile:(UpLoadFileModel *)file
           oneCompletion:(void (^)(int index, UpLoadFileModel *backModel))oneCompletion
             andProgress:(OSSNetworkingUploadProgressBlock)block
           allCompletion:(void (^)(void))allCompletion
                 failure:(void (^)(NSError *error))failure;
/**
 *	@brief	上传文件（图片或视频）
 *
 *	@param 	objectKey 	objectKey
 
   使用如下
 *  1、OssService *service = [[OssService alloc] init];
 *  2、传入 data Or path 获得task
 *  3、
     [task waitUntilFinished]; // 阻塞直到上传完成
     if (!task.error) {
     NSLog(@"upload object success!");
     } else {
     NSLog(@"upload object failed, error: %@" , task.error);
     }
 或者调用：block 为上传完的回调
 [task continueWithBlock:<#^id(OSSTask *task)block#>];
 */
- (OSSTask *)asyncPutImage:(NSString *)objectKey
            imageData:(NSData *)data;
- (OSSTask *)asyncPutImage:(NSString *)objectKey
        localFilePath:(NSString *)filePath;

- (void)asyncGetImage:(NSString *)objectKey;

- (void)normalRequestCancel;

@end

#endif /* OssService_h */
