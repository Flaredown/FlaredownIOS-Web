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

    NSString *urlString = @"https://app.flaredown.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    _alarmButton.layer.cornerRadius = _alarmButton.frame.size.width/2;
    [FDStyle addShadowToView:_alarmButton];
}

@end
