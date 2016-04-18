//
//  FDReminderManager.m
//  Flaredown
//
//  Created by Cole Cunningham on 4/18/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import "FDReminderManager.h"

@implementation FDReminderManager

static NSString * const reminderKey = @"checkin_reminder";
static NSString * const reminderTimeKey = @"checkin_time";

+ (id)manager
{
    static FDReminderManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if(self) {
        //Initialization code here
    }
    return self;
}

- (BOOL)reminder
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:reminderKey])
        return NO;
    return [[[NSUserDefaults standardUserDefaults] objectForKey:reminderKey] isEqualToNumber:@YES] ? YES : NO;
}

- (void)toggleReminder
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:reminderKey];
    NSNumber *updatedValue = [[NSNumber alloc] initWithBool:![value isEqualToNumber:@YES]];
    [[NSUserDefaults standardUserDefaults] setObject:updatedValue forKey:reminderKey];
}

- (NSDate *)reminderTime
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:reminderTimeKey])
        return [NSDate date];
    return [[NSUserDefaults standardUserDefaults] objectForKey:reminderTimeKey];
}

- (void)setReminderTime:(NSDate *)reminderTime
{
    [[NSUserDefaults standardUserDefaults] setObject:reminderTime forKey:reminderTimeKey];
}

@end
