//
//  FacebookViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "FacebookViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "MainViewController.h"

@implementation FacebookViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    @try {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebook setInitialText:SOCIAL_SHARE_MESSAGE];
            [self presentViewController:facebook animated:YES completion:nil];
            
            facebook.completionHandler = ^(SLComposeViewControllerResult result) {
                NSString *title = @"Share";
                NSString *msg = nil;
                
                if (result == SLComposeViewControllerResultCancelled)
                    msg = @"Unable to share, check your facebook settings";
                else if (result == SLComposeViewControllerResultDone)
                    msg = @"Facebook was successful";
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
                [navController popViewControllerAnimated:YES];
                [navController setNavigationBarHidden:YES];
                [[MainViewController sharedViewController] setNavControllerWith:navController];
            };
        }
        else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Problem" message:@"Proper Settings for Facebook account not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
            [navController popViewControllerAnimated:YES];
            [navController setNavigationBarHidden:YES];
            [[MainViewController sharedViewController] setNavControllerWith:navController];

        }
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
