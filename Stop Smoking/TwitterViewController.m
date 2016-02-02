//
//  TwitterViewController.m
//  Everyday Workout
//
//  Created by Kashif Tasneem on 18/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "TwitterViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "MainViewController.h"

@implementation TwitterViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self view] setBackgroundColor:[UIColor blackColor]];
    @try {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitter setInitialText:SOCIAL_SHARE_MESSAGE];
            [self presentViewController:twitter animated:YES completion:nil];
            
            twitter.completionHandler = ^(SLComposeViewControllerResult result) {
                NSString *title = @"Tweet";
                NSString *msg = nil;
                
                if (result == SLComposeViewControllerResultCancelled)
                    msg = @"Unable to tweet, check your twitter settings";
                else if (result == SLComposeViewControllerResultDone)
                     msg = @"Tweet was successful";;
                
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
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Problem" message:@"Proper Settings for Twitter account not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
