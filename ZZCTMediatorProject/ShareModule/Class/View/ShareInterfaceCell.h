//
//  ShareInterfaceCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareInterfaceCell : SDBaseView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *btnTitle;

@property (nonatomic, strong) void (^block)(void);

+ (ShareInterfaceCell *)cellWithLogo:(UIImage *)logo
                               title:(NSString *)title
                            subTitle:(NSString *)subTitle
                            btnTitle:(NSString *)btnTitle
                               block:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
