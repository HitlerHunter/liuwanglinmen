//
//  OssSubmitTool.m
//  Youdoneed
//
//  Created by 方青 on 2017/12/1.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "OssSubmitTool.h"


@implementation OssSubmitTool

+ (void)submitImageDatas:(NSArray *)imageDatas
               allCompletion:(void (^)(NSArray *result))allCompletion
                     failure:(void (^)(NSError *error))failure{
    WeakSelf(weakSelf)
    //直传阿里云
    OssService *service = [[OssService alloc] init];

    //上传文件
    NSMutableArray *fileModels = [NSMutableArray arrayWithCapacity:imageDatas.count];

    // 总大小
    unsigned long long fileSize = 0;
    for (NSInteger i = 0; i < imageDatas.count; i++) {

        //set upload imageData
        UpLoadFileModel *upLoadFile = [UpLoadFileModel new];
        upLoadFile.fileData = imageDatas[i];
//        upLoadFile.fileName = [NSString stringWithFormat:@"%@.%@",[NSUUID UUID].UUIDString,model.imageData.format];
        upLoadFile.UpLoadType = OSSUpLoadDataTypeFile;

        //文件大小
        fileSize += upLoadFile.fileData.length;

        //set upload videoData
        if (1) {
//            upLoadFile.subFileData = model.videoData;
//            upLoadFile.subFileName = [NSString stringWithFormat:@"%@.%@",[NSUUID UUID].UUIDString,model.videoData.format];
            upLoadFile.UpLoadType = OSSUpLoadDataTypeFileAddSubFile;

            //文件大小
            fileSize += upLoadFile.subFileData.length;
        }

        [fileModels addObject:upLoadFile];

    }


    //begin upload
    [service asyncPutFiles:fileModels oneCompletion:^(int index,UpLoadFileModel *file) {

        if (file.UpLoadType == OSSUpLoadDataTypeFile) {
//            model.imageUrl = file.fileName;
        }else if (file.UpLoadType == OSSUpLoadDataTypeSubFile) {

        }else if (file.UpLoadType == OSSUpLoadDataTypeFileAddSubFile) {
//            model.imageUrl = file.fileName;
//            model.videoUrl = file.subFileName;
        }

        

    } allCompletion:^{

    } failure:^(NSError *error) {

    }];
}

@end
