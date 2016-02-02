//
//  AppDelegate.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 06/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MainScreenViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "DatabaseManager.h"

@implementation AppDelegate
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [[DatabaseManager sharedManager] initlializeDatabaseManager];
    
    viewController = [[RootViewController alloc] init];
    [self.window setRootViewController:viewController];
    
    [[AppGeneralController sharedController] initialize];
    
    MainScreenViewController *mainScreen = [[MainScreenViewController alloc] init];
    
    [[MainViewController sharedViewController] initNavControllerWith:mainScreen];
    
    [[[self viewController] view] addSubview:[[MainViewController sharedViewController] getNavController].view];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self checkAndAddUserReminders];
    [self checkAndAddTodos];
    
    [AppData sharedData].nState = 0;
    NSLog(@"width=%f height=%f",[[AppGeneralController sharedController] getScreenWidth],[[AppGeneralController sharedController] getScreenHeight]);
    sleep(2);
    return YES;
}

-(NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    if ([[AppGeneralController sharedController] playPauseButton]) {
        [[[AppGeneralController sharedController] playPauseButton] setSelected:NO];
    }
    
    if ([[AppGeneralController sharedController] soundPlayer]) {
        [[[AppGeneralController sharedController] soundPlayer] pause];
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if ([[AppGeneralController sharedController] playPauseButton]) {
        [[[AppGeneralController sharedController] playPauseButton] setSelected:NO];
    }
    
    if ([[AppGeneralController sharedController] soundPlayer]) {
        [[[AppGeneralController sharedController] soundPlayer] pause];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (NSString*) getLocalDateAndTime {
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    currentDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeZone:sourceTimeZone];
    
    NSString *string = [dateFormatter stringFromDate:currentDate];
    NSLog(@"Local_DateTime = %@", string);
    return string;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self getLocalDateAndTime];
    NSDate* prev_time = [[NSUserDefaults standardUserDefaults] objectForKey:@"PREV_TIME"];
    NSTimeInterval differenceTime = [currentDate timeIntervalSinceDate:prev_time];
    
    if (differenceTime < 25) {
        if ([AppData sharedData].nState == 2)
            [AppData sharedData].bSession2 = NO;
        else if ([AppData sharedData].nState == 3)
            [AppData sharedData].bSession3 = NO;
    }
    else if (differenceTime > 25){
        if ([AppData sharedData].nState == 2)
            [AppData sharedData].bSession2 = YES;
        else if ([AppData sharedData].nState == 3)
            [AppData sharedData].bSession3 = YES;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) checkAndAddTodos
{
    if ([[DatabaseManager sharedManager] checkIfTodosExist]) {
        [self addTodos];
    }
}

-(void) addTodos
{
    int total = [[DatabaseManager sharedManager] getTotalNumberOfRecords];
    
    for (int i = 1; i <= total; i++) {
        
        NSString *name = [[DatabaseManager sharedManager] getNameForId:i];
        if (name == nil) {
            continue;
        }
        
        int hour = [[DatabaseManager sharedManager] getHourForId:i];
        int min = [[DatabaseManager sharedManager] getMinutesForId:i];
        int day = [[DatabaseManager sharedManager] getDayForId:i];
        int month = [[DatabaseManager sharedManager] getMonthForId:i];
        int year = [[DatabaseManager sharedManager] getYearForId:i];
        
        NSString *message = [[DatabaseManager sharedManager] getNameForId:i];
        
        NSDate *date = [NSDate date];
         NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
        NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
        
        int currentYear = [components year];
        int currentMonth = [components month];
        int currentDay = [components day];
        int currentHour = [components hour];
        int currentMin = [components minute];
        
        if (currentYear > year) {
            [[DatabaseManager sharedManager] setNotIsActiveForId:i];
        }
        else if ((currentMonth > month) && (currentYear == year)) {
            [[DatabaseManager sharedManager] setNotIsActiveForId:i];
        }
        else if ((currentDay > day) && (currentYear == year) && (currentMonth == month)) {
            [[DatabaseManager sharedManager] setNotIsActiveForId:i];
        }
        else if ((currentHour > hour) && (currentYear == year) && (currentMonth == month) && (currentDay == day)) {
            [[DatabaseManager sharedManager] setNotIsActiveForId:i];
        }
        else if ((currentMin > min) && (currentYear == year) && (currentMonth == month) && (currentDay == day) && (currentHour == hour)) {
            [[DatabaseManager sharedManager] setNotIsActiveForId:i];
        }
        
        BOOL isActive = [[DatabaseManager sharedManager] getIsActiveForId:i];
        
        if (!isActive) {
            continue;
        }
        
        
        [self pushLocalNotificationHavingHour:hour Minutes:min Day:day Month:month year:year andMessage:message];
    }
    
}

-(void) pushLocalNotificationHavingHour:(int) hour Minutes:(int) min Day:(int) day Month:(int) month year:(int) year andMessage:(NSString*) message
{
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    
    [components setHour: hour];
    [components setMinute: min];
    [components setSecond: 0];
    
    [components setMonth:month];
    [components setYear:year];
    [components setDay:day];
    
    NSDate *newDate = [gregorian dateFromComponents: components];
    NSLog(@"Date=%@",newDate);
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate:newDate];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    [localNotification setAlertAction:@"OK"];
    [localNotification setAlertBody:message];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];    
}

