//
//  ToDoViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 07/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "ToDoViewController.h"
#import "Constants.h"
#import "AppGeneralController.h"
#import "TodoEditViewController.h"
#import "MainViewController.h"
#import "DatabaseManager.h"


@implementation UINavigationBar (customNav)


- (CGSize)sizeThatFits:(CGSize)size {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGSize newSize = CGSizeMake(768, 106);
        return newSize;
    }
    else{
    
        CGSize newSize = CGSizeMake(320,45);
        return newSize;
    }
}
-(void)layoutSubviews {
  
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    
        // Make items on navigation bar vertically centered.
        int i = 0;
        
        for (UIView  * view in self.subviews) {
            
            NSLog(@"%i. %@", i, [view description]);
            
            i++;
            
            if (i == 0)
                continue;
            
            float centerY = self.bounds.size.height / 2.0f;
            view.center = CGPointMake(view.center.x, centerY);
        }
    }
    else
    {
        // Make items on navigation bar vertically centered.
        int i = 0;
        for (UIView *view in self.subviews) {
            NSLog(@"%i. %@", i, [view description]);
            i++;
            if (i == 0)
                continue;
            float centerY = self.bounds.size.height / 5.0f;
            CGPoint center = view.center;
            center.y = centerY;
        }
    }
}

@end

@implementation ToDoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.title = @"Objectives";
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 110)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:32.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text=self.title;
            self.navigationItem.titleView = label;
//            self.navigationItem.titleView.center = CGPointMake(768 / 2, 110 / 2);
            
            UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(addButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
            [button setFrame:CGRectMake(0, 0, 100, 100)];
            [button setTitle:@"Add" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:32.0];

            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            
            UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
            self.navigationItem.rightBarButtonItem = barButton;

       }
        else
        {
            self.title = @"Objectives";

            addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addButtonPressed:)];
            self.navigationItem.rightBarButtonItem = addButton;
        }
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back.png"] style:UIBarButtonItemStyleBordered target:[AppGeneralController sharedController] action:@selector(toDoBackButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = backBtn;
    }
    return self;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImageView * sectionHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    sectionHeaderView.image = [UIImage imageNamed:@"TopBackground.png"];
    return sectionHeaderView;
}


-(void) addButtonPressed:(UIBarButtonItem*) sender
{
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    TodoEditViewController *todoEditViewController = [[TodoEditViewController alloc] init];
    [navController pushViewController:todoEditViewController animated:NO];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //CGFloat navBarHeight = 33.0f;
    //CGRect frame = CGRectMake(0.0f, 0.0f, 768.0f, navBarHeight);
    //[self.navigationController.navigationBar setFrame:frame];
    
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.tableView.rowHeight = 130;
    else
        self.tableView.rowHeight = 70;
    
  
    //  CGRect frame = CGRectMake(tableView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.contentSize.height);
    //tblView.frame = frame;
    //[tblView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self tableView] reloadData];
    
    
   // CGRect frame = CGRectMake(0,0,30,30);
   // [[UITableView frame] frame];
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
    if (todos) {
        [todos removeAllObjects];
        todos = nil;
    }
    todos = [[NSMutableDictionary alloc] init];
    
    if (indexes) {
        [indexes removeAllObjects];
        indexes = nil;
    }
    
    indexes = [[NSMutableArray alloc] init];
    
    int index = 1;
    for (int i = 1; i <= [[DatabaseManager sharedManager] getTotalNumberOfRecords]; i++) {
        NSString *name = (NSString*) [[DatabaseManager sharedManager] getNameForId:i];
        if (name != nil) {
            [todos setObject:name forKey:[NSString stringWithFormat:@"%d",index]];
            [indexes addObject:[NSNumber numberWithInt:i]];
            index++;
        }
        
    }
    
    return [todos count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 50;
    
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 130;

    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
     
        UIImage *image = [UIImage imageNamed:@"CheckBox.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, image.size.width * 2.5, image.size.height * 2.5);
        button.frame = frame;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateSelected];
        
        BOOL isCompleted = [[DatabaseManager sharedManager] getIsCompletedForName:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        
        if (isCompleted) {
            button.selected = YES;
        }
        else {
            button.selected = NO;
        }
        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;
    
        [[cell textLabel] setText:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        [[cell textLabel] setNumberOfLines:3];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"CheckBox.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, image.size.width * 1.5, image.size.height * 1.5);
        button.frame = frame;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"CheckedBox.png"] forState:UIControlStateSelected];
        
        BOOL isCompleted = [[DatabaseManager sharedManager] getIsCompletedForName:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        
        if (isCompleted) {
            button.selected = YES;
        }
        else {
            button.selected = NO;
        }
        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;

        [[cell textLabel] setText:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        [[cell textLabel] setNumberOfLines:3];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];

    }
    
    return cell;
}

- (void)checkButtonTapped:(UIButton*)sender event:(id)event
{
    sender.selected = !sender.selected;
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil)
    {
        BOOL isCompleted = [[DatabaseManager sharedManager] getIsCompletedForName:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        if (isCompleted) {
            [[DatabaseManager sharedManager] setNotIsCompletedForName:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        }
        else {
            [[DatabaseManager sharedManager] setIsCompletedForName:[todos valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        }
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        [[DatabaseManager sharedManager] deleteTodoHavingName:[todos objectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]]];
        [todos removeObjectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [[indexes objectAtIndex:indexPath.row] intValue];
    UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
    TodoEditViewController *todoEditViewController = [[TodoEditViewController alloc] initWithId:index];
    [navController pushViewController:todoEditViewController animated:NO];
    [[MainViewController sharedViewController] setNavControllerWith:navController];
}

@end
