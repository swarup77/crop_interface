//
//  UIImage+Crop.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/23/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

/**
 * based on: http://blogs.innovationm.com/image-croprotateresize-handling-in-ios/
 */

- (UIImage*)imageByCroppingToRect:(CGRect)cropRect {

    UIGraphicsBeginImageContextWithOptions(cropRect.size, false, self.scale);
    CGPoint origin = CGPointMake(cropRect.origin.x * -1.0, cropRect.origin.y * -1);
    [self drawAtPoint:origin];
    UIImage* cropped = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return cropped;
}

@end
