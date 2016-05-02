//
//  FDWebViewController.m
//  Flaredown
//
//  Created by Cole Cunningham on 4/13/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import "FDMainViewController.h"

#import "FDStyle.h"

@interface FDMainViewController ()

@end

@implementation FDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Style page
    _alarmButton.layer.cornerRadius = _alarmButton.frame.size.width/2;
    [FDStyle addShadowToView:_alarmButton];
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Setup progress
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [self.view.window addSubview:hud];
    hud.delegate = self;
    
    //Show web page
    [self loadWebView];
    
    //Hide progress
    [hud hide:YES];
    if(hud != nil) {
        [hud removeFromSuperview];
    }
}

- (void)loadWebView {
    NSString *urlString = @"https://app.flaredown.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
