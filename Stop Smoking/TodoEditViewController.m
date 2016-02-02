//
//  TodoEditViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "TodoEditViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "RepeatIntervalChooserViewController.h"
#import "MainViewController.h"
#import "DatabaseManager.h"

#define DATE_PICKER_TAG 1234

@implementation TodoEditViewController

- (id)init
{
    self = [super init];
    if (self) {
   
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.title = @"Add New Objective";
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 110)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:32.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text=self.title;
            self.navigationItem.titleView = label;
            [self initialize];
            index_ = -1;
        }
        else{
            
            self.title = @"Add New Objective";
            [self initialize];
            index_ = -1;
            
        }
    }
    return self;
}

- (id)initWithId:(int) idValue
{
    self = [super init];
    if (self) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.title = @"Edit Objective";
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 110)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:32.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text=self.title;
            self.navigationItem.titleView = label;
            [self initialize];
            [title setText:[[DatabaseManager sharedManager] getNameForId:idValue]];
            int isActive = [[DatabaseManager sharedManager] getIsActiveForId:idValue];
            [reminderSwitch setOn:isActive];
            index_ = idValue;
        }
        else
        {
            self.title = @"Edit Objective";
            [self initialize];
            [title setText:[[DatabaseManager sharedManager] getNameForId:idValue]];
            int isActive = [[DatabaseManager sharedManager] getIsActiveForId:idValue];
            [reminderSwitch setOn:isActive];
            index_ = idValue;
        }
    }
    return self;
}

-(void) initialize
{
    screenRect = [[UIScreen mainScreen] bounds];

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
        [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [[self view] addSubview:background];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, screenRect.size.width - 60, 30)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"OBJECTIVE:"];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [[self view] addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:32];
        
        title = [[UITextView alloc] initWithFrame:CGRectMake(30, 120, screenRect.size.width - 60, 180)];
        title.layer.cornerRadius = 5;
        title.clipsToBounds = YES;
        title.editable = YES;
        [title setFont:[UIFont systemFontOfSize:32]];
        [title setBackgroundColor:[UIColor whiteColor]];
        [[self view] addSubview:title];
        
        UIButton * button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:[AppGeneralController sharedController] action:@selector(todoEditScreenBackButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 0, 100, 100)];
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:32.0];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        UIBarButtonItem * backBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backBtn;

//        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:[AppGeneralController sharedController] action:@selector(todoEditScreenBackButtonPressed:)];
//        self.navigationItem.leftBarButtonItem = backBtn;
//        [backBtn release];

        button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(doneBtnPressed:)forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 0, 100, 100)];
        [button setTitle:@"Done" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:32.0];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        doneBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = doneBtn;
        
