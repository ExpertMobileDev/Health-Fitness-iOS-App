//
//  SocialScreenViewController.h
//  Everyday Workout
//
//  Created by Kashif Tasneem on 09/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialScreenViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    CGRect          screenRect;
    UITableView   * tableViewMenu;
}

-(void) addButtonWithNormalImage:(NSString*) normalImage posx:(float)x posy:(float) y andSelector:(SEL) sel;

@end
