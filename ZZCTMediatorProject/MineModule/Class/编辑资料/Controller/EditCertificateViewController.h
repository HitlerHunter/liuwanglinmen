//
//  EditCertificateViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class EditPhotoModel;
@interface EditCertificateViewController : SDBaseViewController

@property (nonatomic, strong) void (^finishBlock)(EditPhotoModel *photoModel);
- (instancetype)initWithPhotoModel:(EditPhotoModel *)model;
@end

NS_ASSUME_NONNULL_END
