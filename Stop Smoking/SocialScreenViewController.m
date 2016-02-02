//
//  SocialScreenViewController.m
//  Everyday Workout
//
//  Created by Kashif Tasneem on 09/09/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "SocialScreenViewController.h"
#import "Constants.h"
#import "AppGeneralController.h"
#import "AppDelegate.h"

@implementation SocialScreenViewController

- (id)init
{
    self = [super init];
    if (self) {
 
        screenRect = [[UIScreen mainScreen] bounds];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground~ipad.png"]];
            
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:image forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(0, 0, image.size.width * 4, image.size.height * 4)];
            [btn addTarget:[AppGeneralController sharedController] action:@selector(socialScreenHomeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            
            
            //title
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, screenRect.size.width - 100, 140)];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:56];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Share your sucess with Your friends";
            [self.view addSubview:label];

        }else{
            
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
            
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:image forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(0, 0, image.size.width * 4, image.size.height * 4)];
            [btn addTarget:[AppGeneralController sharedController] action:@selector(socialScreenHomeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];

            
            [self addButtonWithNormalImage:@"Share Other Apps.png" posx:280 posy:30 andSelector:@selector(mainScreenInfoButtonPressed:)];
            
            //title
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, screenRect.size.width - 20, 80)];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:28];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor =[UIColor whiteColor];
            label.text = @"Share your sucess with Your friends";
            [self.view addSubview:label];

        }
        
        [self createTableView];
    }
    
    
    return self;
}


-(void) addButtonWithNormalImage:(NSString*) normalImage posx:(float)x posy:(float) y andSelector:(SEL) sel
{
    float scale = [[AppGeneralController sharedController] contentScaleFactor];
    float btnScale;
    
    if (scale == 2) {
        btnScale = scale;
    }
    else {
        btnScale = 2;
    }
    
    UIImage *image = [UIImage imageNamed:normalImage];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(x, y, image.size.width, image.size.height)];
    [btn addTarget:[AppGeneralController sharedController] action:sel forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:btn];
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

#pragma mark TableView

- (void) createTableView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 0;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        x = 50;
        y = 400;
        height = 400;

    }
    else
    {
        x = 10;
        y = 240;
        height = 200;
    }
    
    CGFloat width = screenRect.size.width - x * 2;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        tableView.rowHeight = 120;
    else
        tableView.rowHeight = 60;
    
    
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
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
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *   cellIdentifier = @"cell";
    
    UITableViewCell *   cell = [tableViewMenu dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UIImageView * subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Share.png"]];
        subImageView.center = CGPointMake(tableView.frame.size.width - subImageView.frame.size.width , tableView.rowHeight / 2.0f);
        [cell.contentView addSubview:subImageView];
     }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"FACEBOOK";
            cell.imageView.image = [UIImage imageNamed:@"Facebook.png"];
            
            break;
            
        case 1:
            cell.textLabel.text = @"TWITTER";
            cell.imageView.image = [UIImage imageNamed:@"Twitter.png"];
            
            break;
            
//        case 2:
//            cell.textLabel.text = @"INSTAGRAM";
//            cell.imageView.image = [UIImage imageNamed:@"Instagram.png"];
//
//            break;
//            
        case 2:
            cell.textLabel.text = @"EMAIL";
            cell.imageView.image = [UIImage imageNamed:@"Email.png"];

            break;
            
        default:
            break;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell.textLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight);
        cell.textLabel.font = [UIFont systemFontOfSize:32.0];
    }

    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            
        case 0:
            [[AppGeneralController sharedController] socialScreenFbButtonPressed];
            break;
            
        case 1:
            [[AppGeneralController sharedController] socialScreenTwitterButtonPressed];
            break;
            
//        case 2:
//            [[AppGeneralController sharedController] socialScreenInstagramButtonPressed];
//            break;
            
        case 2:
            [[AppGeneralController sharedController] socialScreenEmailButtonPressed];
            break;
            
        default:
            break;
    }
}

@end
