//
//  CroppingView.h
//  CropInterface
//
//  Created by Swarup Mahanti on 9/22/17.
//

#import <UIKit/UIKit.h>

@class ViewCropper;
@protocol CropDelegate <NSObject>
@optional
- (void)cropper:(ViewCropper*)view didFinishCropping:(UIImage*)image;
@end

@interface ViewCropper : UIView

@property(nonatomic, weak)id < CropDelegate > delegate;
+ (CGFloat)toolBarHeight;
- (void)setViewToCrop:(UIView*)view;

@end
