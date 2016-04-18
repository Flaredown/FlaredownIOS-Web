//
//  FDNotificationManager.h
//  Flaredown
//
//  Created by Cole Cunningham on 7/6/15.
//  Copyright (c) 2015 Flaredown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FDNotificationManager : NSObject

+ (id)manager;

- (void)setCheckinReminder:(NSDate *)date;
- (void)removeCheckinReminder;

@end
