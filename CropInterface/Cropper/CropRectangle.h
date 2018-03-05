//
//  ControlRectangle.h
//  LiveInk
//
//  Created by Swarup Mahanti on 8/22/17.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FlexRectangle.h"

@interface CropRectangle : NSObject

- (instancetype)initWith:(CGRect)rect;

- (void)touchDraggedFrom:(CGPoint)previous to:(CGPoint)current;
- (void)setPivotIndex:(CONTROL_INDEX)index;
- (void)setPivotLocation:(CGPoint)point;

- (CGRect)rectRegion;
- (CGPoint)pointForIndex:(CONTROL_INDEX)index;

+ (CGPoint)NorthWest:(CGRect)frame;
+ (CGPoint)NorthEast:(CGRect)frame;
+ (CGPoint)SouthEast:(CGRect)frame;
+ (CGPoint)SouthWest:(CGRect)frame;

@end
