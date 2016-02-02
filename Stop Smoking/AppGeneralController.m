//
//  AppGeneralController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 06/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "AppGeneralController.h"
#import "Constants.h"
#import "MainViewController.h"
#import "ReminderViewController.h"
#import "VideoViewController.h"
#import "SocialScreenViewController.h"
#import "TwitterViewController.h"
#import "FacebookViewController.h"
#import "AppDelegate.h"
#import "EmailViewController.h"
#import "ToDoViewController.h"
#import "TipsViewController.h"
#import "MBProgressHUD.h"

static AppGeneralController *_sharedInstance = nil;

@implementation AppGeneralController

@synthesize selectedDayButtons = selectedDayButtons_;
@synthesize reminderHour = reminderHour_;
@synthesize reminderMin = reminderMin_;
@synthesize reminderZone = reminderZone_;

@synthesize checkedIndex = checkedIndex_;

@synthesize playPauseButton = playPauseButton_;
@synthesize soundPlayer = soundPlayer_;

+(AppGeneralController*) sharedController
{
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

+(id)alloc
{
    @synchronized(self)
    {
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of AppGeneralController.");
		_sharedInstance = [super alloc];
		return _sharedInstance;
	}
	return nil;
}

-(id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) initialize
{
    selectedDayButtons_ = [[NSMutableArray alloc] init];
    if ([[self loadFromUserDefaults:@"Mon"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_MON_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Tue"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_TUE_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Wed"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_WED_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Thu"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_THU_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Fri"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_FRI_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Sat"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SAT_TAG]];
    }
    if ([[self loadFromUserDefaults:@"Sun"] boolValue]) {
        [selectedDayButtons_ addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SUN_TAG]];
    }
    
    reminderHour_ = nil;
    reminderMin_ = nil;
    reminderZone_ = nil;
    
    [self loadCheckedIndexValue];
}

-(void) loadCheckedIndexValue
{
    if ([self loadFromUserDefaults:@"CheckedIndex"] != nil) {
        checkedIndex_ = [[[AppGeneralController sharedController] loadFromUserDefaults:@"CheckedIndex"] intValue];
    }
    else {
        checkedIndex_ = 0;
        [self saveToUserDefaults:[NSString stringWithFormat:@"%d",0] havingKey:@"CheckedIndex"];
    }
}

-(float) getScreenWidth
{
    int scale = [[UIScreen mainScreen] scale];
    
    return ([[UIScreen mainScreen] bounds].size.width) * scale;
}

-(float) getScreenHeight
{
    int scale = [[UIScreen mainScreen] scale];
    
    return ([[UIScreen mainScreen] bounds].size.height) * scale;
}

-(float) contentScaleFactor
{
    return [[UIScreen mainScreen] scale];
}

-(void) saveToUserDefaults:(NSString*) object havingKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:object forKey:key];
    
    [defaults synchronize];
}

-(NSString*) loadFromUserDefaults:(NSString*) key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *object = [defaults objectForKey:key];
    
    if (!object) {
        return nil;
    }
    else {
        return object;
    }
}

