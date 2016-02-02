//
//  MainScreenViewController.m
//  Everday Workout
//
//  Created by Kashif Tasneem on 05/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "MainScreenViewController.h"
#import "AppGeneralController.h"
#import "MainViewController.m"
#import "SocialScreenViewController.h"
#import "APIService.h"

float kYForIPhone = 1;
float kXForIPhone = 1;

@implementation MainScreenViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        float step = screenRect.size.width / 8.0f;

        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
            
            [background setFrame:CGRectMake(0, 0, 768, 1024)];
            [[self view] addSubview:background];
            
            UIImageView * bottomBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomBackground.png"]];
            [bottomBackground setFrame:CGRectMake(0, screenRect.size.height - bottomBackground.frame.size.height, screenRect.size.width, bottomBackground.frame.size.height)];
            [[self view] addSubview:bottomBackground];

            float y = bottomBackground.frame.origin.y + bottomBackground.frame.size.height / 2;
            
            [self addButtonWithNormalImage:@"Schedule.png" posx:step posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenReminderButtonPressed:)];
            
            [self addButtonWithNormalImage:@"Objectives.png" posx:step * 4 posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenTodoButtonPressed:)];
            
            [self addButtonWithNormalImage:@"Tips.png" posx:step * 7 posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenTipsButtonPressed:)];
            
            
            //title
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, screenRect.size.width - 20, 70)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:64];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Weight Loss";
            [self.view addSubview:label];
            
            //sub title
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, screenRect.size.width - 20, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:42];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Hypnosis with Dr. E";
            [self.view addSubview:label];

        }
        else
        {
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];

            if (screenRect.size.height == 568) {
                // code for 4-inch screen
                [background setFrame:CGRectMake(0, 0, 320, 568)];
                [[self view] addSubview:background];

                //title
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, screenRect.size.width - 20, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:30];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor =[UIColor whiteColor];
                label.text = @"Weight Loss";
                [self.view addSubview:label];
                
                //sub title
                label = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, screenRect.size.width - 20, 30)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:20];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor =[UIColor whiteColor];
                label.text = @"Hypnosis with Dr. E";
                [self.view addSubview:label];

            }
            else
            {
                // code for 3.5-inch screen
                [background setFrame:CGRectMake(0, 0, 320, 480)];
                [[self view] addSubview:background];
                
                //title
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, screenRect.size.width - 20, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:30];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor =[UIColor whiteColor];
                label.text = @"Weight Loss";
                [self.view addSubview:label];
                
                //sub title
                label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, screenRect.size.width - 20, 30)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:20];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor =[UIColor whiteColor];
                label.text = @"Hypnosis with Dr. E";
                [self.view addSubview:label];

            }
            
            UIImageView * bottomBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomBackground.png"]];
            [bottomBackground setFrame:CGRectMake(0, screenRect.size.height - bottomBackground.frame.size.height, screenRect.size.width, bottomBackground.frame.size.height)];
            [[self view] addSubview:bottomBackground];
             
            float y = bottomBackground.frame.origin.y + bottomBackground.frame.size.height / 2;
            
            [self addButtonWithNormalImage:@"Schedule.png" posx:step posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenReminderButtonPressed:)];
            
            [self addButtonWithNormalImage:@"Objectives.png" posx:step * 4 posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenTodoButtonPressed:)];
            
            [self addButtonWithNormalImage:@"Tips.png" posx:step * 7 posy:y width:step * 2 height:bottomBackground.frame.size.height andSelector:@selector(mainScreenTipsButtonPressed:)];
                
        }
        
    }
    
    [self createTableView];

    return self;
}

-(void) addButtonWithNormalImage:(NSString*) normalImage posx:(float)x posy:(float) y width:(float)width height:(float) height andSelector:(SEL) sel
{
    UIImage *image = [UIImage imageNamed:normalImage];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, width, height)];
    btn.center = CGPointMake(x, y);
    [btn addTarget:[AppGeneralController sharedController] action:sel forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:btn];

}

- (void) getAllSessionInfo {
    NSString* strAppName = @"Weight Loss";
    [APIService makeApiCallWithMethodUrl:@"get-sessions" andRequestType:RequestTypePost andPathParams:nil andQueryParams:@{@"app_name":strAppName} resultCallback:^(NSObject *result) {
        NSLog(@"%@", result);
        NSDictionary *jsonResult = (NSDictionary *)result;
        BOOL bResult = [[jsonResult objectForKey:@"error"] boolValue];
        if (bResult == NO) {
            NSLog(@"post ok!");
            arrSessionInfo = [[jsonResult objectForKey:@"sessions"] mutableCopy];
            [AppData sharedData].arrSessionInfo = arrSessionInfo;
        }
    } faultCallback:^(NSError *fault) {
    }];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllSessionInfo];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBar Background.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

#pragma mark TableView

- (void) createTableView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 0;

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        x = 30;
        y = 350;
        height = 440;
    }
    
    else
    {
        x = 10;
        height = 240;
        
        if (screenRect.size.height == 568)
            y = 220;
        else
            y = 170;
    }
    
    CGFloat width = screenRect.size.width - x * 2;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        tableView.rowHeight = 110;
    else
        tableView.rowHeight = 60;

//    tableView.sectionFooterHeight = 22;
//    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.backgroundColor = [UIColor clearColor];
    
    tableViewMenu = tableView;
    
    [self.view addSubview:tableView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *   cellIdentifier = @"cell";
    
    UITableViewCell *   cell = [tableViewMenu dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
        UIImageView * subImageView;
        
        if (indexPath.row == 3)
            subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Share.png"]];
        else
            subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SubPlay.png"]];

        subImageView.center = CGPointMake(tableView.frame.size.width - subImageView.frame.size.width , tableView.rowHeight / 2.0f);
        [cell.contentView addSubview:subImageView];
    }

    NSString * strName;
    
    
    switch (indexPath.row) {
        case 0:
            strName = @"INTRODUCTION";
            
            break;
            
        case 1:
            strName = @"WEIGHT LOSS";
            break;
            
        case 2:
            strName = @"CRAVINGS";
            break;
            
        case 3:
            strName = @"SHARE";
            break;
            
        default:
            break;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell.textLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight);
        cell.textLabel.font = [UIFont systemFontOfSize:32.0];
    }

    cell.textLabel.text = strName;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [[AppGeneralController sharedController] mainScreenIntroButtonPressed];
            break;

        case 1:
            [[AppGeneralController sharedController] mainScreenMainButtonPressed];
            break;
            
        case 2:
            [[AppGeneralController sharedController] mainScreenCarvingsButtonPressed];
            break;
            
        case 3:
        {
            UINavigationController *navController = [[MainViewController sharedViewController] getNavController];
            SocialScreenViewController *socialScreenViewController = [[SocialScreenViewController alloc] init];
            [navController pushViewController:socialScreenViewController animated:YES];
            [[MainViewController sharedViewController] setNavControllerWith:navController];
            break;
        }
        default:
            break;
    }

    
//    BusinessProfileViewController * profile = [[self storyboard] instantiateViewControllerWithIdentifier:@"ID_Phone_BusinessProfileViewController"];
//    
//    profile.dictSelectBusiness = [dataArray objectAtIndex:indexPath.row];
//    
//    [self.navigationController pushViewController:profile animated:YES];
}

@end
