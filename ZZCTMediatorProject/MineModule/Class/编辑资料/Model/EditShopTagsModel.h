//
//  EditShopTagsModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, EditShopTagsType) {
    EditShopTagsTypeTag,
    EditShopTagsTypeAdd,
};

@interface EditShopTagsModel : NSObject

@property (nonatomic, strong) NSString *structDesc;//title
@property (nonatomic, strong) NSString *shopId;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) EditShopTagsType type;

@end

NS_ASSUME_NONNULL_END
