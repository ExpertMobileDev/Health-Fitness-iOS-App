//
//  MainScreenViewController.h
//  Everday Workout
//
//  Created by Kashif Tasneem on 05/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView   * tableViewMenu;
    NSMutableArray* arrSessionInfo;

}

//SCALE
extern float kXForIPhone;
extern float kYForIPhone;

extern float SCREEN_HEIGHT;
extern float SCREEN_WIDTH;


@end
