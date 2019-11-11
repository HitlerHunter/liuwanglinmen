//
//  ChangeUserNameViewController.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

typedef void(^ChangeStringBlock)(NSString * _Nullable obj);
@interface ChangeUserNameViewController : SDBaseViewController

@property (nonatomic, strong) ChangeStringBlock finishBlock;
@property (nonatomic, strong) NSString *text;
@end
