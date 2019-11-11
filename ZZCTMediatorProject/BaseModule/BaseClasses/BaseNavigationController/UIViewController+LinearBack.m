//
//  UIViewController+LinearBack.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIViewController+LinearBack.h"
#import <objc/runtime.h>
@implementation UIViewController (LinearBack)



- (NSMutableDictionary *)linearBackDictionary{
    
    NSMutableDictionary *dic = [self ownLinearBackDictionary];
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
        [self setOwnLinearBackDictionary:dic];
    }
    
    return dic;
}


- (void)lineBackWithId:(NSString *)Id{
    
    id obj = [self.linearBackDictionary objectForKey:Id];
    if (![obj boolValue]) {
        [self.navigationController popToViewController:self animated:YES];
        return;
    }
    
    NSArray *VCArray = self.navigationController.viewControllers;
    if (VCArray.count) {
        NSInteger index = [VCArray indexOfObject:self];
        if (index > 0) {
            UIViewController *lastVC = [VCArray objectAtIndex:index-1];
            [lastVC lineBackWithId:Id];
        }
    }
}


- (NSMutableDictionary *)ownLinearBackDictionary
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOwnLinearBackDictionary:(NSMutableDictionary *)ownLinearBackDictionary
{
    objc_setAssociatedObject(self, @selector(ownLinearBackDictionary), ownLinearBackDictionary, OBJC_ASSOCIATION_RETAIN);
}
@end
