//
//  ReminderViewController.h
//  Everyday Workout
//
//  Created by Kashif Tasneem on 08/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController<UITabBarDelegate>
{
    BOOL areFirstDaySelected;
    
    UIButton *mon;
    UIButton *tue;
    UIButton *wed;
    UIButton *thu;
    UIButton *fri;
    UIButton *sat;
    UIButton *sun;
}


-(void) buttonTaped:(UIButton*) sender;


//SCALE
extern float kXForIPhone;
extern float kYForIPhone;

extern float SCREEN_HEIGHT;
extern float SCREEN_WIDTH;

@end
