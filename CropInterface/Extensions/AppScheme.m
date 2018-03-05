//
//  AppScheme.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/23/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "AppScheme.h"

@implementation AppScheme

+ (CGFloat)cropButtonWidth { return 100.0; }
+ (CGFloat)toolBarHeight { return 44.0; }
+ (CGFloat)buttonHeight { return 44.0; }
+ (CGFloat)croppingMargin { return 10; }
+ (CGSize)iconSize { return CGSizeMake(30, 30); }
+ (CGFloat)searchBoxHeight { return 44.0; }
+ (UIFont*)searchFieldFont { return [UIFont systemFontOfSize:17]; }
+ (CGFloat)searchFieldHeight { return 44.0; }

/**
 * app scheme taken from: https://coolors.co/
 */

+ (UIColor*)blue {
    return [self RGBA255fromRed:0 green:102 blue:143 alpha:255];
}
+ (UIColor*)lightBlue {
    return [self RGBA255fromRed:0 green:126 blue:143 alpha:255];
}
+ (UIColor*)green {
    return [self RGBA255fromRed:0 green:168 blue:149 alpha:255];
}
+(UIColor *)transparentGreen {
    CGFloat alpha = 0.7 * 255;
    return [self RGBA255fromRed:0 green:168 blue:149 alpha:(int)(alpha)];
}
+ (UIColor*)lightGreen {
    return [self RGBA255fromRed:0 green:194 blue:149 alpha:255];
}
+ (UIColor *)transparentLightGreen {
    CGFloat alpha = 0.7 * 255;
    return [self RGBA255fromRed:0 green:194 blue:149 alpha:(int)(alpha)];
}
+ (UIColor*)yellow {
    return [self RGBA255fromRed:239 green:242 blue:187 alpha:255];
}
+ (UIColor*)darkGray {
    return [self RGBA255fromRed:147 green:147 blue:147 alpha:255];
}
+ (UIColor*)gray {
    return [self RGBA255fromRed:192 green:192 blue:192 alpha:255];
}
+ (UIColor*)lightGray {
    return [self RGBA255fromRed:208 green:208 blue:208 alpha:255];
}
+ (UIColor*)transparentLightGray {
    CGFloat alpha = 0.7 * 255;
    return [self RGBA255fromRed:208 green:208 blue:208 alpha:(int)(alpha)];
}

+ (UIColor*)RGBA255fromRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha {
    return [[UIColor alloc] initWithRed:(CGFloat)(red)/255.0
                                  green:(CGFloat)(green)/255.0
                                   blue:(CGFloat)(blue)/255.0
                                  alpha:(CGFloat)(alpha)/(255.0)];
}

@end
