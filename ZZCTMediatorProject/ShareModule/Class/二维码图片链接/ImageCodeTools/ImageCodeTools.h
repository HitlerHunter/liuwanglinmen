//
//  ImageCodeTools.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralizeCodeImageModel.h"

@interface ImageCodeTools : NSObject


+ (UIImage *)addGeneralizeCodeImageModel:(GeneralizeCodeImageModel *)model
                                 toImage:(UIImage *)image;

    //生成制定大小的黑白二维码
+ (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size;
@end
