//
//  ToDoViewController.h
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationBar (myNave)

- (CGSize)changeHeight:(CGSize)size;

@end


@interface ToDoViewController : UITableViewController
{
    NSMutableDictionary *todos;
    UIBarButtonItem *addButton;
    NSMutableArray *indexes;
}

-(void) addButtonPressed:(UIBarButtonItem*) sender;
- (void)checkButtonTapped:(UIButton*)sender event:(id)event;

@end
