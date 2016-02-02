//
//  RepeatIntervalChooserViewController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepeatIntervalChooserViewController : UITableViewController
{
    NSMutableArray *items;
    NSMutableArray *checkMarksArray;
    UIBarButtonItem *doneButton;
    UIBarButtonItem *backBtn;
}
-(void) doneButtonPressed:(UIBarButtonItem*) sender;
-(void) backButtonPressed:(UIBarButtonItem*) sender;
@end
