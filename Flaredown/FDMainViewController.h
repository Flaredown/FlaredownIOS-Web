//
//  FDMainViewController.h
//  Flaredown
//
//  Created by Cole Cunningham on 4/13/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MBProgressHUD;

@interface FDMainViewController : UIViewController <MBProgressHUDDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;

@end
