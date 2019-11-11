//
//  LFUpLicenseManger.m
//  BankCardScan
//
//  Created by linkface on 2018/9/7.
//  Copyright © 2018年 SenseTime. All rights reserved.
//

#import "LFUpDateLicenseManger.h"
#import "LFLivenessDetector.h"
#import "LFLoadLicense.h"
#import "LFEncryption.h"
#import "LFLicenseCache.h"

#define LFMaxRemainingTime 5
#define LFLicenseJsonUrlString @"https://cloud-license.linkface.cn/json/2019101514515628d8169f422d44e592c581970f5360cd.json"

@interface LFUpDateLicenseManger ()

@property (nonatomic, strong) NSString *licensePath;

@property (nonatomic, strong) NSString *cachePath;

@property(nonatomic,strong)NSString *md5String;

@end

@implementation LFUpDateLicenseManger

+ (instancetype)sharedManager {
    
    static LFUpDateLicenseManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LFUpDateLicenseManger alloc] init];
    });
    return sharedInstance;
}

+ (void)loadLicensePath:(NSString *)licensePath cachePath:(NSString *)cachePath {
    
    return [[LFUpDateLicenseManger sharedManager] loadLicensePath:licensePath cachePath:cachePath];
}

- (void)loadLicensePath:(NSString *)licensePath cachePath:(NSString *)cachePath {
    
    if (![licensePath isKindOfClass:[NSString class]] || !licensePath.length)
    {
        NSAssert(YES , @"默认license文件地址不能传空！");
    }

    self.licensePath = licensePath;
    self.cachePath = cachePath;
    
    // 是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [LFLivenessDetector loadLicensePath:cachePath];
    } else {
        [LFLivenessDetector loadLicensePath:licensePath];
    }
    
    if ([LFLivenessDetector getRemainingTime] < LFMaxRemainingTime || ![LFLivenessDetector isLicenseValid]) [self updateLicense];
}

- (void)updateLicense {
    
    [LFLoadLicense downLoadLicenseJsonUrl:LFLicenseJsonUrlString completeBlock:^(NSDictionary * _Nullable licenseJson, NSError * _Nullable error) {
        
        if(error == nil){
            self.md5String = licenseJson[@"md5"];
            [self downloadlicenseFile:licenseJson[@"lic_url"]];
        }
    }];
}

- (void)downloadlicenseFile:(NSString *)url {
    
    [LFLoadLicense downLoadLicenseUrl:url completeBlock:^(NSString * _Nullable license, NSError * _Nullable error) {
        
        if (error == nil){
            if ([self checkMd5String:license]){

                //校验成功
                if ([LFLicenseCache addLicCacheWithLicContent:license licCachePath:self.cachePath]) {
                    [LFLivenessDetector loadLicensePath:self.cachePath];
                }
            }else{

            }
        }
    }];
}

- (BOOL)checkMd5String:(NSString *)str {
    
    return [[LFEncryption md5String:str] isEqualToString:self.md5String];
}

@end
