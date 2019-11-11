//
//  NinaPagerSonDelegate.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NinaPagerSonDelegate <NSObject>


- (void)requestWithYear:(NSString *)year month:(NSString *)month;
@end
