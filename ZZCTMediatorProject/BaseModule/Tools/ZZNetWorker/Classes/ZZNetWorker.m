//
//  NetworkHelper.m
//  FlowerField
//
//  Created by 郑佳 on 2017/8/20.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import "ZZNetWorker.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"

@interface ZZNetWorker ()

@property (nonatomic, strong) ZZNetWorkerParamBlock paramHandlerBlock;
@property (nonatomic, strong) ZZNetWorkerDefaultBlock defaultHandlerBlock;
@end

@implementation ZZNetWorker

+ (instancetype)woker {
    
    static ZZNetWorker *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ZZNetWorker alloc]init];
        _instance.method = GET;
        _instance.url = @"";
        _instance.param = nil;
    });
    return _instance;
}

+ (ZZNetWorker *)POST{
   ZZNetWorker *woker = [ZZNetWorker woker];
    [woker clearData];
    woker.method = POST;
    return woker;
}

+ (ZZNetWorker *)FormData{
    ZZNetWorker *woker = [ZZNetWorker woker];
    [woker clearData];
    woker.method = FormData;
    return woker;
}

+ (ZZNetWorker *)GET{
    ZZNetWorker *woker = [ZZNetWorker woker];
    [woker clearData];
    woker.method = GET;
    return woker;
}

+ (ZZNetWorker *)DELETE{
    ZZNetWorker *woker = [ZZNetWorker woker];
    [woker clearData];
    woker.method = DELETE;
    return woker;
}

+ (ZZNetWorker *)PUT{
    ZZNetWorker *woker = [ZZNetWorker woker];
    [woker clearData];
    woker.method = PUT;
    return woker;
}

//+ (ZZNetWorker *)UpLoadFile{
//    ZZNetWorker *woker = [ZZNetWorker woker];
//    [woker clearData];
//    woker.method = UpLoadFile;
//    return woker;
//}

- (void)clearData{
    
    self.url = @"";
    self.param = nil;
    self.isOpenLog = NO;
    self.isPostByURLSession = YES;
    self.paramType = ZZNetWorkerParamTypeNormalBody;
    
    if (self.defaultHandlerBlock) {
        self.defaultHandlerBlock(self);
    }
}

- (void)requestMethod:(ZZNetWorkerMethod)method url:(NSString *)url parameters:(id)parameters finishBlock:(ZZNetWorkerCompletionBlock)finishBlock {
    
    //set token
    if (self.Authorization.length) {
        [self.manager.requestSerializer setValue:self.Authorization forHTTPHeaderField:@"Authorization"];
    }
    
    SDLog(@"\n ZZNetWorker.Authorization: \n%@",self.Authorization);
    
    if (![url hasPrefix:@"http"] && self.baseUrl) {
        url = [self.baseUrl stringByAppendingString:url];
    }
    
    if (method == GET) {
        [self GET:url parameters:parameters finishBlock:finishBlock];
    }else if (method == DELETE) {
        [self sendRequestWithMethod:method URLString:url parameters:parameters finishBlock:finishBlock];
    }else if (method == PUT) {
        [self sendRequestWithMethod:method URLString:url parameters:parameters finishBlock:finishBlock];
    }else if (method == FormData) {
        [self FormData:url parameters:parameters finishBlock:finishBlock];
    }else {
        if (self.isPostByURLSession) {
            [self sendRequestWithMethod:POST URLString:url parameters:parameters finishBlock:finishBlock];
        }else{
            [self POST:url parameters:parameters finishBlock:finishBlock];
        }
        
    }
}

