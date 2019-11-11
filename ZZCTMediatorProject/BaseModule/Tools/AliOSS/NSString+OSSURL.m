//
//  NSString+OSSURL.m
//  YaYingInternational
//
//  Created by 曾立志 on 2018/1/24.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

#import "NSString+OSSURL.h"

#define OSSPath_image @""
@implementation NSString (OSSURLString)

/*
- (NSString *)OSSURLString{
    if (self.length>0) {
        if (![self hasPrefix:OSSURL] && ![self hasPrefix:@"http"]) {
            return [OSSURL stringByAppendingPathComponent:self];
        }
    }
    return self;
}
 */

- (NSString *)OSSURLFormatString{
    NSString *ossPath = @"";
    if ([self isEqualToString:@"jpg"] || [self isEqualToString:@"png"]) {
        ossPath = aliyun_url;
    }else if ([self isEqualToString:@"mp4"]){
//        ossPath = OSSPath_video;
    }else if ([self isEqualToString:@"spx"] || [self isEqualToString:@"mp3"]){
//        ossPath = OSSPath_audio;
    }

    return [ossPath stringByAppendingPathComponent:[self ossPathWithFileFormat:self]];
}

- (NSString *)randomStrForURL{
    
    return [self ossPathWithFileFormat:self];
}

- (NSString *)ossPathWithFileFormat:(NSString *)fileFormat{

    //[video/image/audio]/2018/01/01/[uid]_时间戳.后缀
    NSString *OSSFileName = @"";
    NSString *name = [NSString stringWithFormat:@"6wsh_%lld", (long long int)([NSDate date].timeIntervalSince1970*1000)];

//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy_MM_dd";
//    OSSFileName = [formatter stringFromDate:[NSDate date]];
    OSSFileName = [OSSFileName stringByAppendingPathComponent:name];
    OSSFileName = [OSSFileName stringByAppendingFormat:@".%@", fileFormat];
    return OSSFileName;
}


- (NSString *(^)(CGFloat, CGFloat))resizeUrlBlock{
    return ^(CGFloat w,CGFloat h){
        return [self reSizeImageAliYunUrlWithWidth:w heigh:h];
    };

}

- (NSString *)reSizeImageAliYunUrlWithWidth:(CGFloat)width heigh:(CGFloat)height{

    return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_lfit,w_%ld,h_%ld",self,(NSInteger)width,(NSInteger)height];

}
@end
