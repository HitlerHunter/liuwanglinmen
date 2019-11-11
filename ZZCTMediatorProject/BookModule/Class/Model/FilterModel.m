//
//  FilterModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel

- (CGFloat)width{
    CGFloat w = [self widthOfString];
    
    return w<=70?70:w;
}

- (CGFloat)height{
    return 30;
}

- (CGFloat) widthOfString{
    
    NSDictionary *dic = @{NSFontAttributeName:kfont(14)};
        // 计算文本的大小
    CGSize sizeToFit = [self.title boundingRectWithSize:CGSizeMake(140, self.height) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.width + 16.0;
}

@end
