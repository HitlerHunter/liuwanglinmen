//
//  YPhotoGlobalVar.m
//  选择照片
//
//  Created by 彦鹏 on 16/8/23.
//  Copyright © 2016年 Huyp. All rights reserved.
//

#import "YPhotoGlobalVar.h"

@implementation YPhotoGlobalVar

static YPhotoGlobalVar *_yPhotoGlobalVar;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (_yPhotoGlobalVar==nil)
        {
            _yPhotoGlobalVar = [super allocWithZone:zone];
        }
    }
    return _yPhotoGlobalVar;
}
+ (instancetype)shareGlobalVar
{
    if (_yPhotoGlobalVar == nil) //防止频繁加锁
    {
        @synchronized(self)
        {
            if (_yPhotoGlobalVar==nil)//防止创建多次
            {
                _yPhotoGlobalVar = [[self alloc]init];
            _yPhotoGlobalVar.yesImg = [[UIImage imageNamed:@"YPhoto.bundle/y_icon_image_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            _yPhotoGlobalVar.noImg = [[UIImage imageNamed:@"YPhoto.bundle/y_icon_image_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
        }
    }
    return _yPhotoGlobalVar;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _yPhotoGlobalVar;
}

- (void)done{
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishSelectPhotos:)]) {
        [_delegate didFinishSelectPhotos:self];
    }
}

@end
