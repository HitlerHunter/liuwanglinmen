//
//  SPKeyBoardButton.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LZKeyBoardTitleColor UIColorHex(0x3A3A3A)
#define LZKeyBoardBtnBGColor [UIColor whiteColor]

typedef NS_ENUM(NSUInteger, ContentDirection) {
    ContentDirectionCenter = 0,
    ContentDirectionLeft = 1,
//    ContentDirectionRight = 2,
};

@interface SPKeyBoardButton : UIButton

@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) ContentDirection direction;
@end
