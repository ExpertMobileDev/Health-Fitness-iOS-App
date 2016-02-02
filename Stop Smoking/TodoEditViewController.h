//
//  TodoEditViewController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoEditViewController : UIViewController
{
    UITextView *    title;
    UIBarButtonItem *doneBtn;
    UISwitch *reminderSwitch;
    UIDatePicker *datePicker;
    
    NSString *reminderHour_;
    NSString *reminderMin_;
    NSString *reminderZone_;
    int reminderDay_;
    
    int todoDay_;
    int todoMonth_;
    
    int index_;
    
    CGRect          screenRect;

}

- (id)initWithId:(int) idValue;
-(void) initialize;
-(void) doneBtnPressed:(UIBarButtonItem*) sender;
-(void) addReminders;
-(void) setReminderDay:(NSString*) day;
-(void) repeatButtonPressed:(UIButton*) sender;

-(NSString*) getIntervalString;
-(void) pushLocalNotificationHavingHour:(int) hour Minutes:(int) min Day:(int) day Month:(int) month year:(int) year andMessage:(NSString*) message;

@end
