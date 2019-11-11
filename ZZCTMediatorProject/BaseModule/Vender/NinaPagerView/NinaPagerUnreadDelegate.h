//
//  NinaPagerUnreadDelegate.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/24.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BillBaseUnreadDelegate <NSObject>

- (void)updataUnreadCount:(NSInteger)unreadCount pageIndex:(NSInteger)index;

@end

@protocol NinaPagerUnreadDelegate <NSObject>

@property (nonatomic, assign) NSInteger unreadCount;

@optional
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) id <BillBaseUnreadDelegate> unreadDelegate;

@required
- (void)updataUnreadCount;
@end
