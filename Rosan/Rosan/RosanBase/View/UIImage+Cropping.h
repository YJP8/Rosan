//
//  UIImage+Cropping.h
//  LQB
//
//  Created by YinXun-Yu on 2016/10/19.
//  Copyright © 2016年 YinXun-Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cropping)

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize;

//UIImageRenderingMode枚举值来设置图片的renderingMode属性。该枚举中包含下列值：

//UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
//UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
//UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (UIImage *)fixOrientation:(UIImage *)aImage rotation:(UIImageOrientation)orientation;
@end
