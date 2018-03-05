//
//  ViewController.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/23/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "ViewController.h"
#import "BrowserViewController.h"
#import "AppScheme.h"

@interface ViewController () {
    BrowserViewController* browserController;
    UIImageView* imageView;
    UIButton* browseButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (browserController) {
        if (imageView) {
            [imageView removeFromSuperview];
        }
        imageView = [[UIImageView alloc] initWithImage:browserController.image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.borderColor = [[AppScheme green] CGColor];
        imageView.layer.borderWidth = 1.0f;
        [self.view addSubview:imageView];
        imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    }

    if (!browseButton) {
        //add browse button
        CGRect frame = self.view.bounds;
        frame.size = CGSizeMake(100, 44);
        frame.origin.x = CGRectGetMidX(self.view.bounds) - frame.size.width/2;
        frame.origin.y = CGRectGetMidY(self.view.bounds) - frame.size.height/2;
        browseButton = [[UIButton alloc] initWithFrame:frame];
        [browseButton addTarget:self action:@selector(browseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [browseButton setTitle:@"Browse" forState:UIControlStateNormal];
        [browseButton setTitleColor:[AppScheme blue] forState:UIControlStateNormal];
        [browseButton setBackgroundColor:[AppScheme yellow]];
        browseButton.layer.cornerRadius = 3;
        browseButton.layer.borderColor = [[AppScheme lightBlue] CGColor];
        browseButton.layer.borderWidth = 1.0;
        [self.view addSubview:browseButton];
    }else {
        [self.view bringSubviewToFront:browseButton];
        //animate to bottom
        CGRect frame = browseButton.frame;
        frame.origin.y = self.view.bounds.size.height - frame.size.height - 30;
        [UIView animateWithDuration:1.0 animations:^{
            browseButton.frame = frame;
        }];
    }

}

- (void)browseButtonPressed:(id)sender {
    UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    browserController = (BrowserViewController *)[main instantiateViewControllerWithIdentifier:@"BrowserViewController"];
    [self presentViewController:browserController animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
