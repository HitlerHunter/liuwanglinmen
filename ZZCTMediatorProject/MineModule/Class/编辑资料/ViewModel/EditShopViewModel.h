//
//  EditShopViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EditShopModel;
typedef void(^GetShopModelBlock)(EditShopModel *shopModel);

@interface EditShopViewModel : NSObject

/**根据商户id查询店铺信息*/
+ (void)getShopInfoWithBlock:(GetShopModelBlock)block;
/**修改店铺信息*/
+ (void)editShopInfoWithShopModel:(EditShopModel *)shopModel Block:(SimpleBoolBlock)block;
/**添加店铺信息*/
+ (void)creatShopInfoWithShopModel:(EditShopModel *)shopModel Block:(SimpleBoolBlock)block;
@end

NS_ASSUME_NONNULL_END
