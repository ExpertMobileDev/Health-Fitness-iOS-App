//
//  EmailViewController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface EmailViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *email;
}
@end
