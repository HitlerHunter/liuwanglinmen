//
//  CommenBlock.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#ifndef CommenBlock_h
#define CommenBlock_h

typedef void(^SimpleObjBlock)(id _Nullable obj);
typedef void(^SimpleBoolBlock)(BOOL success);
typedef void(^SimpleObjBoolBlock)(id _Nullable obj,BOOL success);
typedef void(^SimpleObjMsgBoolBlock)(id _Nullable obj,NSString * _Nullable msg,BOOL success);

typedef void(^SimpleArrayMsgBoolBlock)(NSMutableArray * _Nullable datas,NSString * _Nullable msg,BOOL success);

typedef void (^NSProgressBlock)(NSProgress * _Nonnull uploadProgress);
#endif /* CommenBlock_h */