-(BOOL) isFirstRun
{
    NSString *retVal = [self loadFromUserDefaults:@"FirstRun"];
    
    if (retVal == nil) {
        [self saveToUserDefaults:@"NO" havingKey:@"FirstRun"];
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL) isIosVersion6
{
    int currSysVer = [[[UIDevice currentDevice] systemVersion] intValue];
    
    if (currSysVer == 6) {
        return YES;
    }
    else {
        return NO;
    }
}

-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height {
    
    CGImageRef imageRef = [image CGImage];
    CGImageAlphaInfo alphaInfo = kCGImageAlphaNoneSkipLast;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

//Callbacks start for MainScreenViewController

-(void) mainScreenIntroButtonPressed
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    VideoViewController *videoViewController = [[VideoViewController alloc] initWithAudioName:@"Intro" title:@"INTRODUCTION"];
    [navController pushViewController:videoViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) mainScreenMainButtonPressed
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    VideoViewController *videoViewController = [[VideoViewController alloc] initWithAudioName:@"Session" title:@"WEIGHT LOSS"];
    [navController pushViewController:videoViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) mainScreenCarvingsButtonPressed
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    VideoViewController *videoViewController = [[VideoViewController alloc] initWithAudioName:@"Cravings" title:@"CRAVINGS"];
    [navController pushViewController:videoViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}


- (void)didDismissMoreApps
{
    [HUD hide:YES];
}

-(void)myTask
{
    float progress = 0.0f;
    
    while (progress <1.0f) {
        progress +=0.02f;
        HUD.progress = progress;
        usleep(50000);
    }
}
#pragma mark NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon..png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
}


-(void) mainScreenTipsButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    TipsViewController *tipsViewController = [[TipsViewController alloc] init];
    [navController pushViewController:tipsViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) mainScreenReminderButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    ReminderViewController *reminderViewController = [[ReminderViewController alloc] init];
    [navController pushViewController:reminderViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) mainScreenTodoButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:NO];
    ToDoViewController *todoViewController = [[ToDoViewController alloc] initWithStyle:UITableViewStylePlain];
    [navController pushViewController:todoViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

//Callbacks end for MainScreenViewController

//Callbacks start of ReminderViewController

-(UIDatePicker*) getDatePicker
{
    return datePicker_;
}

-(void) setDatePicker:(UIDatePicker*)dp
{
    datePicker_ = dp;
}

-(void) reminderScreenBackPressed:(UIButton*) sender
{
    [self timePickerValueChanged];
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    
    [navController popViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) timePickerValueChanged
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"h"];
    reminderHour_ = [outputFormatter stringFromDate:datePicker_.date];
    
    [outputFormatter setDateFormat:@"m"];
    reminderMin_ = [outputFormatter stringFromDate:datePicker_.date];
    
    [outputFormatter setDateFormat:@"a"];
    reminderZone_ = [outputFormatter stringFromDate:datePicker_.date];
   
    [self addUserLocalNotifications];
}

-(void) addUserLocalNotifications
{
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    
    NSDateComponents *currentComponents = [gregorian components: NSUIntegerMax fromDate: date];
    int currentHour = [currentComponents hour];
    int currentMin = [currentComponents minute];
    
    int hour = [reminderHour_ intValue];
    
    if ([reminderZone_ isEqualToString:@"PM"] && hour != 12) {
        hour += 12;
    }
    else if ([reminderZone_ isEqualToString:@"AM"] && hour == 12) {
        hour = 0;
    }
    
    reminderHour_ = [NSString stringWithFormat:@"%d",hour];
    
    for (int i = 0; i < [selectedDayButtons_ count]; i++) {
        
        int tag = [[selectedDayButtons_ objectAtIndex:i] intValue];
        int returnedDay = [self returnReminderDayWithTag:tag];
        
        int currentDay = [currentComponents weekday];
        int diff = abs(currentDay - returnedDay);
        
        if (currentDay > returnedDay) {
            diff = 7 - diff;
        }
        
        if ((currentDay == returnedDay ) && ((currentHour > hour) || (currentMin > [reminderMin_ intValue])) ) {
            diff = diff + 7;
        }
        
        [self saveToUserDefaults:reminderHour_ havingKey:@"ReminderHour"];
        [self saveToUserDefaults:reminderMin_ havingKey:@"ReminderMin"];
        [self saveToUserDefaults:[NSString stringWithFormat:@"%d",returnedDay] havingKey:[NSString stringWithFormat:@"ReminderDay_%d",returnedDay]];
        [self saveToUserDefaults:reminderZone_ havingKey:@"ReminderZone"];
        
        int dayInc = 0;
        
        for (int i = 1; i <= 10; i++) {
            [self pushLocalNotificationHavingHour:hour Minutes:[reminderMin_ intValue] Day:((diff + [currentComponents day]) + dayInc) Month:[currentComponents month] andYear:[currentComponents year]];
            dayInc += 7;
        }
        
    }
}

