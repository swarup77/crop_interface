//
//  CropInterface.m
//  LiveInk
//
//  Created by Swarup Mahanti on 8/23/16.
//

#import "CropInterface.h"
#import "CropControl.h"
#import "CropRectangle.h"
#import "Globals.h"
#import "AppScheme.h"

static const CGFloat kMargin = 100;

@interface CropInterface(){
    CGFloat _maskBorder;
    UIColor *_maskColor;
    NSMutableArray<CropControl*> *_controlIcons;
    CropControl *_touchedIcon;
    CropRectangle *_cropRect;
    CGRect _cropBox;
    BOOL _needsLayout;
    CGPoint previousLoc;
}
@end

@implementation CropInterface

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _controlIcons = [NSMutableArray array];
        _cropBox = CGRectZero;
        _needsLayout = true;
        _maskColor = [AppScheme transparentLightGray];
    }
    return self;
}

- (CGRect)croppingRegion {
    return _cropBox;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [[UIColor alloc] initWithWhite:0.1 alpha:0.5];
    if (_needsLayout == YES) {
        _cropBox = CGRectInset(self.bounds, kMargin, kMargin);
        [self createControlIcons];
        _needsLayout = NO;
    }
}

-(void)createControlIcons {
    if ([_controlIcons count] > 0) {
        for (CropControl *icon in _controlIcons) {
            [icon removeFromSuperview];
        }
        [_controlIcons removeAllObjects];
    }
    for (int i = 0; i < 4; i++) {
        CropControl *icon = [[CropControl alloc] initWithFrame:_cropBox index:i];
        //NSDLog(@"index:%d frame:%@", i, NSStringFromCGRect(icon.frame));
        icon.userInteractionEnabled = YES;
        [_controlIcons addObject:icon];
        [self addSubview:icon];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([touches anyObject] == nil) {
        return;
    }
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    _touchedIcon = [self iconTouched:touchPoint];
    _cropRect = [[CropRectangle alloc] initWith:_cropBox];
    if (_touchedIcon) {
        [_cropRect setPivotIndex:_touchedIcon.index];
        [_touchedIcon activate:YES resize:YES];
    }
    previousLoc = touchPoint;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint current = [touch locationInView:self];
    [_cropRect touchDraggedFrom:previousLoc to:current];
    _cropBox = [_cropRect rectRegion];
    [self updateControlPoints];

    previousLoc = current;

    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_touchedIcon) {
        [_touchedIcon deActivate];
    }
}


-(void)updateControlPoints {
    for (CropControl* icon in _controlIcons) {
        icon.center = [_cropRect pointForIndex:icon.index];
    }
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextClearRect(context, _cropBox);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    const CGFloat* components = CGColorGetComponents([_maskColor CGColor]);
    CGContextSetFillColor(context, components);
    CGContextFillRect(context, _cropBox);
    CGContextRestoreGState(context);
    //CGContextRelease(context);
}



-(CropControl*)iconTouched:(CGPoint)point {
    for (CropControl* icon in _controlIcons) {
        if (CGRectContainsPoint(icon.frame, point)) {
            return icon;
        }
    }
    return nil;
}




@end