//        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnPressed:)];
//        self.navigationItem.rightBarButtonItem = doneBtn;
        
        UILabel *reminderSwitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 340, 500, 60)];
        reminderSwitchLabel.textAlignment = NSTextAlignmentLeft;
        [reminderSwitchLabel setTextColor:[UIColor whiteColor]];
        [reminderSwitchLabel setBackgroundColor:[UIColor clearColor]];
        [reminderSwitchLabel setText:@"Remind Me On a Day"];
        reminderSwitchLabel.font = [UIFont systemFontOfSize:32];
        [[self view] addSubview:reminderSwitchLabel];
        
        reminderSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(660, 360, 100, 60)];
        reminderSwitch.transform = CGAffineTransformMakeScale(2.0, 2.0);
        [[self view] addSubview:reminderSwitch];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenRect.size.height*2/3, 768, screenRect.size.height/3)];
        datePicker.transform = CGAffineTransformMakeScale(2.0, 2.0);
        [datePicker setBackgroundColor:[UIColor whiteColor]];
        
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [datePicker setTag:DATE_PICKER_TAG];
        
        UIButton *setDateTimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [setDateTimeBtn setFrame:CGRectMake(0, 0, 300, 60)];
        setDateTimeBtn.center = CGPointMake(screenRect.size.width / 2, 430);
        setDateTimeBtn.titleLabel.font = [UIFont systemFontOfSize:32];
        [setDateTimeBtn setTitle:@"Set Date/Time" forState:UIControlStateNormal];
        //setDateTimeBtn.titleLabel.textColor = [UIColor whiteColor];
        //setDateTimeBtn.backgroundColor = [UIColor clearColor];
        [setDateTimeBtn addTarget:self action:@selector(setDateTimeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[self view] addSubview:setDateTimeBtn];

    }
    else
    {
        
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
        [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [[self view] addSubview:background];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screenRect.size.width - 20, 30)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"OBJECTIVE:"];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [[self view] addSubview:titleLabel];
        
        title = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, screenRect.size.width - 20, 80)];
        title.layer.cornerRadius = 5;
        title.clipsToBounds = YES;
        title.editable = YES;
        [title setFont:[UIFont systemFontOfSize:18]];
        [title setBackgroundColor:[UIColor whiteColor]];
        [[self view] addSubview:title];
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:[AppGeneralController sharedController] action:@selector(todoEditScreenBackButtonPressed:)];
        self.navigationItem.leftBarButtonItem = backBtn;
        
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnPressed:)];
        self.navigationItem.rightBarButtonItem = doneBtn;
        
        UILabel *reminderSwitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 200, 30)];
        reminderSwitchLabel.textAlignment = NSTextAlignmentLeft;
        [reminderSwitchLabel setTextColor:[UIColor whiteColor]];
        [reminderSwitchLabel setBackgroundColor:[UIColor clearColor]];
        [reminderSwitchLabel setText:@"Remind Me On a Day"];
        [[self view] addSubview:reminderSwitchLabel];
        
        reminderSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(260, 150, 40, 30)];
        [[self view] addSubview:reminderSwitch];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenRect.size.height * 2 / 3, 320, screenRect.size.height / 3)];
        [datePicker setBackgroundColor:[UIColor whiteColor]];
        
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [datePicker setTag:DATE_PICKER_TAG];
        
        UIButton *setDateTimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [setDateTimeBtn setFrame:CGRectMake(0, 0, 100, 30)];
        setDateTimeBtn.center = CGPointMake(screenRect.size.width / 2, 200);
        [setDateTimeBtn setTitle:@"Set Date/Time" forState:UIControlStateNormal];
        setDateTimeBtn.titleLabel.textColor = [UIColor whiteColor];
        [setDateTimeBtn addTarget:self action:@selector(setDateTimeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[self view] addSubview:setDateTimeBtn];
    }
}
-(void) doneBtnPressed:(UIBarButtonItem *)sender
{
    
    if (title.text == nil || [title.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Problem" message:@"Please Enter a Valid Todo Title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setDateFormat:@"h"];
    reminderHour_ = [outputFormatter stringFromDate:datePicker.date];
    
    [outputFormatter setDateFormat:@"m"];
    reminderMin_ = [outputFormatter stringFromDate:datePicker.date];
    
    [outputFormatter setDateFormat:@"a"];
    reminderZone_ = [outputFormatter stringFromDate:datePicker.date];
    
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *reminderDay = [outputFormatter stringFromDate:datePicker.date];
    [self setReminderDay:reminderDay];
   
    [self addReminders];
    
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:NO];
    [navController popViewControllerAnimated:NO];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) repeatButtonPressed:(UIButton*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    RepeatIntervalChooserViewController *repeatChooserViewController = [[RepeatIntervalChooserViewController alloc] init];
    [navController pushViewController:repeatChooserViewController animated:NO];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) setReminderDay:(NSString*) day
{
    if ([day isEqualToString:@"Sunday"]) {
        reminderDay_ = 1;
    }
    else if ([day isEqualToString:@"Monday"]) {
        reminderDay_ = 2;
    }
    else if ([day isEqualToString:@"Tuesday"]) {
        reminderDay_ = 3;
    }
    else if ([day isEqualToString:@"Wednesday"]) {
        reminderDay_ = 4;
    }
    else if ([day isEqualToString:@"Thursday"]) {
        reminderDay_ = 5;
    }
    else if ([day isEqualToString:@"Friday"]) {
        reminderDay_ = 6;
    }
    else if ([day isEqualToString:@"Saturday"]) {
        reminderDay_ = 7;
    }
    else {
        reminderDay_ = -1;
    }
}

