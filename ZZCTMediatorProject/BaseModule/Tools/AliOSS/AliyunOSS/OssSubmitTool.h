//
//  OssSubmitTool.h
//  Youdoneed
//
//  Created by 方青 on 2017/12/1.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OssSubmitTool : NSObject

/**
    直传图片到阿里云
 */
+ (void) ossSubmitImageArray:(NSArray *)imageArray allCompletion:(void (^)(NSArray *result))allCompletion
                     failure:(void (^)(NSError *error))failure;

@end
