//
//  GlobaColor.h
//  YaYingInternational
//
//  Created by 曾立志 on 2017/12/25.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

#ifndef GlobaColor_h
#define GlobaColor_h

//color
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define rgb(r, g, b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]
#define rgba(r, g, b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 公共
#define LZBackgroundColor rgb(242,242,242)
#define LZNavBarBackgroundColor UIColorHex(0xffffff)
#define LZNavBarTitleColor UIColorHex(0x2B2B2B)

#define LZWhiteColor UIColorHex(0xffffff)
#define LZLineColor UIColorHex(0xE1E0E1)
#define LZRedColor UIColorHex(0xC94340)
#define LZRedColor_1 UIColorHex(0xE93323)
#define LZBuleColor UIColorHex(0x6591D3)
#define LZGreenColor UIColorHex(0x07C667)

#define LZMainColor UIColorHex(0xDEB675)
#define LZOrangeColor rgb(255,81,0)
#define LZBtnOrangeColor UIColorHex(0xE1B56D)
#define LZBlackTextColor UIColorHex(0x3A3A3A)

#define LZLodingBtnNormalColor LZMainColor
#define LZMianBtnDisableColor [LZLodingBtnNormalColor colorWithAlphaComponent:0.8]

#endif /* GlobaColor_h */
