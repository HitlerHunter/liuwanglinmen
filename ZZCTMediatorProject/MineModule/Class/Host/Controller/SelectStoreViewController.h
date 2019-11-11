//
//  SelectStoreViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/18.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

@interface SelectStoreViewController : SDBaseViewController

@property (nonatomic, strong) void (^block)(NSInteger index,NSString *name);

- (instancetype)initWithDataArray:(NSArray *)dataArray;
@end
