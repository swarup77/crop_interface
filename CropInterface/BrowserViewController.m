//
//  ViewController.m
//  CropInterface
//
//  Created by Swarup Mahanti on 8/24/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "BrowserViewController.h"
#import "CropInterface.h"
#import "WebBrowser.h"
#import "ViewCropper.h"
#import "Globals.h"

@interface BrowserViewController() <CropDelegate>

@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    CGRect browserFrame = self.view.bounds;
    browserFrame.size.height -= [ViewCropper toolBarHeight];
    WebBrowser* browser = [[WebBrowser alloc] initWithFrame: browserFrame];
    [self.view addSubview: browser];

    // add cropping view
    CGRect box = self.view.bounds;
    ViewCropper* cropper = [[ViewCropper alloc] initWithFrame:box];
    cropper.delegate = self;
    [self.view addSubview:cropper];
    [cropper setViewToCrop:browser];
}

- (void)cropper:(ViewCropper *)view didFinishCropping:(UIImage *)image {
    self.image = image;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSDLog(@"image picker finished");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
