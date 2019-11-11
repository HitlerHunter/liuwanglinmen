//
//  OssService.m
//  OssIOSDemo
//
//  Created by 凌琨 on 15/12/15.
//  Copyright © 2015年 Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunOSSiOS/OSSService.h>
#import "OssService.h"


#define aliyun_endpoint @"http://oss-cn-shenzhen.aliyuncs.com"

NSString * const bucketName = @"wanquan888";
#define STSServer [BaseURL stringByAppendingString:@"/outside-biz/file/getSTS"]

static OssService *_service = nil;
@implementation OssService
{
    OSSClient * client;
    NSString * endPoint;
    NSString * callbackAddress;
    OSSPutObjectRequest * putRequest;
    OSSGetObjectRequest * getRequest;

    BOOL isCancelled;
}

+ (OssService *)service{

    BOOL timeOut = [[NSDate date] timeIntervalSinceDate:_service.date] > 60*60;
    if (timeOut || !_service.date) {
        _service = [[OssService alloc] init];
        _service.date = [NSDate date];
    }

    return _service;
}

//oss-cn-shenzhen.aliyuncs.com
- (id)init{

    if (self = [super init]) {
        endPoint = aliyun_endpoint;
        isCancelled = NO;
        [self ossInit];
    }
    return self;
}

/**
 *	@brief	获取FederationToken
 *
 *	@return OSSFederationToken
 */
- (OSSFederationToken *) getFederationToken {

    __block NSDictionary * object;
    __block NSError *_error;

    //1.创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //开始异步请求操作
        NSURL * url = [NSURL URLWithString:STSServer];
        //创建请求命令,并设置缓存策略
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
        request.HTTPMethod = @"POST";
        NSString *bodyStr = [@"roleName=" stringByAppendingString:@"IOS"];
        request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setValue:[NSString stringWithFormat:@"Bearer %@",CurrentUser.access_token] forHTTPHeaderField:@"Authorization"];
        //创建会话对象通过单例方法实现
        NSURLSession *session=[NSURLSession sharedSession];
        //执行会话的任务
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            _error = error;
            if (!error) {
                object = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions error:nil];
            }

            // 2.在网络请求结束后发送通知信号
            dispatch_semaphore_signal(semaphore);
        }];
        //开始执行任务
        [task resume];
    });
    // 3.发送等待信号
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //同步请求配置结束之后，结束阻塞

    // 实现这个回调需要同步返回Token，所以要waitUntilFinished

    if (_error) {
        return nil;
    } else {

        object = object[@"data"];
        OSSFederationToken * token = [OSSFederationToken new];
        token.tAccessKey = [object objectForKey:@"AccessKeyId"];
        token.tSecretKey = [object objectForKey:@"AccessKeySecret"];
        token.tToken = [object objectForKey:@"SecurityToken"];
        NSTimeInterval time = [[object objectForKey:@"Expiration"] integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //指定时间显示样式: HH表示24小时制 hh表示12小时制
        [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'Z'"];
        NSString *timeStr = [formatter stringFromDate:date];

        NSLog(@"timeStr:%@",timeStr);
        //指明Token的失效时间，格式为GMT字符串，如: "2015-11-03T08:51:05Z"
        
        token.expirationTimeInGMTFormat = timeStr;
        NSLog(@"AccessKey: %@ \n SecretKey: %@ \n Token:%@ expirationTime: %@ \n",
              token.tAccessKey, token.tSecretKey, token.tToken, token.expirationTimeInGMTFormat);
        
        return token;
    }
    
}

/**
 *	@brief	初始化获取OSSClient
 */
- (void)ossInit {
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        return [self getFederationToken];
    }];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
}


