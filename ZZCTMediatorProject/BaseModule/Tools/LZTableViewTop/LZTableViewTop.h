//
//  LZTableViewTop.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZTableViewTop : NSObject

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL hasAddTop;

+ (LZTableViewTop *)topViewWithScrollView:(UIScrollView *)scrollView image:(UIImage *)image;

//- (void)addTopImageViewWithImage:(UIImage *)image;
@end
