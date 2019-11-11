//
//  GeneralizeCodeImageModel.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GeneralizeCodeImageModel : NSObject

@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *px;
@property (nonatomic, strong) NSString *py;
@property (nonatomic, strong) NSString *plen;
@property (nonatomic, strong) NSString *pwth;
@property (nonatomic, strong) NSString *explains;
@property (nonatomic, strong) NSString *appId;

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger index;
@end
