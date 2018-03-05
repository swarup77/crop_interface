//
//  CropControl.m
//  LiveInk
//
//  Created by Swarup Mahanti on 8/23/17.
//

#import "CropControl.h"
#import "FlexRectangle.h"
#import "CropRectangle.h"
#import "Globals.h"
#import "AppScheme.h"

@interface CropControl(){
    CONTROL_INDEX _controlIndex;
    BOOL _isActive;
    CGSize _activeSize;
    CGSize _normalSize;
    UIColor *_defaultColor;
    UIColor *_activeColor;
}
@end

@implementation CropControl

-(instancetype)initWithFrame:(CGRect)rect index:(CONTROL_INDEX)index {
    if (self = [super initWithFrame:[self frameFrom:rect index:index]]) {
        _controlIndex = index;
        _normalSize  = self.frame.size;
        _defaultColor = [AppScheme transparentGreen];
        _activeColor  = [AppScheme transparentLightGreen];
        self.backgroundColor = _defaultColor;
    }
    return self;
}

-(CONTROL_INDEX)index{
    return _controlIndex;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = self.frame.size.width/2;
}

-(CGRect)frameFrom:(CGRect)rect index:(CONTROL_INDEX)index {

    CGPoint center = CGPointZero;
    switch (index) {
        case NorthWest:{
            center = [CropRectangle NorthWest:rect];
            break;
        }
        case NorthEast:{
            center = [CropRectangle NorthEast:rect];
            break;
        }
        case SouthWest:{
            center = [CropRectangle SouthWest:rect];
            break;
        }
        case SouthEast:{
            center = [CropRectangle SouthEast:rect];
            break;
        }
        case Null:
            break;
    }
    return CGRectMake(center.x - [AppScheme iconSize].width/2, center.y - [AppScheme iconSize].height/2, [AppScheme iconSize].width, [AppScheme iconSize].height);
}

-(void)activate:(BOOL)activate resize:(BOOL)resize {
    [self activate:activate];
    [self resize:resize];
    [self setNeedsDisplay];
}

-(void)resize:(BOOL)resize{
    if (resize) {
        _activeSize = CGSizeMake(_normalSize.width * 2, _normalSize.height * 2);
        NSDLog(@"before_frame:%@", NSStringFromCGRect(self.frame));
        CGRect box = self.frame;
        CGPoint center = CGPointMake(CGRectGetMidX(box), CGRectGetMidY(box));
        box.origin = CGPointMake(center.x - _activeSize.width/2, center.y - _activeSize.height/2);
        box.size = _activeSize;
        self.frame = box;
        NSDLog(@"after_frame:%@", NSStringFromCGRect(self.frame));
    }else{
        _activeSize = _normalSize;
    }
}

-(void)deActivate{

    CGRect box = self.frame;
    CGPoint center = CGPointMake(CGRectGetMidX(box), CGRectGetMidY(box));
    box.origin = CGPointMake(center.x - _normalSize.width/2, center.y - _normalSize.height/2);
    box.size = _normalSize;
    self.frame = box;
    [self activate:false];
}

-(void)activate:(BOOL)activate{
    if (activate) {
        _isActive = true;
        self.backgroundColor = _activeColor;
    }else {
        _isActive = false;
        self.backgroundColor = _defaultColor;
    }
}


@end
