//
//  FilterModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@end
