//
//  UIImage+Tint.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/22/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "UIImage+Tint.h"
#import "Globals.h"

@implementation UIImage (Tint)

/**
 * based on: https://gist.github.com/jimrutherford/4199145
 */

- (UIImage *)tintedWithColor:(UIColor *)tintColor{

    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if(!context){
        NSDLog(@"context nil");
    }

    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);

    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);

    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}


@end
