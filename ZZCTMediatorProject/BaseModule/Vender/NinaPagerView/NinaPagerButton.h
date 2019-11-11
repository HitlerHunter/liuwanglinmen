//
//  NinaPagerButton.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/24.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NinaPagerButton : UIButton
@property (nonatomic, assign) NSInteger unreadCount;

- (void)readAll;
@end
