//
//  FlexRectangle.m
//
//  Created by Swarup Mahanti on 8/21/17.
//

#import "FlexRectangle.h"

@interface FlexRectangle() {
    CGPoint _start;
    CGPoint _end;
    CGRect _rectRegion;
}
@end

@implementation FlexRectangle

-(void)setRect:(CGRect)rect {
    [self setStart:rect.origin];
    [self setEnd:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
}

- (void) setStart: (CGPoint) start {
    _start = start;
    _rectRegion = CGRectMake(_start.x, _start.y, 0.0f, 0.0f);
}


- (void) setEnd: (CGPoint) end {
    _end = end;
    CGPoint origin = CGPointMake(MIN(_start.x, _end.x), MIN(_start.y, _end.y));
    CGFloat w = fabs(_end.x - _start.x);
    CGFloat h = fabs(_end.y - _start.y);
    _rectRegion = CGRectMake(origin.x, origin.y, w, h);
}

- (CGRect)rectRegion {
    return _rectRegion;
}
@end
