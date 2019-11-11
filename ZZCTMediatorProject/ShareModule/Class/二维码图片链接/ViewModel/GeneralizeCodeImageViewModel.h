//
//  GeneralizeCodeImageViewModel.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralizeCodeImageModel.h"

@interface GeneralizeCodeImageViewModel : NSObject

+ (void)requestDatas:(void (^)(NSArray *arr))block;
@end
