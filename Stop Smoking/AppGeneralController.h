//
//  AppGeneralController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 06/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MBProgressHUD.h"

@interface AppGeneralController : NSObject<UIDocumentInteractionControllerDelegate>
{
    MBProgressHUD *HUD;
    long long expectedLength;
	long long currentLength;
    
    
    UIDatePicker *datePicker_;
    NSMutableArray *selectedDayButtons_;
    NSString *reminderHour_;
    NSString *reminderMin_;
    NSString *reminderZone_;
    
    int checkedIndex_;
    
    UIButton *playPauseButton_;
    AVAudioPlayer *soundPlayer_;
}

@property (nonatomic,retain) NSMutableArray *selectedDayButtons;
@property (nonatomic,retain) NSString *reminderHour;
@property (nonatomic,retain) NSString *reminderMin;
@property (nonatomic,retain) NSString *reminderZone;

@property int checkedIndex;

@property (nonatomic,retain) UIButton *playPauseButton;
@property (nonatomic,retain) AVAudioPlayer *soundPlayer;

+(AppGeneralController*) sharedController;

-(void) initialize;

-(float) getScreenWidth;
-(float) getScreenHeight;
-(float) contentScaleFactor;

-(void) saveToUserDefaults:(NSString*) object havingKey:(NSString*)key;
-(NSString*) loadFromUserDefaults:(NSString*) key;

-(BOOL) isFirstRun;

-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height;
-(void) loadCheckedIndexValue;

-(BOOL) isIosVersion6;

//Callbacks start For MainScreenViewController

-(void) mainScreenIntroButtonPressed;
-(void) mainScreenMainButtonPressed;
-(void) mainScreenCarvingsButtonPressed;
-(void) mainScreenTipsButtonPressed:(UIButton*) sender;
-(void) mainScreenReminderButtonPressed:(UIButton*) sender;
-(void) mainScreenTodoButtonPressed:(UIButton*) sender;

//Callbacks end for MainScreenViewController

//Callbacks start of ReminderViewController

-(UIDatePicker*) getDatePicker;
-(void) setDatePicker:(UIDatePicker*)dp;
-(void) reminderScreenBackPressed:(UIButton*) sender;
-(void) timePickerValueChanged;
-(void) addUserLocalNotifications;
-(void) pushLocalNotificationHavingHour:(int) hour Minutes:(int) min Day:(int) day Month:(int) month andYear:(int) year;
-(int) returnReminderDayWithTag:(int)tag;

//Callbacks end of ReminderViewController

//Callbacks start of ViewViewController

-(void) videoScreenPlayButtonPressed:(UIButton*) sender;
-(void) videoScreenHomeButtonPressed:(UIButton *)sender;

//Callbacks end of VideoViewController

//Callbacks start of SocialScreenViewController

-(void) socialScreenFbButtonPressed;
-(void) socialScreenTwitterButtonPressed;
-(void) socialScreenInstagramButtonPressed;
-(void) socialScreenEmailButtonPressed;
-(void) socialScreenHomeButtonPressed:(UIButton*) sender;

//Callbacks end of SocialScreenViewController

//Callbacks start of TodoViewController

-(void) toDoBackButtonPressed:(UIBarButtonItem*) sender;

//Callbacks end of TodoViewController

//Callbacks start of TodoEditViewController

-(void) todoEditScreenBackButtonPressed:(UIBarButtonItem*) sender;

//Callbacks end of TodoEditViewController

//Callbacks start of TipsEditViewController

-(void) tipsEditScreenBackButtonPressed:(UIBarButtonItem*) sender;

//Callbacks end of TipsEditViewController

@end
