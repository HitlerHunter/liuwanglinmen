//
//  ImageCodeTools.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "ImageCodeTools.h"

@implementation ImageCodeTools

+ (UIImage *)addGeneralizeCodeImageModel:(GeneralizeCodeImageModel *)model
                                 toImage:(UIImage *)toImage{
    
    CGFloat imageW = [model.pwth floatValue];
    CGFloat imageH = [model.plen floatValue];
    
    NSString *codeUrl = [AppCenter shareRegisterURL];//注册分享链接
    
    UIImage *ewmImg = [ImageCodeTools createQRImageWithString:codeUrl size:CGSizeMake(imageW, imageH)];
    ewmImg = [self addImageForQRImage:ewmImg];
    toImage = [[self class] addImage:ewmImg
                          toBigImage:toImage
                        bigImageSize:CGSizeMake(toImage.size.width, toImage.size.height)
                          imageFrame:CGRectMake(model.px.floatValue, model.py.floatValue, imageW, imageH)];
    
    return toImage;
}


+ (UIImage *)addImage:(UIImage *)image
           toBigImage:(UIImage *)bigImage
             bigImageSize:(CGSize)bigImageSize
           imageFrame:(CGRect)imageFrame{
    
//    ewmImg = [ImageCodeTools addImageForQRImage:ewmImg];
    UIGraphicsBeginImageContext(bigImageSize);
    
    [bigImage drawInRect:CGRectMake(0, 0, bigImageSize.width, bigImageSize.height)];
    
    [image drawInRect:imageFrame];
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

//生成制定大小的黑白二维码
+ (UIImage *)createQRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
        //放大并绘制二维码（上面生成的二维码很小，需要放大）
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        //翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

    //为二维码改变颜色
+ (UIImage *)changeColorForQRImage:(UIImage *)image backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor
{
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage", [CIImage imageWithCGImage:image.CGImage],
                             @"inputColor0",[CIColor colorWithCGColor:frontColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:backColor.CGColor],
                             nil];
    
    return [UIImage imageWithCIImage:colorFilter.outputImage];
}

    //在二维码中心加一个小图
+ (UIImage *)addImageForQRImage:(UIImage *)qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    UIImage *image = nil;
    image = [AppCenter appIcon];
    
    CGFloat imageW = qrImage.size.width*0.2;
    CGFloat imaegX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imageY = (qrImage.size.height - imageW) * 0.5;
    
    [image drawInRect:CGRectMake(imaegX, imageY, imageW, imageW)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

+ (UIImage *)addText:(NSString *)text
            toImage:(UIImage *)toImage
                textFrame:(CGRect)textFrame

{
    
    NSString* mark = text;
    
    CGFloat w = toImage.size.width;
    
    CGFloat h = toImage.size.height;
    
    UIGraphicsBeginImageContext(toImage.size);
    
    [toImage drawInRect:CGRectMake(0, 0, w, h)];
    
    NSDictionary *attr = @{
                           
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:36],  //设置字体
                           
                           NSForegroundColorAttributeName : LZBuleColor   //设置字体颜色
                           
                           };
    
    CGSize textSize = [text sizeWithAttributes:attr];
    
    [mark drawInRect:CGRectMake(textFrame.origin.x, textFrame.origin.y, textSize.width, textSize.height) withAttributes:attr];         //左上角
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
    
}

/**裁剪圆形*/
+ (UIImage *)clibImage:(UIImage *)image{
    
        //获取图片尺寸
    CGSize size = image.size;
    
        //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
        //创建圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
        //设置为裁剪区域
    [path addClip];
    
        //绘制图片
    [image drawAtPoint:CGPointZero];
    
        //获取裁剪后的图片
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    
        //关闭上下文
    UIGraphicsEndImageContext();
    
    return image1;
}
@end
