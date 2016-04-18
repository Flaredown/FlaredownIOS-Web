//
//  FDNotificationManager.m
//  Flaredown
//
//  Created by Cole Cunningham on 7/6/15.
//  Copyright (c) 2015 Flaredown. All rights reserved.
//

#import "FDNotificationManager.h"

@implementation FDNotificationManager

static NSString * const NotificationIdentifierKey = @"notificationIdentifier";
static NSString * const NotificationIdentifierCheckin = @"checkin";

+ (id)manager
{
    static FDNotificationManager *sharedNotificationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNotificationManager = [[self alloc] init];
    });
    return sharedNotificationManager;
}

- (id)init
{
    if(self = [super init]) {
        UIUserNotificationType types = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
    return self;
}

- (void)setCheckinReminder:(NSDate *)date
{
    [self removeCheckinReminder];
    [self addNotificationWithDate:date repeatInterval:NSCalendarUnitDay text:@"Don’t forget to check into Flaredown today!" identifier:NotificationIdentifierCheckin];
}

- (void)removeCheckinReminder
{
    [self removeNotificationWithIdentifier:NotificationIdentifierCheckin];
}

- (void)addNotificationWithDate:(NSDate *)date repeatInterval:(NSCalendarUnit)repeatInterval text:(NSString *)text identifier:(NSString *)identifier
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.repeatInterval = repeatInterval;
    localNotification.alertBody = text;
    [localNotification.userInfo setValue:identifier forKey:NotificationIdentifierKey];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)removeNotificationWithIdentifier:(NSString *)identifier
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *notifications = [app scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications) {
        NSDictionary *userInfoCurrent = notification.userInfo;
        NSString *notificationIdentifier = [NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:NotificationIdentifierKey]];
        if ([notificationIdentifier isEqualToString:identifier])
        {
            [app cancelLocalNotification:notification];
            break;
        }
    }
}

- (void)removeAllNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
