//
//  EmailViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "EmailViewController.h"
#import "Constants.h"
#import "AppGeneralController.h"
#import "MainViewController.h"

@implementation EmailViewController

- (id)init
{
    self = [super init];
    if (self) {
        email = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    if ([MFMailComposeViewController canSendMail]) {
        email = [[MFMailComposeViewController alloc] init];
        [email setMessageBody:SOCIAL_SHARE_MESSAGE isHTML:NO];
        [email setSubject:@"Acohol Addiction"];
        [email setMailComposeDelegate:self];
        [self presentViewController:email animated:YES completion:nil];
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Problem" message:@"Proper Settings for Mail account not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

 -(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSString *title = @"Email";
    NSString *msg = nil;
    
    if (result == MFMailComposeResultFailed)
        msg = @"Unable to send, check your email settings";
    else if (result == MFMailComposeResultSent)
        msg = @"Email Sent Successfully!";
    else if (result == MFMailComposeResultCancelled || result == MFMailComposeResultSaved)
        msg = @"Sending Cancelled";
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController popViewControllerAnimated:YES];
    [navController setNavigationBarHidden:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
