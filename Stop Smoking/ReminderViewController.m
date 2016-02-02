//
//  ReminderViewController.m
//  Everyday Workout
//
//  Created by Kashif Tasneem on 08/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "ReminderViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"


@implementation ReminderViewController

- (id)init
{
    self = [super init];
    if (self) {
        float width = [[AppGeneralController sharedController] getScreenWidth];
        float height = [[AppGeneralController sharedController] getScreenHeight];
        float scale = [[AppGeneralController sharedController] contentScaleFactor];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        
        float btnScale;
        
        if (scale == 2) {
            btnScale = scale;
        }
        else {
            btnScale = 2;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            kYForIPhone = 1;
            kXForIPhone = 1;
        }
        else {
            kYForIPhone = 320.0f/768.0f;
            kXForIPhone = 480.0f/1024.0f;
        }

        
        
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
        
        [background setFrame:CGRectMake(0, 0, width/scale, height/scale)];
        [[self view] addSubview:background];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {

            //title
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, screenRect.size.width - 20, 100)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:60];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Schedule A Session";
            [self.view addSubview:label];

            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:image forState:UIControlStateNormal];
            [backButton setImage:image forState:UIControlEventTouchUpInside];
            [backButton addTarget:[AppGeneralController sharedController] action:@selector(reminderScreenBackPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [backButton setFrame:CGRectMake(0, 0, image.size.width * 5, image.size.height * 3)];
            [[self view] addSubview:backButton];
            
            image = [UIImage imageNamed:@"ButtonRectangle.png"];
            
            float xPos = screenRect.size.width / 8.0;
            mon = [self addButton:@"MON" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_MON_TAG];
            mon.center = CGPointMake(xPos, 370);
            [mon addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:mon];
            
            tue = [self addButton:@"TUE" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_TUE_TAG];
            tue.center = CGPointMake(xPos * 3, 370);
            [tue addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:tue];
            
            wed = [self addButton:@"WED" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_WED_TAG];
            wed.center = CGPointMake(xPos * 5, 370);
            [wed addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:wed];
            
            thu = [self addButton:@"THR" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_THU_TAG];
            thu.center = CGPointMake(xPos * 7, 370);
            [thu addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:thu];
            
            xPos = screenRect.size.width / 8.0;
            
            fri = [self addButton:@"FRI" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_FRI_TAG];
            fri.center = CGPointMake(xPos * 2, 470);
            [fri addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:fri];
            
            sat = [self addButton:@"SAT" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_SAT_TAG];
            sat.center = CGPointMake(xPos * 4, 470);
            [sat addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:sat];
            
            sun = [self addButton:@"SUN" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_SUN_TAG];
            sun.center = CGPointMake(xPos * 6, 470);
            [sun addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:sun];
            
            
//            UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width / 2.0, screenRect.size.height/3)];
//            datePicker.center = CGPointMake(screenRect.size.width / 2.0, screenRect.size.height*2/3);
            
            UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenRect.size.height * 2 / 3, screenRect.size.width, screenRect.size.height / 3)];
            datePicker.transform = CGAffineTransformMakeScale(2.0, 2.0);
            [datePicker setBackgroundColor:[UIColor whiteColor]];
            [datePicker setTag:REMINDER_VIEW_CONTROLLER_DATE_PICKER_TAG];

            datePicker.datePickerMode = UIDatePickerModeTime;
            [[self view] addSubview:datePicker];
            [[AppGeneralController sharedController] setDatePicker:datePicker];
            
        }
        else
        {
            //title
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, screenRect.size.width - 20, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Schedule A Session";
            [self.view addSubview:label];

            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:image forState:UIControlStateNormal];
            [backButton setImage:image forState:UIControlEventTouchUpInside];
            [backButton addTarget:[AppGeneralController sharedController] action:@selector(reminderScreenBackPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [backButton setFrame:CGRectMake(0, 0, image.size.width * 5, image.size.height * 3)];
            [[self view] addSubview:backButton];
            
            image = [UIImage imageNamed:@"ButtonRectangle.png"];

            float xPos = screenRect.size.width / 8.0;
            mon = [self addButton:@"MON" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_MON_TAG];
            mon.center = CGPointMake(xPos, 180);
            [mon addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:mon];
            
            tue = [self addButton:@"TUE" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_TUE_TAG];
            tue.center = CGPointMake(xPos * 3, 180);
            [tue addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:tue];
            
            wed = [self addButton:@"WED" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_WED_TAG];
            wed.center = CGPointMake(xPos * 5, 180);
            [wed addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:wed];
            
            thu = [self addButton:@"THR" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_THU_TAG];
            thu.center = CGPointMake(xPos * 7, 180);
            [thu addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:thu];
            
            xPos = screenRect.size.width / 8.0;

            fri = [self addButton:@"FRI" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_FRI_TAG];
            fri.center = CGPointMake(xPos * 2, 230);
            [fri addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:fri];
            
            sat = [self addButton:@"SAT" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_SAT_TAG];
            sat.center = CGPointMake(xPos * 4, 230);
            [sat addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:sat];
            
            sun = [self addButton:@"SUN" frame:CGRectMake(0, 0, image.size.width, image.size.height) AndTag:REMINDER_VIEW_CONTROLLER_SUN_TAG];
            sun.center = CGPointMake(xPos * 6, 230);
            [sun addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:sun];
            
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenRect.size.height - 210, screenRect.size.width, 210)];
            [datePicker setBackgroundColor:[UIColor whiteColor]];
            [datePicker setTag:REMINDER_VIEW_CONTROLLER_DATE_PICKER_TAG];
            
            datePicker.datePickerMode = UIDatePickerModeTime;
            [[self view] addSubview:datePicker];
            [[AppGeneralController sharedController] setDatePicker:datePicker];
            
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_MON_TAG]]) {
            mon.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_TUE_TAG]]) {
            tue.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_WED_TAG]]) {
            wed.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_THU_TAG]]) {
            thu.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_FRI_TAG]]) {
            fri.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SAT_TAG]]) {
            sat.selected = YES;
        }
        
        if ([[[AppGeneralController sharedController] selectedDayButtons] containsObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SUN_TAG]]) {
            sun.selected = YES;
        }
        
    }
    return self;
}

