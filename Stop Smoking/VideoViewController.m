//
//  VideoViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "VideoViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "MainViewController.h"
#import "SocialScreenViewController.h"

@implementation VideoViewController

- (id)initWithAudioName:(NSString*) name title:(NSString *)strTitle
{
    self = [super init];
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        float scale = [[AppGeneralController sharedController] contentScaleFactor];
        
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

        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            [self addButtonWithNormalImage:@"Play.png" posx:226 posy:screenRect.size.height * 0.3 andSelector:@selector(playButtonPressed:)];

            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_1] atFrame:CGRectMake(80, screenRect.size.height * 0.5, screenRect.size.width - 100, 100)];
            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_2] atFrame:CGRectMake(80, screenRect.size.height * 0.65, screenRect.size.width - 100, 100)];
            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_3] atFrame:CGRectMake(80, screenRect.size.height * 0.80, screenRect.size.width - 100, 100)];
            
            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, screenRect.size.width - 20, 100)];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.font = [UIFont systemFontOfSize:60];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.textColor =[UIColor whiteColor];
            labelTitle.text = strTitle;
            [self.view addSubview:labelTitle];

            
        }
        else{
            
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            [self addButtonWithNormalImage:@"Play.png" posx:80 posy:screenRect.size.height * 0.3 andSelector:@selector(playButtonPressed:)];
            
            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_1] atFrame:CGRectMake(20, screenRect.size.height * 0.5, screenRect.size.width - 40, 60)];
            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_2] atFrame:CGRectMake(20, screenRect.size.height * 0.65, screenRect.size.width - 40, 60)];
            [self addlabelWithText:[NSString stringWithFormat:@"\u2022 %@",DESCRIPTION_3] atFrame:CGRectMake(20, screenRect.size.height * 0.80, screenRect.size.width - 40, 60)];

            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, screenRect.size.width - 20, 40)];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.font = [UIFont systemFontOfSize:24];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.textColor =[UIColor whiteColor];
            labelTitle.text = strTitle;
            [self.view addSubview:labelTitle];

            
        }
        strAudioName = name;
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath],name]];
        
        NSError *error = nil;
        
        soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        
        if (soundPlayer == nil) {
            NSLog(@"error=%@",[error description]);
        }
        soundPlayer.delegate = self;
        soundPlayer.volume = 1;
        [soundPlayer setNumberOfLoops:0];
        [soundPlayer prepareToPlay];
        
        [[AppGeneralController sharedController] setSoundPlayer:soundPlayer];
        

        UIImage *image = [UIImage imageNamed:@"Back.png"];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:image forState:UIControlStateNormal];
        [backButton setImage:image forState:UIControlEventTouchUpInside];
        [backButton addTarget:self action:@selector(homeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [backButton setFrame:CGRectMake(0, 0, image.size.width * 5, image.size.height * 3)];
        
        [[self view] addSubview:backButton];

    }
    return self;
}

-(void) addButtonWithNormalImage:(NSString*) normalImage posx:(float)x posy:(float) y andSelector:(SEL) sel
{    
    UIImage *image = [UIImage imageNamed:normalImage];
    
    btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlay setImage:image forState:UIControlStateNormal];
    
    if ([normalImage isEqualToString:@"Play.png"]) {
        [btnPlay setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateSelected];
        [[AppGeneralController sharedController] setPlayPauseButton:btnPlay];
    }
    [btnPlay setFrame:CGRectMake(x, y, image.size.width, image.size.height)];
    [btnPlay addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:btnPlay];
}

