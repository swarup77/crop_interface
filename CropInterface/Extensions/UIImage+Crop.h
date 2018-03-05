//
//  UIImage+Crop.h
//  CropInterface
//
//  Created by Swarup Mahanti on 9/23/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

- (UIImage*)imageByCroppingToRect:(CGRect)cropRect;

@end
