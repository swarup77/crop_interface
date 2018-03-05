//
//  ControlRectangle.m
//  Created by Swarup Mahanti on 8/22/17.
//

#import "CropRectangle.h"
#import "FlexRectangle.h"
#import "Globals.h"

static const CGSize kMinSize = {100, 100};

@interface CropRectangle(){
    FlexRectangle *_cropRect;
    CONTROL_INDEX _anchor;
    CONTROL_INDEX _pivot;
    CGPoint pivotLocation;
    CGPoint anchorLocation;
}
@end

@implementation CropRectangle

- (instancetype)initWith:(CGRect)rect
{
    self = [super init];
    if (self) {
        _pivot = Null;
        _cropRect = [[FlexRectangle alloc] init];
        [_cropRect setRect:rect];
    }
    return self;
}

-(void)setPivotIndex:(CONTROL_INDEX)index {
    _pivot = index;
    _anchor = [self anchor:_pivot];
    anchorLocation = [self pointWith:[_cropRect rectRegion] anchor:_anchor];
    pivotLocation = [self pointWith:[_cropRect rectRegion] pivot:_pivot];
    [_cropRect setStart:anchorLocation];
    [_cropRect setEnd:pivotLocation];
}

- (void)touchDraggedFrom:(CGPoint)previous to:(CGPoint)current {

    CGFloat dx = current.x - previous.x;
    CGFloat dy = current.y - previous.y;
    
    if (_pivot != Null) {
        NSDLog(@"pivot:%d anchor:%d", _pivot, _anchor);
        [self controlPointDragged:dx :dy];
    }else if (CGRectContainsPoint([_cropRect rectRegion], current)){
        [self moveBy:dx :dy];
    }
}

- (void)setPivotLocation:(CGPoint)point {
    pivotLocation = point;
    [_cropRect setEnd:pivotLocation];
}

- (void)controlPointDragged:(CGFloat)dx :(CGFloat)dy {
    pivotLocation.x += dx;
    pivotLocation.y += dy;
    CGFloat w = fabs(pivotLocation.x - anchorLocation.x);
    if ( w < kMinSize.width) {
        pivotLocation.x -= dx;
    }
    CGFloat h = fabs(pivotLocation.y - anchorLocation.y);
    if ( h < kMinSize.height) {
        pivotLocation.y -= dy;
    }
    NSDLog(@"w:%f h:%f min:%f", w, h, kMinSize.width);
    //NSDLog(@"dx:%f dy:%f pivot_x:%f y:%f", dx, dy, pivotLocation.x, pivotLocation.y);
    [_cropRect setEnd:pivotLocation];
}

- (void)moveBy:(CGFloat)dx :(CGFloat)dy {

    NSDLog(@"dx:%f dy:%f", dx, dy);

    CGPoint origin = [_cropRect rectRegion].origin;
    origin.x += dx;
    origin.y += dy;
    CGFloat w = [_cropRect rectRegion].size.width;
    CGFloat h = [_cropRect rectRegion].size.height;
    [_cropRect setRect:CGRectMake(origin.x, origin.y, w, h)];
}


-(CGRect)rectRegion {
    return [_cropRect rectRegion];
}

- (CONTROL_INDEX)anchor:(CONTROL_INDEX)touchedPoint {
    switch (touchedPoint) {
        case NorthWest: return SouthEast;
        case NorthEast: return SouthWest;
        case SouthWest: return NorthEast;
        case SouthEast: return NorthWest;
        default: return Null;
    }
}

- (CGPoint)pointWith:(CGRect)rect anchor:(CONTROL_INDEX)location {
    switch (location) {
        case NorthWest: return [CropRectangle NorthWest:rect];
        case NorthEast: return [CropRectangle NorthEast:rect];
        case SouthWest: return [CropRectangle SouthWest:rect];
        case SouthEast: return [CropRectangle SouthEast:rect];
        case Null: return CGPointZero;
    }
}

- (CGPoint)pointWith:(CGRect)rect pivot:(CONTROL_INDEX)location {
    switch (location) {
        case NorthWest: return [CropRectangle NorthWest:rect];
        case NorthEast: return [CropRectangle NorthEast:rect];
        case SouthWest: return [CropRectangle SouthWest:rect];
        case SouthEast: return [CropRectangle SouthEast:rect];
        case Null: return CGPointZero;
    }
}

-(CGPoint)pointForIndex:(CONTROL_INDEX)index {
    CGRect box = [_cropRect rectRegion];
    switch (index) {
        case NorthEast: return [CropRectangle NorthEast:box];
        case NorthWest: return [CropRectangle NorthWest:box];
        case SouthEast: return [CropRectangle SouthEast:box];
        case SouthWest: return [CropRectangle SouthWest:box];
        case Null: return CGPointZero;
    }
}


+ (CGPoint) NorthWest: (CGRect) frame { return frame.origin; }
+ (CGPoint) NorthEast: (CGRect) frame { return CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame)); }
+ (CGPoint) SouthEast: (CGRect) frame { return CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame)); }
+ (CGPoint) SouthWest: (CGRect) frame { return CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)); }


@end
