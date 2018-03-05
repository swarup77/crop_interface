//
//  WebBrowser.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/22/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "WebBrowser.h"
#import "Globals.h"
#import "NSString+URL.h"
#import "UIImage+Tint.h"
#import "AppScheme.h"

/**
 * http://www.idev101.com/code/User_Interface/sizes.html
 */

static NSString* const kGoogleSearchFormat = @"https://www.google.com/search?source=hp&ei=2-nGWfL2HcaQ0wLt-46YBw&q=%@";//@"http://www.google.com/search?q=%@";

@interface WebBrowser() <WKUIDelegate, WKNavigationDelegate, UITextFieldDelegate> {

    BOOL _searchBoxIsCentered;
    CGRect _searchFrameCentered, _searchFrameTop;
    UIView* _searchBar;
    WKWebView* _webView;
    UITextField* _searchField;
    UIActivityIndicatorView* busyIndicator;
}
@end

@implementation WebBrowser

-(instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame: frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark UI Setup

- (void)setupUI {

    // add nav bar
    _searchFrameTop = self.bounds;
    _searchFrameTop.size.height = [AppScheme searchBoxHeight];
    _searchFrameTop.size.width *= 0.8;
    _searchFrameTop.origin.x = (self.bounds.size.width - _searchFrameTop.size.width)/2.0f; //center horizontally
    _searchFrameTop.origin.y = CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame]);

    _searchFrameCentered = _searchFrameTop;
    _searchFrameCentered.origin.y = CGRectGetMidY(self.bounds) - _searchFrameCentered.size.height/2;

    _searchBar = [[UIView alloc] initWithFrame:_searchFrameCentered];
    _searchBoxIsCentered = YES;
    //add border
    _searchBar.layer.borderWidth = 1.0;
    _searchBar.layer.borderColor = [[AppScheme gray] CGColor];
    [self addSubview: _searchBar];

    //search button, goes on the right side
    CGFloat buttonSize = [AppScheme buttonHeight]; // square button
    CGRect buttonFrame = CGRectMake(_searchBar.bounds.size.width - buttonSize, (_searchBar.bounds.size.height - buttonSize)/2, buttonSize, buttonSize);
    UIButton* searchButton = [self searchButton:buttonFrame];
    [_searchBar addSubview:searchButton];

    //address field, stick it to the search button
    CGRect searchFieldFrame = CGRectMake(0, (_searchBar.bounds.size.height - [AppScheme searchFieldHeight])/2, CGRectGetMinX(buttonFrame), [AppScheme searchFieldHeight]);
    _searchField = [self searchField:searchFieldFrame];
    _searchField.delegate = self;
    [_searchBar addSubview:_searchField];

    // add webview
    WKWebViewConfiguration* webConfig = [[WKWebViewConfiguration alloc] init];
    CGFloat webViewY = CGRectGetMaxY(_searchFrameTop) + 5.0;
    CGRect webFrame  = CGRectMake(self.bounds.origin.x, webViewY, self.bounds.size.width, self.bounds.size.height - webViewY);
    _webView = [[WKWebView alloc] initWithFrame: webFrame configuration: webConfig];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self addSubview:_webView];

    //bring search bar to from
    [self bringSubviewToFront:_searchBar];

    //load google
    __unused NSString *urlString = @"https://www.google.com";
    __unused NSURL *url = [NSURL URLWithString:urlString];
    __unused NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //[_webView loadRequest:urlRequest];

    // add busy indicator for loading
    busyIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    busyIndicator.color = [AppScheme yellow];
    busyIndicator.backgroundColor = [AppScheme transparentLightGreen];
    [busyIndicator setHidesWhenStopped:YES];
    busyIndicator.hidden = YES;
    busyIndicator.center = CGPointMake(CGRectGetMidX(_webView.bounds), CGRectGetMidY(_webView.bounds));
    [_webView addSubview:busyIndicator];
}

- (UIButton*)searchButton:(CGRect)frame {
    UIButton* search = [[UIButton alloc] initWithFrame:frame];
    [search addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    search.backgroundColor = [AppScheme lightBlue];
    UIImage* icon = [UIImage imageNamed:@"icons8-Search-50.png"];
    //tint it white
    icon = [icon tintedWithColor:[AppScheme yellow]];
    [search setImage:icon forState:UIControlStateNormal];
    //add inset, image it too big
    [search setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    return search;
}

- (UITextField*)searchField:(CGRect)frame {
    UITextField *search = [[UITextField alloc] initWithFrame:frame];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.borderStyle = UITextBorderStyleRoundedRect;
    search.font = [AppScheme searchFieldFont];
    search.clearButtonMode = UITextFieldViewModeAlways;
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    search.placeholder = @"Search the web";
    return search;
}

- (void)searchButtonPressed:(id)sender {

    if ([[_searchField text] length] > 0) {
        [_searchField resignFirstResponder];
        [self loadAddress:_searchField.text];
    }
}

- (void)loadAddress:(NSString*)address {
    NSURLRequest* request;
    if ([address isValidURL]) {
        //load directly
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:address]];
    }else {
        // do a google search instead
        request = [NSURLRequest requestWithURL: [NSURL URLWithString: [NSString stringWithFormat:kGoogleSearchFormat, address]]];
    }
    [_webView loadRequest:request];
    [busyIndicator startAnimating];

    if (_searchBoxIsCentered) {
        _searchBoxIsCentered = NO;
        //animate search box to top
        [UIView animateWithDuration:0.5 animations:^{
            _searchBar.frame = _searchFrameTop;
        }];
    }
}

#pragma mark WKNAVIGATION DELEGATES:

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSDLog(@"address:%@", webView.URL);
    [busyIndicator stopAnimating];
}


#pragma mark UITEXTFIELD DELEGATES:

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDLog(@"textField ended editing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([textField.text length] != 0) {
        [self loadAddress:textField.text];
    }
    return YES;
}


@end
