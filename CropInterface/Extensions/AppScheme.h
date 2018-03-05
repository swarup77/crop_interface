//
//  AppScheme.h
//  CropInterface
//
//  Created by Swarup Mahanti on 9/23/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppScheme : NSObject

+ (CGFloat)searchBoxHeight;
+ (UIFont*)searchFieldFont;
+ (CGFloat)searchFieldHeight;
+ (CGFloat)cropButtonWidth;
+ (CGFloat)toolBarHeight;
+ (CGFloat)buttonHeight;
+ (CGFloat)croppingMargin;
+ (CGSize)iconSize;
+ (UIColor*)blue;
+ (UIColor*)lightBlue;
+ (UIColor*)green;
+ (UIColor*)transparentGreen;
+ (UIColor*)lightGreen;
+ (UIColor*)transparentLightGreen;
+ (UIColor*)yellow;
+ (UIColor*)darkGray;
+ (UIColor*)gray;
+ (UIColor*)lightGray;
+ (UIColor*)transparentLightGray;

@end
