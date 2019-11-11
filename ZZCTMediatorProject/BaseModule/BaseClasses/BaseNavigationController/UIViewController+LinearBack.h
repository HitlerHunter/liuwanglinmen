//
//  UIViewController+LinearBack.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LinearBack)

//@property (nonatomic, strong) NSMutableDictionary *linearBackDictionary;

- (NSMutableDictionary *)linearBackDictionary;
- (void)lineBackWithId:(NSString *)Id;
@end
