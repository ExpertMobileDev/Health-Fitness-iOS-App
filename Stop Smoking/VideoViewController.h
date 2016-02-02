//
//  VideoViewController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoViewController : UIViewController<AVAudioPlayerDelegate>
{
    NSTimer *       remainingTimeTimer;
    AVAudioPlayer * soundPlayer;
    UIButton* btnPlay;
    
    BOOL bPlay;
    
    BOOL bSession2, bSession3;
    NSString* strAudioName;
    NSDate* currentDate;
    NSMutableArray* arrSessionInfo;
    NSString* strLinkAddress;
    BOOL bPressLink;

}

- (id)initWithAudioName:(NSString*) name title:(NSString * )strTitle;

-(void) addButtonWithNormalImage:(NSString*) normalImage posx:(float)x posy:(float) y andSelector:(SEL) sel;
-(void) addlabelWithText:(NSString*)text atFrame:(CGRect) frame;
-(void) playButtonPressed:(UIButton*) sender;
-(void) homeButtonPressed;

//SCALE
extern float kXForIPhone;
extern float kYForIPhone;

extern float SCREEN_HEIGHT;
extern float SCREEN_WIDTH;

@end
