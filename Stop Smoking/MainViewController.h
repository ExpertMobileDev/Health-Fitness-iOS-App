//
//  MainViewController.h
//  Everday Workout
//
//  Created by Kashif Tasneem on 05/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    UINavigationController *navController;
}

+(MainViewController*) sharedViewController;

-(UINavigationController*) getNavController;
-(void) initNavControllerWith:(UIViewController*)controller;
-(void) setNavControllerWith:(UINavigationController*)controller;
@end
