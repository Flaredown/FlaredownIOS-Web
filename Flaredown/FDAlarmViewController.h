//
//  FDAlarmViewController.h
//  Flaredown
//
//  Created by Cole Cunningham on 4/13/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAlarmViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *popupDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *popupDoneButton;
@property (weak, nonatomic) IBOutlet UIButton *popupCancelButton;
@property (weak, nonatomic) IBOutlet UILabel *popupTitleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property (weak, nonatomic) IBOutlet UILabel *reminderTimeLabel;

@property UIView *alarmView;
@property NSDate *reminderTime;

- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC;

@end