- (void)asyncPutFiles:(NSArray <UpLoadFileModel *> *)files
        oneCompletion:(void (^)(int index, UpLoadFileModel *backModel))oneCompletion
        allCompletion:(void (^)(void))allCompletion
              failure:(void (^)(NSError *error))failure{
    
//    NSMutableArray *tasks = [NSMutableArray arrayWithCapacity:files.count];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = files.count;
    
    __block int finishCount = 0;
    for (int i = 0; i < files.count; i++) {
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            UpLoadFileModel *model = files[i];
            model.index = i;
            
            if (model.UpLoadType == OSSUpLoadDataTypeFile || model.UpLoadType == OSSUpLoadDataTypeSubFile) {
                //任务执行
                OSSTask *task = nil;
                if(model.UpLoadType == OSSUpLoadDataTypeFile){//only file
                    
                    if (model.dataFromWay == OSSUpLoadDataFromWayData) {
                        task = [self asyncPutImage:model.fileName imageData:model.fileData];
                    }else {
                        task = [self asyncPutImage:model.fileName localFilePath:model.filePath];
                    }
                   
                }else {// only subFile
                    
                    if (model.dataFromWay == OSSUpLoadDataFromWayData) {
                        task = [self asyncPutImage:model.subFileName imageData:model.subFileData];
                    }else {
                        task = [self asyncPutImage:model.subFileName localFilePath:model.subFilePath];
                    }
                   
                }
                [task waitUntilFinished]; // 阻塞直到上传完成
                if (!task.error) {
                    NSLog(@"upload object success!");
                    
                    //success
                    [self uploadSuccessWithFile:model];

                    finishCount += 1;
                    if(oneCompletion) oneCompletion(i,model);
                    
                    if (finishCount == files.count) {
                        if(allCompletion) allCompletion();
                    }
                    
                } else {
                    NSLog(@"upload object failed, error: \n%@" , task.error);
                    if(failure) failure(task.error);
                }
            }else if(model.UpLoadType == OSSUpLoadDataTypeFileAddSubFile){
             
                //任务执行
                OSSTask *task = nil;
                OSSTask *subTask = nil;
                
                if (model.dataFromWay == OSSUpLoadDataFromWayData) {
                    task = [self asyncPutImage:model.fileName imageData:model.fileData];
                    [task waitUntilFinished]; // 阻塞直到上传完成
                    subTask = [self asyncPutImage:model.subFileName imageData:model.subFileData];
                    [subTask waitUntilFinished]; // 阻塞直到上传完成
                }else {
                    task = [self asyncPutImage:model.fileName localFilePath:model.filePath];
                    [task waitUntilFinished]; // 阻塞直到上传完成
                    subTask = [self asyncPutImage:model.subFileName localFilePath:model.subFilePath];
                    [subTask waitUntilFinished]; // 阻塞直到上传完成
                }
                
                if (!subTask.error) {
                    NSLog(@"upload object success!");
                    //success
                    [self uploadSuccessWithFile:model];

                    finishCount += 1;
                    
                    if(oneCompletion) oneCompletion(i,model);
                    if (finishCount == files.count) {
                        if(allCompletion) allCompletion();
                    }
                    
                } else {
                    NSLog(@"upload object failed, error: %@" , task.error);
                    if(failure) failure(task.error);
                }
            }else if(model.UpLoadType == OSSUpLoadDataTypeNOFile){
                
                finishCount += 1;
                if(oneCompletion) oneCompletion(i,model);
                
                if (finishCount == files.count) {
                    if(allCompletion) allCompletion();
                }
            }
            
        }];
        if (queue.operations.count != 0) {
            [operation addDependency:queue.operations.lastObject];
        }
        [queue addOperation:operation];
    }
    
    [queue waitUntilAllOperationsAreFinished];
    

}
    
- (void)asyncPutOnlyFile:(UpLoadFileModel *)file
            oneCompletion:(void (^)(int index, UpLoadFileModel *backModel))oneCompletion
             andProgress:(OSSNetworkingUploadProgressBlock)block
           allCompletion:(void (^)(void))allCompletion
                  failure:(void (^)(NSError *error))failure{
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        __block int finishCount = 0;
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                UpLoadFileModel *model = file;
                model.index = 0;
                if(model.UpLoadType == OSSUpLoadDataTypeFileAddSubFile){
                    
                    //任务执行
                    OSSTask *task = nil;
                    OSSTask *subTask = nil;
                    
                    if (model.dataFromWay == OSSUpLoadDataFromWayData) {
                        task = [self asyncPutImage:model.fileName imageData:model.fileData];
                        [task waitUntilFinished]; // 阻塞直到上传完成
                        subTask = [self asyncPutOnlyVideo:model.subFileName imageData:model.subFileData andProgressBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
                            block(bytesSent,totalBytesSent,totalBytesExpectedToSend);
                        }];
                        [subTask waitUntilFinished]; // 阻塞直到上传完成
                    }else {
                        task = [self asyncPutImage:model.fileName localFilePath:model.filePath];
                        [task waitUntilFinished]; // 阻塞直到上传完成
                        subTask = [self asyncPutImage:model.subFileName localFilePath:model.subFilePath];
                        [subTask waitUntilFinished]; // 阻塞直到上传完成
                    }
                    
                    if (!subTask.error) {
                        NSLog(@"upload object success!");
                        //success
//                        [self uploadSuccessWithFile:model];

//                        finishCount += 1;
                        
                        if(oneCompletion) oneCompletion(0,model);
                        if (finishCount == 0) {
                            if(allCompletion) allCompletion();
                        }
                        
                    } else {
                        NSLog(@"upload object failed, error: %@" , task.error);
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
}

/**
 *	@brief	上传图片
 *
 *	@param 	objectKey 	objectKey
 *	@param 	data 	文件数据
 */
- (OSSTask *)asyncPutImage:(NSString *)objectKey
        imageData:(NSData *)data
{
    if (objectKey == nil || [objectKey length] == 0) {
        return nil;
    }
    
    putRequest = [OSSPutObjectRequest new];
    putRequest.objectKey = objectKey;
    putRequest.uploadingData = data;

    return [self asyncPutImageWithOSSPutObjectRequest:putRequest];
}

/**
 *	@brief	上传图片
 *
 *	@param 	objectKey 	objectKey
 *	@param 	filePath 	路径
 */

- (OSSTask *)asyncPutImage:(NSString *)objectKey
        localFilePath:(NSString *)filePath {
    
    if (objectKey == nil || [objectKey length] == 0) {
        return nil;
    }
    
     putRequest = [OSSPutObjectRequest new];
    putRequest.objectKey = objectKey;
    putRequest.uploadingFileURL = [NSURL fileURLWithPath:filePath];
   
    return [self asyncPutImageWithOSSPutObjectRequest:putRequest];
}
    
- (OSSTask *)asyncPutOnlyVideo:(NSString *)objectKey
                 imageData:(NSData *)data
              andProgressBlock:(OSSNetworkingUploadProgressBlock)block{
        
        if (objectKey == nil || [objectKey length] == 0) {
            return nil;
        }
        
    putRequest = [OSSPutObjectRequest new];
    putRequest.objectKey = objectKey;
    putRequest.uploadingData = data;
    OSSTask *task = [self asyncPutImageWithOSSPutOnlyObjectRequest:putRequest andProgressBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        block(bytesSent,totalBytesSent,totalBytesExpectedToSend);
    }];
        return task;
}

