//
//  BillDetailViewController.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "SDBaseViewController.h"

@interface BillDetailViewController : SDBaseViewController

@property (nonatomic, strong) NSString *profitStr;

- (instancetype)initWithOrdId:(NSString *)ordId;
@end
