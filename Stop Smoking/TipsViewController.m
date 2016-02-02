//
//  TipsViewController.m
//  Stop Smoking
//
//  Created by Kashif Tasneem on 10/10/2012.
//  Copyright (c) 2012 Kashif Tasneem. All rights reserved.
//

#import "TipsViewController.h"
#import "Constants.h"
#import "AppGeneralController.h"


@implementation TipsViewController

- (id)init
{
    self = [super init];
    if (self) {

        CGRect screenRect = [[UIScreen mainScreen] bounds];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground~ipad.png"]];
            
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:image forState:UIControlStateNormal];
            [backButton setImage:image forState:UIControlEventTouchUpInside];
            [backButton addTarget:[AppGeneralController sharedController] action:@selector(tipsEditScreenBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [backButton setFrame:CGRectMake(0, 0, image.size.width * 5, image.size.height * 3)];
            [[self view] addSubview:backButton];
        }
        else
        {
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainBackground.png"]];
            
            [background setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
            [[self view] addSubview:background];
            
            UIImage *image = [UIImage imageNamed:@"Back.png"];
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:image forState:UIControlStateNormal];
            [backButton setImage:image forState:UIControlEventTouchUpInside];
            [backButton addTarget:[AppGeneralController sharedController] action:@selector(tipsEditScreenBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [backButton setFrame:CGRectMake(0, 0, image.size.width * 5, image.size.height * 3)];
            [[self view] addSubview:backButton];
        }
        
        NSString *text = nil;
        
        int random = arc4random() % 8;
        random++;
        
        switch (random) {
            case 1:
                text = TIP_1;
                break;
            case 2:
                text = TIP_2;
                break;
            case 3:
                text = TIP_3;
                break;
            case 4:
                text = TIP_4;
                break;
            case 5:
                text = TIP_5;
                break;
            case 6:
                text = TIP_6;
                break;
            case 7:
                text = TIP_7;
                break;
            case 8:
                text = TIP_8;
                break;
           // case 9:
             //   text = TIP_9;
               // break;
            //case 10:
              //  text = TIP_10;
                //break;
                
            default:
                text = TIP_1;
                break;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
    
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, screenRect.size.width - 160, 500)];
            label.center = CGPointMake(screenRect.size.width / 2, 500);
            [label setText:text];
//            [label setFont:[UIFont fontWithName:@"Futura" size:35]];
            [label setFont:[UIFont systemFontOfSize:32]];

            [label setNumberOfLines:0];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            [[self view] addSubview:label];
            
            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, screenRect.size.width - 20, 120)];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.font = [UIFont systemFontOfSize:80];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.textColor =[UIColor whiteColor];
            labelTitle.text = @"Tips";
            [self.view addSubview:labelTitle];

        }
        else
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, screenRect.size.width - 60, 300)];
            label.center = CGPointMake(screenRect.size.width / 2, 280);
            [label setText:text];
            [label setFont:[UIFont systemFontOfSize:20]];
//            [label setFont:[UIFont fontWithName:@"Futura" size:20]];
            [label setNumberOfLines:0];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor whiteColor]];
            [[self view] addSubview:label];
            
            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, screenRect.size.width - 20, 40)];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.font = [UIFont systemFontOfSize:35];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.textColor =[UIColor whiteColor];
            labelTitle.text = @"Tips";
            [self.view addSubview:labelTitle];

        }
        
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