-(void) pushLocalNotificationHavingHour:(int) hour Minutes:(int) min Day:(int) day Month:(int) month andYear:(int) year
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
    [localNotification setAlertBody:USER_LOCAL_NOTIFICATION_MESSAGE];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(int) returnReminderDayWithTag:(int)tag
{
    int retVal = -1;
    switch (tag) {
        case REMINDER_VIEW_CONTROLLER_SUN_TAG:
            retVal = 1;
            break;
        case REMINDER_VIEW_CONTROLLER_MON_TAG:
            retVal = 2;
            break;
        case REMINDER_VIEW_CONTROLLER_TUE_TAG:
            retVal = 3;
            break;
        case REMINDER_VIEW_CONTROLLER_WED_TAG:
            retVal = 4;
            break;
        case REMINDER_VIEW_CONTROLLER_THU_TAG:
            retVal = 5;
            break;
        case REMINDER_VIEW_CONTROLLER_FRI_TAG:
            retVal = 6;
            break;
        case REMINDER_VIEW_CONTROLLER_SAT_TAG:
            retVal = 7;
            break;
            
        default:
            break;
    }
    return retVal;
}

//Callbacks end of ReminderViewController

//Callbacks start of ViewViewController

-(void) videoScreenPlayButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    SocialScreenViewController *socialScreenViewController = [[SocialScreenViewController alloc] init];
    [navController pushViewController:socialScreenViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) videoScreenHomeButtonPressed:(UIButton *)sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController popToRootViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

//Callbacks end of VideoViewController

//Callbacks start of SocialScreenViewController

-(void) socialScreenFbButtonPressed
{
//    if ([self isIosVersion6]) {
        UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
        FacebookViewController *facebookViewController = [[FacebookViewController alloc] init];
        [navController pushViewController:facebookViewController animated:NO];
//        [facebookViewController release];
//        [[MainViewController sharedViewController] setNavControllerWith:navController];
    
//    }
//    else {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't Share" message:@"Upgrade to ios version 6 to use Facebook Sharing" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//        [alertView release];
//    }
}

-(void) socialScreenTwitterButtonPressed
{
//    if ([self isIosVersion6]) {
        UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
        TwitterViewController *twitterViewController = [[TwitterViewController alloc] init];
        [navController pushViewController:twitterViewController animated:NO];
//        [twitterViewController release];
//        [[MainViewController sharedViewController] setNavControllerWith:navController];
    
//    }
//    else {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't Tweet" message:@"Upgrade to ios version 6 to use twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//        [alertView release];
//    }
}

-(void) socialScreenInstagramButtonPressed
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"Image.ig"];
        NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"Instagram.jpeg"], 0);
        
        [imageData writeToFile:savedImagePath atomically:YES];
        NSURL *imageUrl = [NSURL fileURLWithPath:savedImagePath];
        UIDocumentInteractionController *docController = [[UIDocumentInteractionController alloc] init];
        docController.delegate = self;
        docController.UTI = @"com.instagram.photo";
        [docController setURL:imageUrl];
        
        AppDelegate *delegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        RootViewController *viewController = [delegate viewController];
        [docController presentOpenInMenuFromRect:CGRectZero inView:viewController.view animated:YES];
     }else{
        
        UIAlertView *errorToShare = [[UIAlertView alloc] initWithTitle:@"Instagram unavailable " message:@"You need to install Instagram in your device in order to share this image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorToShare show];
    }
}

-(void) socialScreenEmailButtonPressed
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    EmailViewController *emailViewController = [[EmailViewController alloc] init];
    [navController pushViewController:emailViewController animated:NO];
//    [emailViewController release];
//    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) socialScreenHomeButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController popToRootViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}
//Callbacks end of SocialScreenViewController

//Callbacks start of TodoViewController

-(void) toDoBackButtonPressed:(UIBarButtonItem*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:YES];
    [navController popToRootViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

//Callbacks end of TodoViewController

//Callbacks start of TodoEditViewController

-(void) todoEditScreenBackButtonPressed:(UIBarButtonItem*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:NO];
    [navController popViewControllerAnimated:NO];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

//Callbacks end of TodoEditViewController

//Callbacks start of TipsEditViewController

-(void) tipsEditScreenBackButtonPressed:(UIBarButtonItem*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:YES];
    [navController popViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

//Callbacks end of TipsEditViewController

@end
