//
//  FDAlarmViewController.m
//  Flaredown
//
//  Created by Cole Cunningham on 4/13/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import "FDAlarmViewController.h"

#import "FDReminderManager.h"
#import "FDPopupManager.h"
#import "FDNotificationManager.h"

#import "FDStyle.h"

//relative to screen
#define ALARM_WIDTH 0.9
#define ALARM_HEIGHT 0.55

@interface FDAlarmViewController ()

@end

@implementation FDAlarmViewController

static NSString * const alarmViewNib = @"AlarmView";
static NSString * const unwindToMainSegue = @"unwindToMain";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backButton.layer.cornerRadius = _backButton.frame.size.width/2;
    [FDStyle addShadowToView:_backButton];
    
    [_reminderSwitch setOn:[[FDReminderManager manager] reminder]];
    [self setupReminderLabel];
}

- (void)setupReminderLabel
{
    NSString *title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"hh:mm a"];
    title = [dateFormatter stringFromDate:[[FDReminderManager manager] reminderTime]];
    
    [_reminderTimeLabel setText:title];
    if([[FDReminderManager manager] reminder])
        [_reminderTimeLabel setAlpha:1.0f];
    else
        [_reminderTimeLabel setAlpha:0.4f];
}

- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    [super unwindForSegue:unwindSegue towardsViewController:subsequentVC];
}

- (IBAction)backButton:(id)sender
{
    [self performSegueWithIdentifier:unwindToMainSegue sender:self];
}

- (IBAction)reminderSwitchToggle:(id)sender
{
    [[FDReminderManager manager] toggleReminder];
    [self setupReminderLabel];
    if([[FDReminderManager manager] reminder])
        [[FDNotificationManager manager] setCheckinReminder:[[FDReminderManager manager] reminderTime]];
    else
        [[FDNotificationManager manager] removeCheckinReminder];
}

- (IBAction)alarmButton:(id)sender
{
    if(![[FDReminderManager manager] reminder])
        return;
    UIView *alarmView = [[[NSBundle mainBundle] loadNibNamed:alarmViewNib owner:self options:nil] objectAtIndex:0];
    [alarmView setFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*ALARM_WIDTH/2, self.view.frame.size.height/2-self.view.frame.size.height*ALARM_HEIGHT/2, self.view.frame.size.width*ALARM_WIDTH, self.view.frame.size.height*ALARM_HEIGHT)];
    
    [[FDPopupManager sharedManager] addPopupView:alarmView];
    
    //Style
    alarmView.layer.masksToBounds = YES;
    [FDStyle addRoundedCornersToView:alarmView];
    
    _alarmView = alarmView;
    
    [_popupTitleLabel setText:@"Reminder"];
    
    [_popupDoneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_popupCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    //Reminder Time - 2
    UIDatePicker *datePicker = (UIDatePicker *)[alarmView viewWithTag:2];
    [datePicker setDate:[[FDReminderManager manager] reminderTime]];
    _reminderTime = [[FDReminderManager manager] reminderTime];
}

- (IBAction)alarmDateChanged:(UIDatePicker *)sender
{
    _reminderTime = sender.date;
}

- (IBAction)closeAlarmView:(UIButton *)sender
{
    [[FDReminderManager manager] setReminderTime:_reminderTime];
    if([[FDReminderManager manager] reminder])
        [[FDNotificationManager manager] setCheckinReminder:[[FDReminderManager manager] reminderTime]];
    [self setupReminderLabel];
    [self hideAlarmView];
}

- (IBAction)cancelAlarmView:(UIButton *)sender
{
    [self hideAlarmView];
}

- (void)hideAlarmView
{
    [[FDPopupManager sharedManager] removeTopPopup];
}

@end