-(void) addReminders
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
    
    int returnedDay = reminderDay_;
    
    int currentDay = [currentComponents weekday];
    int diff = abs(currentDay - returnedDay);
    
    if (currentDay > returnedDay) {
        diff = 7 - diff;
    }
    
    if ((currentDay == returnedDay ) && ((currentHour > hour) || (currentMin > [reminderMin_ intValue])) ) {
        diff = diff + 7;
    }

    int dayInc = 0;
    
    todoMonth_ = [currentComponents month];
    todoDay_ = [currentComponents day];
    
    for (int i = 1; i <= 10; i++) {
        [self pushLocalNotificationHavingHour:hour Minutes:[reminderMin_ intValue] Day:(diff + todoDay_ + dayInc) Month:todoMonth_ year:[currentComponents year] andMessage:[title text]];
        
//        int repeatInteval = -1;
        NSString *interval = [self getIntervalString];
        if ([interval isEqualToString:@"None"]) {
//            repeatInteval = 0;
            break;
        }
        else if ([interval isEqualToString:@"Every Day"]) {
//            repeatInteval = 1;
        }
        else if ([interval isEqualToString:@"Every Week"]) {
//            repeatInteval = 7;
        }
        else if ([interval isEqualToString:@"Every 2 Weeks"]) {
//            repeatInteval = 14;
        }
        else if ([interval isEqualToString:@"Every Month"]) {
//            repeatInteval = 0;
            todoMonth_++;
        }
        else if ([interval isEqualToString:@"Every Year"]) {
//            repeatInteval = 0;
            todoMonth_ +=12;
        }
        
//        dayInc = repeatInteval;
        
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
    
    todoDay_ = day;
    
    NSDate *newDate = [gregorian dateFromComponents: components];
    NSLog(@"Date=%@",newDate);
    
    NSDateComponents *newComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate: newDate];
    
   
    NSString *interval = [self getIntervalString];
    
    if (index_ == -1) {
        [[DatabaseManager sharedManager] addTodoItemWithName:message RepeatInterval:interval Zone:reminderZone_ Hour:hour Minutes:min Day:[newComponents day] Month:[newComponents month] Year:[newComponents year] isActive:[reminderSwitch isOn] andIsCompleted:0];
    }
    else {
        BOOL isCompleted = [[DatabaseManager sharedManager] getIsCompletedForId:index_];
        [[DatabaseManager sharedManager] updateTodoItemWithName:message RepeatInterval:interval Zone:reminderZone_ Hour:hour Minutes:min Day:[newComponents day] Month:[newComponents month] Year:[newComponents year] isActive:[reminderSwitch isOn] isCompleted:isCompleted andId:index_];
    }
    
    if (![reminderSwitch isOn]) {
        return;
    }
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate:newDate];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    [localNotification setAlertAction:@"OK"];
    [localNotification setAlertBody:USER_LOCAL_NOTIFICATION_REMINDER];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void) setDateTimeBtnPressed:(UIButton*) sender
{
    if ([[self view] viewWithTag:DATE_PICKER_TAG]) {
        [[[self view] viewWithTag:DATE_PICKER_TAG] removeFromSuperview];
    }
    else {
        
        [[self view] addSubview:datePicker];
        [title resignFirstResponder];
        
        if (index_ != -1) {
            int hour = [[DatabaseManager sharedManager] getHourForId:index_];
            int min = [[DatabaseManager sharedManager] getMinutesForId:index_];
            int month = [[DatabaseManager sharedManager] getMonthForId:index_];
            int day = [[DatabaseManager sharedManager] getDayForId:index_];
            int year = [[DatabaseManager sharedManager] getYearForId:index_];
            
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
            
            [datePicker setDate:newDate animated:YES];
        }
        
    }
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [title resignFirstResponder];
//    return YES;
//}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [title resignFirstResponder];
}

-(NSString*) getIntervalString
{
    NSString *retVal = nil;
    switch ([[AppGeneralController sharedController] checkedIndex]) {
        case 0:
            retVal = @"None";
            break;
        case 1:
            retVal = @"Every Day";
            break;
        case 2:
            retVal = @"Every Week";
            break;
        case 3:
            retVal = @"Every 2 Weeks";
            break;
        case 4:
            retVal = @"Every Month";
            break;
        case 5:
            retVal = @"Every Year";
            break;
        default:
            break;
    }
    return retVal;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor blackColor]];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[AppGeneralController sharedController] loadCheckedIndexValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