-(UIButton *) addButton:(NSString*) title frame:(CGRect)frame AndTag:(int) tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"ButtonRectangle.png"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn setTag:tag];
    [btn setFrame:frame];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        btn.titleLabel.font = [UIFont systemFontOfSize:32];
    
    return btn;
}

-(void) buttonTaped:(UIButton*) sender
{
 
    if (sender.isSelected) {
        switch (sender.tag) {
            case REMINDER_VIEW_CONTROLLER_MON_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_MON_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Mon"];
                break;
            case REMINDER_VIEW_CONTROLLER_TUE_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_TUE_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Tue"];
                break;
            case REMINDER_VIEW_CONTROLLER_WED_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_WED_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Wed"];
                break;
            case REMINDER_VIEW_CONTROLLER_THU_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_THU_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Thu"];
                break;
            case REMINDER_VIEW_CONTROLLER_FRI_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_FRI_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Fri"];
                break;
            case REMINDER_VIEW_CONTROLLER_SAT_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SAT_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Sat"];
                break;
            case REMINDER_VIEW_CONTROLLER_SUN_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] removeObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SUN_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",NO] havingKey:@"Sun"];
                break;
                
            default:
                break;
        }
    }
    else {
        switch (sender.tag) {
            case REMINDER_VIEW_CONTROLLER_MON_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_MON_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Mon"];
                break;
            case REMINDER_VIEW_CONTROLLER_TUE_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_TUE_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Tue"];
                break;
            case REMINDER_VIEW_CONTROLLER_WED_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_WED_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Wed"];
                break;
            case REMINDER_VIEW_CONTROLLER_THU_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_THU_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Thu"];
                break;
            case REMINDER_VIEW_CONTROLLER_FRI_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_FRI_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Fri"];
                break;
            case REMINDER_VIEW_CONTROLLER_SAT_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SAT_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Sat"];
                break;
            case REMINDER_VIEW_CONTROLLER_SUN_TAG:
                [[[AppGeneralController sharedController] selectedDayButtons] addObject:[NSNumber numberWithInt:REMINDER_VIEW_CONTROLLER_SUN_TAG]];
                [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",YES] havingKey:@"Sun"];
                break;
                
            default:
                break;
        }
    }
    
    sender.selected = !sender.selected;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
