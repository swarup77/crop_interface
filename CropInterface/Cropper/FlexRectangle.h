//
//  FlexRectangle.h
//  LiveInk
//
//  Created by Swarup Mahanti on 8/21/17.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef enum CONTROL_INDEX {
    Null = -1,
    NorthWest = 0,
    NorthEast = 1,
    SouthEast = 2,
    SouthWest = 3,
} CONTROL_INDEX;


@interface FlexRectangle : NSObject

- (void)setStart:(CGPoint)start;
- (void)setEnd:(CGPoint)end;
- (void)setRect:(CGRect)rect;
- (CGRect)rectRegion;

@end
