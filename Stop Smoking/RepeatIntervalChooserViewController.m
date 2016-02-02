//
//  RepeatIntervalChooserViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "RepeatIntervalChooserViewController.h"
#import "AppGeneralController.h"
#import "Constants.h"
#import "MainViewController.h"

@implementation RepeatIntervalChooserViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        items = [[NSMutableArray alloc] init];
        [items addObject:@"None"];
        [items addObject:@"Every Day"];
        [items addObject:@"Every Week"];
        [items addObject:@"Every 2 Weeks"];
        [items addObject:@"Every Month"];
        [items addObject:@"Every Year"];
        
        self.navigationItem.hidesBackButton = YES;
        
        backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
        self.navigationItem.leftBarButtonItem = backBtn;
        
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        
        checkMarksArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [items count]; i++) {
            [checkMarksArray addObject:@"NO"];
        }
        
        if ([[AppGeneralController sharedController] loadFromUserDefaults:@"CheckedIndex"] != nil) {
            int index = [[[AppGeneralController sharedController] loadFromUserDefaults:@"CheckedIndex"] intValue];
            [checkMarksArray replaceObjectAtIndex:index withObject:@"YES"];
        }
        else {
            [checkMarksArray replaceObjectAtIndex:0 withObject:@"YES"];
        }
    }
    return self;
}

-(void) doneButtonPressed:(UIBarButtonItem*) sender
{
    int checkedIndex = -1;
    for (int i = 0; i < [checkMarksArray count]; i++) {
        if ([[checkMarksArray objectAtIndex:i] isEqualToString:@"YES"]) {
            checkedIndex = i;
            break;
        }
    }
    
    [[AppGeneralController sharedController] saveToUserDefaults:[NSString stringWithFormat:@"%d",checkedIndex] havingKey:@"CheckedIndex"];
    
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:NO];
    [navController popViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

-(void) backButtonPressed:(UIBarButtonItem*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    [navController setNavigationBarHidden:NO];
    [navController popViewControllerAnimated:YES];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        
    }
    [[cell textLabel] setText:[items objectAtIndex:indexPath.row]];
    if ([[checkMarksArray objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    for (int i = 0; i < [checkMarksArray count]; i++) {
        [checkMarksArray replaceObjectAtIndex:i withObject:@"NO"];
    }
    [checkMarksArray replaceObjectAtIndex:indexPath.row withObject:@"YES"];
    [self performSelector:@selector(reloadData:) withObject:tableView afterDelay:.001];
    
}

-(void) reloadData:(UITableView*) tableView
{
    [tableView reloadData];
}

@end
