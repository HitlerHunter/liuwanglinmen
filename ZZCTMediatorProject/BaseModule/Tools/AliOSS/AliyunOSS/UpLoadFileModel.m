//
//  UpLoadFileModel.m
//  Youdoneed
//
//  Created by 曾立志 on 2017/10/21.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "UpLoadFileModel.h"

@implementation UpLoadFileModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataFromWay = OSSUpLoadDataFromWayData;
        self.UpLoadType = OSSUpLoadDataTypeFile;
    }
    return self;
}
@end
