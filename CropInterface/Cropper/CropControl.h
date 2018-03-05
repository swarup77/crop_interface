//
//  CropControl.h
//  LiveInk
//
//  Created by Swarup Mahanti on 8/23/17.
//

#import <UIKit/UIKit.h>
#import "FlexRectangle.h"

@interface CropControl : UIView
-(instancetype)initWithFrame:(CGRect)rect index:(CONTROL_INDEX)index;
-(void)activate:(BOOL)activate resize:(BOOL)resize;
-(CONTROL_INDEX)index;
-(void)deActivate;
@end
