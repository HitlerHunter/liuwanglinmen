//
//  EditPhotoModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, EditPhotoCellType) {
    EditPhotoCellTypeImage,
    EditPhotoCellTypeAdd,
};

@interface EditPhotoModel : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) EditPhotoCellType cellType;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *shopId;
@end

NS_ASSUME_NONNULL_END