- (void)GET:(NSString *)URLString parameters:(id)parameters finishBlock:(void (^)(id, NSError *))finishBlock {
    
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [ZZNetWorkHandler jsonFromResponseObject:responseObject];
        if (self.isOpenLog) {
            SDLog(@"\n ZZNetWorker:\n url:%@ \n param:%@ \n response :%@ \n message = %@ \n",URLString,parameters,dic,dic[@"msg"]);
        }
        if (![self checkResult:dic]) {
            return ;
        }
        finishBlock(dic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.isOpenLog) {
            NSData *datae = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:datae encoding:NSUTF8StringEncoding];
            NSLog(@"\n ZZNetWorker:\n  url:%@ \n param:%@ \n error:%@ \n ",URLString,parameters,errorStr);
        }
        finishBlock(nil,error);
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters finishBlock:(void (^)(id, NSError *))finishBlock {
    
    [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [ZZNetWorkHandler jsonFromResponseObject:responseObject];
        if (self.isOpenLog) {
            SDLog(@"\n ZZNetWorker:\n url:%@ \n param:%@ \n response :%@ \n message = %@ \n",URLString,parameters,dic,dic[@"msg"]);
        }
        if (![self checkResult:dic]) {
            return ;
        }
        finishBlock(dic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.isOpenLog) {
            NSData *datae = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:datae encoding:NSUTF8StringEncoding];
            NSLog(@"\n ZZNetWorker:\n  url:%@ \n param:%@ \n error:%@ \n ",URLString,parameters,errorStr);
        }
        finishBlock(nil,error);
    }];
    
}

- (void)FormData:(NSString *)URLString parameters:(id)parameters finishBlock:(void (^)(id, NSError *))finishBlock {
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [self.manager POST:URLString parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            NSArray *keys = [parameters allKeys];
            
            for (NSString *key in keys) {
                id obj = parameters[key];
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
                    [formData appendPartWithFormData:jsonData name:key];
                }else if ([obj isKindOfClass:[NSString class]]) {
                    NSData *jsonData = [obj dataUsingEncoding:NSUTF8StringEncoding];
                    [formData appendPartWithFormData:jsonData name:key];
                }
                
            }
        }

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [ZZNetWorkHandler jsonFromResponseObject:responseObject];
        if (self.isOpenLog) {
            SDLog(@"\n ZZNetWorker:\n url:%@ \n param:%@ \n response :%@ \n message = %@ \n",URLString,parameters,dic,dic[@"msg"]);
        }
        if (![self checkResult:dic]) {
            return ;
        }
        finishBlock(dic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.isOpenLog) {
            NSData *datae = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:datae encoding:NSUTF8StringEncoding];
            NSLog(@"\n ZZNetWorker:\n  url:%@ \n param:%@ \n error:%@ \n ",URLString,parameters,errorStr);
        }
        finishBlock(nil,error);
    }];
    
}

- (void)sendRequestWithMethod:(ZZNetWorkerMethod)method URLString:(NSString *)URLString parameters:(id)parameters finishBlock:(void (^)(id, NSError *))finishBlock {
    
    NSURL *url = nil;
    
     if (self.paramType == ZZNetWorkerParamTypeAppendAfterURL) {
         
         NSMutableString *dataStr = [[NSMutableString alloc] initWithString:URLString];
         [dataStr appendString:@"?"];
         
         NSArray *keys = [parameters allKeys];
         for (NSString *key in keys) {
             id obj = parameters[key];
             [dataStr appendFormat:@"%@=%@&",key,obj];
         }
         
         [dataStr deleteCharactersInRange:NSMakeRange(dataStr.length-1, 1)];
         
         url=[NSURL URLWithString:[dataStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
     }else{
         url=[NSURL URLWithString:URLString];
     }
    
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    if (method == POST) {
        request.HTTPMethod = @"POST";
    }else if (method == GET) {
        request.HTTPMethod = @"GET";
    }else if (method == DELETE) {
        request.HTTPMethod = @"DELETE";
    }else if (method == PUT) {
        request.HTTPMethod = @"PUT";
    }
    
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"iOS" forHTTPHeaderField:@"clientType"];
    
    if (self.Authorization) {
        [request setValue:self.Authorization forHTTPHeaderField:@"Authorization"];
    }
    
    if (self.paramType == ZZNetWorkerParamTypeFormData) {
        NSMutableString *dataStr = [[NSMutableString alloc] init];
        
        NSArray *keys = [parameters allKeys];
        for (NSString *key in keys) {
            id obj = parameters[key];
            [dataStr appendFormat:@"%@=%@&",key,obj];
        }
        
        [dataStr deleteCharactersInRange:NSMakeRange(dataStr.length-1, 1)];
        NSData *paramData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = paramData;
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
    }else if (self.paramType == ZZNetWorkerParamTypeNormalBody) {
        
        if (parameters) {
            NSError *error = nil;
            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
            request.HTTPBody = data;
        }
        
    }else{
        if (parameters) {
            NSError *error = nil;
            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
            request.HTTPBody = data;
        }
    }
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [ZZNetWorkHandler jsonFromResponseObject:data];
            if (self.isOpenLog) {
                SDLog(@"\n ZZNetWorker:\n url:%@ \n param:%@ \n response :%@ \n message = %@ \n",URLString,parameters,dic,dic[@"msg"]);
            }
            dispatch_main_async_safe(^{
                if (![self checkResult:dic]) {
                    return ;
                }
                finishBlock(dic,nil);
            });
            
        }else{
            if (self.isOpenLog) {
                NSData *datae = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
                NSString *errorStr = [[ NSString alloc ] initWithData:datae encoding:NSUTF8StringEncoding];
                NSLog(@"\n ZZNetWorker:\n  url:%@ \n param:%@ \n error:%@ \n ",URLString,parameters,errorStr);
            }
            
            dispatch_main_async_safe(^{
                finishBlock(nil,error);
            });
        }
    }];
    
    [sessionDataTask resume];
}