-(void) checkAndAddUserReminders
{
    NSString *checkValue = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderHour"];
    if (checkValue != nil) {
        NSString *hour = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderHour"];
        NSString *min = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderMin"];
        
        [[AppGeneralController sharedController] setReminderHour:hour];
        [[AppGeneralController sharedController] setReminderMin:min];
        [self addCustomLocalNotification];
    }
}

-(void) addCustomLocalNotification
{
    
    NSString *reminderHour = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderHour"];
    NSString *reminderMin = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderMin"];
    NSString *reminderZone = [[AppGeneralController sharedController] loadFromUserDefaults:@"ReminderZone"];
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    
    NSDateComponents *currentComponents = [gregorian components: NSUIntegerMax fromDate: date];
    int currentHour = [currentComponents hour];
    int currentMin = [currentComponents minute];
    
    int hour = [reminderHour intValue];
    
    
    for (int i = 0; i < [[[AppGeneralController sharedController] selectedDayButtons] count]; i++) {
        int tag = [[[[AppGeneralController sharedController] selectedDayButtons] objectAtIndex:i] intValue];
        int returnedDay = [[AppGeneralController sharedController] returnReminderDayWithTag:tag];
        
        int currentDay = [currentComponents weekday];
        int diff = abs(currentDay - returnedDay);
        
        if (currentDay > returnedDay) {
            diff = 7 - diff;
        }
        
        if ((currentDay == returnedDay ) && ((currentHour > hour) || (currentMin > [reminderMin intValue])) ) {
            diff = diff + 7;
        }
        
        [[AppGeneralController sharedController] saveToUserDefaults:reminderHour havingKey:@"ReminderHour"];
        [[AppGeneralController sharedController] saveToUserDefaults:reminderMin havingKey:@"ReminderMin"];
        [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",returnedDay] havingKey:[NSString stringWithFormat:@"ReminderDay_%d",returnedDay]];
        [[AppGeneralController sharedController] saveToUserDefaults:reminderZone havingKey:@"ReminderZone"];
        
        int dateInc = 0;
        for (int i = 1; i <= 20; i++) {
            [[AppGeneralController sharedController] pushLocalNotificationHavingHour:hour Minutes:[reminderMin intValue] Day:((diff + [currentComponents day]) + dateInc ) Month:[currentComponents month] andYear:[currentComponents year]];
            dateInc += 7;
        }
    }
}

@end
