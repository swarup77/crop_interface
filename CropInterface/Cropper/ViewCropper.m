//
//  CroppingView.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/22/17.
//

#import "ViewCropper.h"
#import "UIImage+Tint.h"
#import "CropInterface.h"
#import "UIView+Image.h"
#import "UIImage+Crop.h"
#import "AppScheme.h"
/**
 * http://www.idev101.com/code/User_Interface/sizes.html
 */

@interface ViewCropper() {
    BOOL cropInProgress;
    CGRect toolBarFrame;
    UIView* _viewToCrop;
    UIButton* cropButton;
    UIButton* doneButton;
    UIButton* cancelButton;
    CropInterface* cropInterface;
}
@end


@implementation ViewCropper

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

+ (CGFloat)toolBarHeight {
    return [AppScheme toolBarHeight];
}

- (void)setViewToCrop:(UIView*)view {
    _viewToCrop = view;
}

- (void)setupUI {

    // add toolbar at the bottom
    toolBarFrame = CGRectMake(0, self.bounds.size.height - [AppScheme toolBarHeight], self.bounds.size.width, [AppScheme toolBarHeight]);
    UIView *toolBar = [[UIView alloc] initWithFrame:toolBarFrame];
    toolBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    [self addSubview:toolBar];

    //add crop button, center horizontally
    CGRect cropButtonFrame = CGRectMake(CGRectGetMidX(toolBarFrame) - [AppScheme cropButtonWidth]/2, (toolBarFrame.size.height - [AppScheme buttonHeight])/2, [AppScheme cropButtonWidth], [AppScheme buttonHeight]);
    cropButton = [self cropButton:cropButtonFrame];
    [toolBar addSubview:cropButton];

    // add done and cancelButtons to the left and right of crop
    CGRect doneButtonFrame = cropButtonFrame;
    doneButtonFrame.origin.x -= doneButtonFrame.size.width;
    doneButton = [self doneButton:doneButtonFrame];
    [toolBar addSubview:doneButton];
    doneButton.alpha = 0.0; // hide it

    CGRect cancelButtonFrame = cropButtonFrame;
    cancelButtonFrame.origin.x += cancelButtonFrame.size.width;
    cancelButton = [self cancelButton:cancelButtonFrame];
    [toolBar addSubview:cancelButton];
    cancelButton.alpha = 0.0; // hide it
}

- (UIButton*)cropButton:(CGRect)frame {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    UIImage* icon = [UIImage imageNamed:@"scissor_icon.png"];
    icon = [icon tintedWithColor:[AppScheme lightGreen]];
    [button addTarget:self action:@selector(cropButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:icon forState:UIControlStateNormal];
    //add insets, image is skewed
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 15)];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [[AppScheme green] CGColor];
    button.layer.borderWidth = 1.0;
    return button;
}

- (UIButton*)doneButton:(CGRect)frame {

    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [button setTitleColor:[AppScheme green] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [[AppScheme green] CGColor];
    button.layer.borderWidth = 1.0;
    return button;
}

- (UIButton*)cancelButton:(CGRect)frame {

    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[AppScheme green] forState:UIControlStateNormal];
    button.layer.borderColor = [[AppScheme green] CGColor];
    button.layer.borderWidth = 1.0;
    return button;
}


- (void)cropButtonPressed:(id)sender {

    cropInProgress = YES;

    if (!cropInterface) {
        CGRect box = self.bounds;
        box.size.height -= [AppScheme toolBarHeight];
        cropInterface = [[CropInterface alloc] initWithFrame:box];
        [self addSubview:cropInterface];
    }

    //animate
    cropInterface.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        cropInterface.alpha = 1.0;
        doneButton.alpha    = 1.0;
        cancelButton.alpha  = 1.0;
        cropButton.alpha    = 0.0;
    }];
}

- (void)doneButtonPressed:(id)sender {

    cropInProgress = NO;

    UIImage* snapshot = [_viewToCrop imageFromView];
    snapshot = [snapshot imageByCroppingToRect:[cropInterface croppingRegion]];

    if ([self.delegate respondsToSelector:@selector(cropper:didFinishCropping:)]) {
        [self.delegate cropper:self didFinishCropping:snapshot];
    }
}

- (void)cancelButtonPressed:(id)sender {

    cropInProgress = NO;

    [UIView animateWithDuration:0.5 animations:^{
        cropInterface.alpha = 0.0;
        doneButton.alpha    = 0.0;
        cancelButton.alpha  = 0.0;
        cropButton.alpha    = 1.0;
    }];
}

//pass through touches, except when its on toolbar
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (cropInProgress) {
        return CGRectContainsPoint(self.bounds, point);
    }
    return CGRectContainsPoint(toolBarFrame, point);
}



@end
