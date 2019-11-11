//
//  UpLoadFileModel.h
//  Youdoneed
//
//  Created by 曾立志 on 2017/10/21.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

typedef NS_ENUM(NSUInteger, OSSUpLoadDataFromWay) {
    /**data from data*/
    OSSUpLoadDataFromWayData = 10,
    /**data from path*/
    OSSUpLoadDataFromWayPath,
    
};

typedef NS_ENUM(NSUInteger, OSSUpLoadDataType) {
    /**only upload file*/
    OSSUpLoadDataTypeFile = 10,
    /**only upload subFile*/
    OSSUpLoadDataTypeSubFile,
    /**upload file and subFile*/
    OSSUpLoadDataTypeFileAddSubFile,
    
    /**will not upload and callBack*/
    OSSUpLoadDataTypeNOFile,
};

#import <Foundation/Foundation.h>

@interface UpLoadFileModel : NSObject
/*
 * @will get data Form data Or path
 * @default is from data
 */
@property (nonatomic, assign) OSSUpLoadDataFromWay dataFromWay;
/*
 * @will upload file Or subFile Or both
 * @default is only upload file
 */
@property (nonatomic, assign) OSSUpLoadDataType UpLoadType;

@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) NSData *subFileData;
@property (nonatomic, strong) NSString *subFileName;
@property (nonatomic, strong) NSString *subFilePath;
/*
 * @the index in queue
 */
@property (nonatomic, assign) NSInteger index;
/*
 * @the index in custom
 */
@property (nonatomic, assign) NSInteger coustomIndex;
@end