- (NSURLSessionDataTask *)UploadImage:(NSString *)URLString
         parameters:(id)parameters
               data:(NSData *)data
           progress:(void (^)(NSProgress * uploadProgress))progress
        finishBlock:(ZZNetWorkerCompletionBlock)finishBlock {
    
   return [self.manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
       
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress)progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [ZZNetWorkHandler jsonFromResponseObject:responseObject];
        if (self.isOpenLog) {
            SDLog(@"\n ZZNetWorker:\n url:%@ \n param:%@ \n response :%@ \n message = %@ \n",URLString,parameters,dic,dic[@"msg"]);
        }
        if (![self checkResult:dic]) {
            return ;
        }
        finishBlock(dic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.isOpenLog) {
            NSData *datae = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
            NSString *errorStr = [[ NSString alloc ] initWithData:datae encoding:NSUTF8StringEncoding];
            NSLog(@"\n ZZNetWorker:\n  url:%@ \n param:%@ \n error:%@ \n ",URLString,parameters,errorStr);
        }
        finishBlock(nil,error);
    }];
    
    
}

+ (void)uploadImage1:(UIImage *)image1
               block:(ZZNetWorkerUploadImageFinishBlock)block{
    [self uploadImage1:image1 compressionQuality:0.7 block:block];
};

+ (void)uploadImage1:(UIImage *)image1
  compressionQuality:(CGFloat)compressionQuality
               block:(ZZNetWorkerUploadImageFinishBlock)block{
    [SVProgressHUD show];
    
    NSData *imageData1 = UIImageJPEGRepresentation(image1, compressionQuality);
    UpLoadFileModel *file1 = [UpLoadFileModel new];
    file1.dataFromWay = OSSUpLoadDataFromWayData;
    file1.fileData = imageData1;
    file1.UpLoadType = OSSUpLoadDataTypeFile;
    file1.index = 0;
    file1.fileName = @"png".randomStrForURL;
    
    __block NSString *imageUrl1 = nil;
    
    [[OssService service] asyncPutFiles:@[file1] oneCompletion:^(int index, UpLoadFileModel *backModel) {
        imageUrl1 = backModel.fileName;
        
        SDLog(@"imageUrl_%d : \n%@",index,backModel.fileName);
    } allCompletion:^{
        [SVProgressHUD dismiss];
        if (block) {
            dispatch_main_async_safe(^{
                block(YES,imageUrl1);
            });
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"上传图片失败！"];
    }];
}


- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 15;
        [_manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"clientType"];
        
    }
    return _manager;
}

- (ZZNetWorker *(^)(NSString *))zz_url{
    return ^id (NSString *url){
        self.url = url;
        return self;
    };
}

- (ZZNetWorker *(^)(NSString *))zz_authorization{
    return ^id (NSString *authorization){
        self.Authorization = authorization;
        return self;
    };
}

- (ZZNetWorker *(^)(NSString *))zz_baseUrl{
    return ^id (NSString *baseUrl){
        self.baseUrl = baseUrl;
        return self;
    };
}

- (ZZNetWorker *(^)(id))zz_param{
    return ^id (id param){
        if (self.paramHandlerBlock) {
            self.param = self.paramHandlerBlock(param,self);
        }else{
            self.param = param;
        }
        return self;
    };
}

