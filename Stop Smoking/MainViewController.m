//
//  MainViewController.m
//  Everday Workout
//
//  Created by Kashif Tasneem on 05/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "MainViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"

static MainViewController *_sharedInstance = nil;

@implementation MainViewController

+(MainViewController*) sharedViewController
{
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

+(id)alloc
{
    @synchronized(self)
    {
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of MainViewController.");
		_sharedInstance = [super alloc];
		return _sharedInstance;
	}
	return nil;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UINavigationController*) getNavController
{
    return navController;
}

-(void) initNavControllerWith:(UIViewController*)controller
{
    navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [navController setNavigationBarHidden:YES];
    
//    float width = [[AppGeneralController sharedController] getScreenWidth];
//    float height = [[AppGeneralController sharedController] getScreenHeight];
//    
//    float scale = [[AppGeneralController sharedController] contentScaleFactor];
//    
//    UIImage * background = nil;
//    if (height == 1136) {
//        background = [[AppGeneralController sharedController] resizeImage:[UIImage imageNamed:@"TodoTopBar.png"] width:width/2 height:height*.08/scale];
//    }
//    else {
//        background = [[AppGeneralController sharedController] resizeImage:[UIImage imageNamed:@"TodoTopBar.png"] width:width/2 height:height*.09/scale];
//    }
//    [navController.navigationBar setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
}

-(void) setNavControllerWith:(UINavigationController*)controller
{
    navController = controller;
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
