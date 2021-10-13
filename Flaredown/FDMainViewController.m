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

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIView *noInternetView;

@end

@implementation FDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.clipsToBounds = false;
    self.webView.scrollView.bounces = false;
    self.webView.scrollView.clipsToBounds = false;
  
    //Style page
    _alarmButton.layer.cornerRadius = _alarmButton.frame.size.width/2;
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Setup progress
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.hud setMode:MBProgressHUDModeIndeterminate];
    [self.hud setUserInteractionEnabled:false];
  
    [self.view addSubview:self.hud];
    self.hud.delegate = self;
  
    [self.hud showAnimated:true];
    
    //Show web page
    [self loadWebView];
}

- (void)loadWebView {
    NSString *urlString = @"https://app.flaredown.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)reload {
    
    [self.hud showAnimated:true];
    [self.noInternetView removeFromSuperview];
    [self.webView reload];
}

#pragma mark -

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.hud hideAnimated:true];
    self.noInternetView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.noInternetView.backgroundColor = [UIColor colorWithRed:0.94 green:0.92 blue:0.89 alpha:1.00];
    [self.view addSubview:self.noInternetView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.noInternetView.frame.size.height / 2 - 70, self.noInternetView.frame.size.width, 30)];
    titleLabel.textColor = [UIColor colorWithRed:0.73 green:0.66 blue:0.55 alpha:1.00];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.text = @"Connection not found :(";
    [self.noInternetView addSubview:titleLabel];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, self.noInternetView.frame.size.height / 2 - 70, self.noInternetView.frame.size.width - 160, 100)];
    messageLabel.textColor = [UIColor colorWithRed:0.73 green:0.66 blue:0.55 alpha:1.00];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont boldSystemFontOfSize:14];
    messageLabel.numberOfLines = 2;
    messageLabel.text = @"Make sure you're connected to the internet and try again";
    [self.noInternetView addSubview:messageLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    button.center = CGPointMake(self.noInternetView.frame.size.width / 2, self.noInternetView.frame.size.height / 2 + 30);
    [button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Try again" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.38 green:0.72 blue:0.69 alpha:1.00];
    button.layer.cornerRadius = 5;
    [self.noInternetView addSubview:button];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self.hud hideAnimated:true];
}


@end
