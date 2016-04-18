//
//  FDReminderManager.h
//  Flaredown
//
//  Created by Cole Cunningham on 4/18/16.
//  Copyright © 2016 Flaredown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDReminderManager : NSObject

+ (id)manager;

- (BOOL)reminder;
- (void)toggleReminder;
- (NSDate *)reminderTime;
- (void)setReminderTime:(NSDate *)reminderTime;

@end
