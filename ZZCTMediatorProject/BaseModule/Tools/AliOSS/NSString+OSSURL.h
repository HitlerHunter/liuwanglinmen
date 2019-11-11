//
//  NSString+OSSURL.h
//  YaYingInternational
//
//  Created by 曾立志 on 2018/1/24.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OSSURLString)
/**完整的文件url*/
//@property (nonatomic, strong , readonly) NSString *OSSURLString;
/**上传的url, jpg、MP4等 格式调此方法*/
@property (nonatomic, strong, readonly) NSString *OSSURLFormatString;
@property (nonatomic, strong, readonly) NSString *randomStrForURL;

@property (nonatomic, strong, readonly) NSString *(^resizeUrlBlock)(CGFloat w,CGFloat h);
@end