- (ZZNetWorker *(^)(BOOL))zz_log{
    return ^id (BOOL isOpenLog){
        self.isOpenLog = isOpenLog;
        return self;
    };
}

- (ZZNetWorker *(^)(BOOL))zz_willHandlerParam{
    return ^id (BOOL willHandlerParam){
        self.willHandlerParam = willHandlerParam;
        return self;
    };
}



- (ZZNetWorker *(^)(ZZNetWorkerCompletionBlock))zz_completion{
    return ^id (ZZNetWorkerCompletionBlock block){
        [self requestMethod:self.method url:self.url parameters:self.param finishBlock:block];
        return self;
    };
}

- (ZZNetWorker *(^)(ZZNetWorkerManagerBlock))zz_manager{
    return ^id (ZZNetWorkerManagerBlock block){
        if(block) block(self.manager);
        return self;
    };
}

- (ZZNetWorker *(^)(ZZNetWorkerParamBlock))zz_handlerParam{
    return ^id (ZZNetWorkerParamBlock block){
        self.paramHandlerBlock = block;
        return self;
    };
}

- (ZZNetWorker *(^)(ZZNetWorkerDefaultBlock))zz_defaultRequest{
    return ^id (ZZNetWorkerDefaultBlock block){
        self.defaultHandlerBlock = block;
        return self;
    };
}

- (ZZNetWorker *(^)(void))zz_setContentTypeJson{
    return ^id (){
        
        return self;
    };
}

- (ZZNetWorker *(^)(ZZNetWorkerParamType))zz_setParamType{
    return ^id (ZZNetWorkerParamType type){
        self.paramType = type;
        return self;
    };
}

- (ZZNetWorker *(^)(void))zz_setContentTypeNil{
    return ^id (){
        [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type"];
        return self;
    };
}


- (ZZNetWorker *(^)(BOOL))zz_isPostByURLSession{
    return ^id (BOOL isPostByURLSession){
        self.isPostByURLSession = isPostByURLSession;
        return self;
    };
}

- (void)showMessage:(NSString *)message{
    [SVProgressHUD showImage:nil status:message];
}

- (BOOL)checkResult:(NSDictionary *)dic{
    NSInteger code = [dic[@"code"] integerValue];
    if (code == 0001) {
        [self  showLoginViewController];
        return NO;
    }
    
    if ([dic[@"error"] length] > 0) {
        [self showMessage:dic[@"error"]];
        return NO;
    }
    
    return YES;
}

- (void)showLoginViewController{
    [self showMessage:@"登录信息已过期，请重新登录！"];
    [CurrentUser loginOut];
    [[CTMediator sharedInstance] CTMediator_showLoginViewController];
    [self.manager.operationQueue cancelAllOperations];
}

@end

/*
 //分割符
 NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
 //分界线 --AaB03x
 NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
 //结束符 AaB03x--
 NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
 //http 参数body的字符串
 NSMutableString *paraBody=[[NSMutableString alloc]init];
 //参数的集合的所有key的集合
 NSArray *keys= [parameters allKeys];
 //遍历keys
 for(int i = 0; i < [keys count] ; i++)
 {
 //得到当前key
 NSString *key=[keys objectAtIndex:i];
 //添加分界线，换行
 [paraBody appendFormat:@"%@\r\n",MPboundary];
 //添加字段名称，换2行
 [paraBody appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
 //添加字段的值
 [paraBody appendFormat:@"%@\r\n",[parameters objectForKey:key]];
 
 NSLog(@"参数%@ == %@",key,[parameters objectForKey:key]);
 }
 
 //声明myRequestData，用来放入http body
 NSMutableData *myRequestData = [[NSMutableData alloc] init];
 //将body字符串转化为UTF8格式的二进制
 [myRequestData appendData:[paraBody dataUsingEncoding:NSUTF8StringEncoding]];
 
 //声明结束符：--AaB03x--
 NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
 //加入结束符--AaB03x--
 [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
 
 //设置HTTPHeader中Content-Type的值
 NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
 //设置HTTPHeader
 [request setValue:content forHTTPHeaderField:@"Content-Type"];
 //设置Content-Length
 [request setValue:[NSString stringWithFormat:@"%lu", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
 //设置http body
 [request setHTTPBody:myRequestData];
 */
