//
//  AuthenMerchantPhotoView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthenMerchantPhotoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *bgImageName;

@property (nonatomic, assign) BOOL canEdit;
@end

@interface AuthenMerchantPhotoItem : SDBaseView

@property (nonatomic, strong) AuthenMerchantPhotoModel *model;

@end

@interface AuthenMerchantPhotoView : SDBaseView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <AuthenMerchantPhotoModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
