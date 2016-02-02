//
//  AppDelegate.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 06/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    RootViewController *viewController;
    NSDate* currentDate;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) RootViewController *viewController;

-(void) checkAndAddUserReminders;
-(void) addCustomLocalNotification;
-(void) checkAndAddTodos;
-(void) addTodos;
-(void) pushLocalNotificationHavingHour:(int) hour Minutes:(int) min Day:(int) day Month:(int) month year:(int) year andMessage:(NSString*) message;
@end