- (OSSTask *)asyncPutImageWithOSSPutObjectRequest:(OSSPutObjectRequest *)request {
    
    request.bucketName = bucketName;
    /*
    //进度
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    */
    OSSTask * task = [client putObject:request];
    
    return task;
}

- (OSSTask *)asyncPutImageWithOSSPutOnlyObjectRequest:(OSSPutObjectRequest *)request andProgressBlock:(OSSNetworkingUploadProgressBlock)block {
        
        request.bucketName = bucketName;
         //进度
         request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
             block(bytesSent,totalByteSent,totalBytesExpectedToSend);
         };
        OSSTask * task = [client putObject:request];
        
        return task;
}

- (void)uploadSuccessWithFile:(UpLoadFileModel *)file {

    if (file.UpLoadType == OSSUpLoadDataTypeFile) {
        file.fileName = [NSString stringWithFormat:@"%@%@",aliyun_url,file.fileName];
    }else if (file.UpLoadType == OSSUpLoadDataTypeSubFile) {
        file.subFileName = [NSString stringWithFormat:@"%@%@",aliyun_url,file.subFileName];
    }else if (file.UpLoadType == OSSUpLoadDataTypeFileAddSubFile) {
        file.fileName = [NSString stringWithFormat:@"%@%@",aliyun_url,file.fileName];
        file.subFileName = [NSString stringWithFormat:@"%@%@",aliyun_url,file.subFileName];
    }
}

/**
 *	@brief	下载图片
 *
 *	@param 	objectKey
 */
- (void)asyncGetImage:(NSString *)objectKey {
    if (objectKey == nil || [objectKey length] == 0) {
        return;
    }
    getRequest = [OSSGetObjectRequest new];
    getRequest.bucketName = bucketName;
    getRequest.objectKey = objectKey;
    OSSTask * task = [client getObject:getRequest];
    [task continueWithBlock:^id(OSSTask *task) {
        OSSGetObjectResult * result = task.result;
        if (!task.error) {
            NSLog(@"Get image success!");
            dispatch_async(dispatch_get_main_queue(), ^{
//                [viewController saveAndDisplayImage:result.downloadedData downloadObjectKey:objectKey];
//                [viewController showMessage:@"普通下载" inputMessage:@"Success!"];
            });
        } else {
            NSLog(@"Get image failed, %@", task.error);
            if (task.error.code == OSSClientErrorCodeTaskCancelled) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [viewController showMessage:@"普通下载" inputMessage:@"任务取消!"];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [viewController showMessage:@"普通下载" inputMessage:@"Failed!"];
                });
            }
        }
        getRequest = nil;
        return nil;
    }];
}



/**
 *	@brief	普通上传/下载取消
 */
- (void)normalRequestCancel {
    if (putRequest) {
        [putRequest cancel];
    }
    if (getRequest) {
        [getRequest cancel];
    }
}

@end
