//
//  LZAppBanks.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "LZAppBanks.h"

@implementation LZAppBanks

+ (NSArray *)bankArray{
    return @[@"工商银行",@"农业银行",@"中国银行",@"建设银行",
             @"交通银行",@"中信银行",@"光大银行",@"华夏银行",
             @"民生银行",@"广发银行",@"平安银行",@"招商银行",
             @"兴业银行",@"浦东发展银行",@"北京银行",@"恒丰银行",
             @"浙商银行",@"渤海银行",@"邮政储蓄银行",@"广州银行",
             @"浦发银行", @"上海银行", @"兰州银行", @"南京银行",
             @"宁波银行"];
    
}

+(UIImage*)getBankLog:(NSString *)bankName{
    
    UIImage *myImg = [UIImage imageNamed:@"defaultBankIcon"];
    
    if ([bankName isEqualToString:@"工商银行"]) {
        myImg = [UIImage imageNamed:@"gongshang"];
    }else if ([bankName isEqualToString:@"农业银行"]){
        myImg = [UIImage imageNamed:@"nongye"];
        
    }else if ([bankName isEqualToString:@"中国银行"]){
        myImg = [UIImage imageNamed:@"zhongguo"];
        
    }else if ([bankName isEqualToString:@"建设银行"]){
        myImg = [UIImage imageNamed:@"jianshe"];
        
    }else if ([bankName isEqualToString:@"交通银行"]){
        myImg = [UIImage imageNamed:@"jiaotong"];
        
    }else if ([bankName isEqualToString:@"中信银行"]){
        myImg = [UIImage imageNamed:@"zhongxing"];
        
    }else if ([bankName isEqualToString:@"光大银行"]){
        myImg = [UIImage imageNamed:@"guangda"];
        
    }else if ([bankName isEqualToString:@"华夏银行"]){
        myImg = [UIImage imageNamed:@"huaxia"];
        
    }else if ([bankName isEqualToString:@"民生银行"]){
        myImg = [UIImage imageNamed:@"mingsheng"];
        
    }else if ([bankName isEqualToString:@"广发银行"]){
        myImg = [UIImage imageNamed:@"guangfa"];
        
    }else if ([bankName isEqualToString:@"平安银行"]){
        myImg = [UIImage imageNamed:@"pingan"];
        
    }else if ([bankName isEqualToString:@"招商银行"]){
        myImg = [UIImage imageNamed:@"zhaoshang"];
        
    }else if ([bankName isEqualToString:@"兴业银行"]){
        myImg = [UIImage imageNamed:@"xingye"];
        
    }else if ([bankName isEqualToString:@"浦东发展银行"]){
        myImg = [UIImage imageNamed:@"pufa"];
        
    }else if ([bankName isEqualToString:@"北京银行"]){
        myImg = [UIImage imageNamed:@"beijing"];
        
    }else if ([bankName isEqualToString:@"恒丰银行"]){
        myImg = [UIImage imageNamed:@"hengfeng"];
        
    }else if ([bankName isEqualToString:@"浙商银行"]){
        myImg = [UIImage imageNamed:@"zheshang"];
        
    }else if ([bankName isEqualToString:@"渤海银行"]){
        myImg = [UIImage imageNamed:@"bohai"];
        
    }else if ([bankName isEqualToString:@"邮政储蓄银行"]){
        myImg = [UIImage imageNamed:@"youzheng"];
        
    }
    return myImg;
}

+ (UIImage *)getCardBgImageWithBankName:(NSString *)bankName{
    
    NSArray *arr1 = @[@"邮政储蓄银行",@"农业银行",@"光大银行",@"民生银行",@"恒丰银行",@"渤海银行"];
    NSArray *arr2 = @[@"建设银行",@"交通银行",@"平安银行",@"兴业银行",@"北京银行",@"浙商银行",@"浦东发展银行"];
        //  NSArray *arr3 = @[@"工商银行",@"中国银行",@"中信银行",@"华夏银行",@"广发银行",@"招商银行"];
    
    UIImage *image  = [UIImage imageNamed:@"bg_red"];
    
    if ([arr1 containsObject:bankName]) {
        image  = [UIImage imageNamed:@"bg_glod"];
    }else if ([arr2 containsObject:bankName]) {
        image  = [UIImage imageNamed:@"bg_blue"];
    }
    
    return image;
}
@end
