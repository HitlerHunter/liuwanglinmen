//
//  EditPhotoPreviewViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

@protocol EditPhotoPreviewDelegate <NSObject>

- (void)editPhotoPreviewDidRemovePhotoAtIndex:(NSInteger)index;

@end

@interface EditPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@end

NS_ASSUME_NONNULL_BEGIN
@class EditPhotoModel;
@interface EditPhotoPreviewViewController : SDBaseViewController

@property (nonatomic, weak) id <EditPhotoPreviewDelegate> delegate;

- (instancetype)initWithDataArray:(NSArray <EditPhotoModel *>*)array
                       startIndex:(NSInteger)startIndex;

@end

NS_ASSUME_NONNULL_END
