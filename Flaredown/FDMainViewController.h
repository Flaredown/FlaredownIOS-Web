//
//  FDMainViewController.h
//  Flaredown
//
//  Created by Cole Cunningham on 4/13/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@import MBProgressHUD;

@interface FDMainViewController : UIViewController <MBProgressHUDDelegate, WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *alarmButton;

@end