- (void) actAudio {
    if (bPlay) {
        [btnPlay setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        bPlay = NO;
    }
    else {
        [btnPlay setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        bPlay = YES;
    }
    if (soundPlayer) {
        if ([soundPlayer isPlaying]) {
            [soundPlayer pause];
        }
        else if (![soundPlayer isPlaying]) {
            [soundPlayer play];
        }
    }
}

-(void) playButtonPressed:(UIButton*) sender{
    
    if (arrSessionInfo.count != 2) {
        [self actAudio];
    }
    else {
        if (([strAudioName isEqualToString:@"Session"] && [AppData sharedData].bSession2) ||
            ([strAudioName isEqualToString:@"Cravings"] && [AppData sharedData].bSession3) || [strAudioName isEqualToString:@"Intro"]) {
            [self actAudio];
        }
        else if ([strAudioName isEqualToString:@"Session"] && ![AppData sharedData].bSession2)
        {
            for (NSMutableDictionary* sessionDic in arrSessionInfo) {
                if ([[sessionDic objectForKey:@"session_name"] isEqualToString:@"Session2"] && [[sessionDic objectForKey:@"turn_on"] boolValue] == YES) {
                    
                    NSString* strTitle = [sessionDic objectForKey:@"title"];
                    NSString* strMessage = [sessionDic objectForKey:@"message"];
                    NSString* strButtonName1 = [sessionDic objectForKey:@"button_name1"];
                    NSString* strButtonName2 = [sessionDic objectForKey:@"button_name2"];
                    strLinkAddress = [sessionDic objectForKey:@"link_address"];
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:strTitle message:strMessage delegate:nil cancelButtonTitle:strButtonName1 otherButtonTitles:strButtonName2, nil];
                    
                    alertView.delegate = self;
                    alertView.tag = 7;
                    [alertView show];
                }
                else if ([[sessionDic objectForKey:@"session_name"] isEqualToString:@"Session2"] && [[sessionDic objectForKey:@"turn_on"] boolValue] == NO){
                    [self actAudio];
                }
            }
        }
        else if ([strAudioName isEqualToString:@"Cravings"] && ![AppData sharedData].bSession3)
        {
            for (NSMutableDictionary* sessionDic in arrSessionInfo) {
                if ([[sessionDic objectForKey:@"session_name"] isEqualToString:@"Session3"] && [[sessionDic objectForKey:@"turn_on"] boolValue] == YES) {
                    
                    NSString* strTitle = [sessionDic objectForKey:@"title"];
                    NSString* strMessage = [sessionDic objectForKey:@"message"];
                    NSString* strButtonName1 = [sessionDic objectForKey:@"button_name1"];
                    NSString* strButtonName2 = [sessionDic objectForKey:@"button_name2"];
                    strLinkAddress = [sessionDic objectForKey:@"link_address"];
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:strTitle message:strMessage delegate:nil cancelButtonTitle:strButtonName1 otherButtonTitles:strButtonName2, nil];
                    
                    alertView.delegate = self;
                    alertView.tag = 17;
                    [alertView show];
                }
                else  if ([[sessionDic objectForKey:@"session_name"] isEqualToString:@"Session3"] && [[sessionDic objectForKey:@"turn_on"] boolValue] == NO) {
                    [self actAudio];
                }
            }
        }
    }
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


#pragma mark-UIAlertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==7) {
        if (buttonIndex == 0) {
            bPressLink = YES;
            UIApplication* application = [UIApplication sharedApplication];
            NSURL *URL = [NSURL URLWithString:strLinkAddress];
            if ([application canOpenURL:URL]) {
                [self getLocalDateAndTime];
                [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"PREV_TIME"];
                [AppData sharedData].nState = 2;
                [application openURL:URL];
            }
        }
        else if (buttonIndex == 1) {
            bPressLink = NO;
        }
    }
    else if (alertView.tag == 17) {
        if (buttonIndex == 0) {
            bPressLink = YES;
            UIApplication* application = [UIApplication sharedApplication];
            NSURL *URL = [NSURL URLWithString:strLinkAddress];
            if ([application canOpenURL:URL]) {
                [application openURL:URL];
                [self getLocalDateAndTime];
                [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"PREV_TIME"];
                [AppData sharedData].nState = 3;
            }
        }
        else if (buttonIndex == 1) {
            bPressLink = NO;
        }
    }
}

-(void) homeButtonPressed
{
    
    if (remainingTimeTimer && remainingTimeTimer.isValid) {
        [remainingTimeTimer invalidate];
    }
    
    if (soundPlayer != nil) {
        [soundPlayer stop];
        soundPlayer = nil;
    }
    
    [[AppGeneralController sharedController] videoScreenHomeButtonPressed:nil];
}

-(void) addlabelWithText:(NSString*)text atFrame:(CGRect) frame
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        [label setText:text];
        [label setFont:[UIFont fontWithName:@"Futura" size:30]];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [[self view] addSubview:label];
        
    }else{
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        [label setText:text];
        [label setFont:[UIFont fontWithName:@"Futura" size:15]];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [[self view] addSubview:label];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    SocialScreenViewController *socialScreenViewController = [[SocialScreenViewController alloc] init];
    [navController pushViewController:socialScreenViewController animated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    bPlay = NO;
    
    arrSessionInfo = [AppData sharedData].arrSessionInfo;
    bSession2 = [AppData sharedData].bSession2;
    bSession3 = [AppData sharedData].bSession3;
    bPressLink = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
