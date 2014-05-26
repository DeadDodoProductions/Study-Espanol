//
//  BaseView.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"
#import "Button.h"
#import "Switch.h"
#import "TextView.h"
#import "Word.h"
#import "Conjugation.h"
#import "Tag.h"
#import "ViewWord.h"
#import "ConjugationView.h"
#import "ViewWord.h"
#import "Home.h"
#import "Database.h"

@interface BaseView ()

@end

@implementation BaseView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"New View");
    [super viewDidLoad];
    
    screen = [UIScreen mainScreen];
    screenSize = [self FindScreenSize];
    NSLog(@"Screen Size: width: %.0f height: %.0f", screenSize.width, screenSize.height);
    orientation = [self FindOrientation];
    [self SetContentViews];
    NSLog(@"Translation: %@", [[Database GetInstance] translate]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardInView:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardOffView:) name:UIKeyboardDidHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//finds the screens orientation
-(UIInterfaceOrientation)FindOrientation
{
    NSLog(@"Orientation: %d", [UIApplication sharedApplication].statusBarOrientation);
    //change return type to return orientation
    return [UIApplication sharedApplication].statusBarOrientation;
}

//finds the size of the screen
-(CGSize)FindScreenSize
{
    //find the size of the screen here
    return CGSizeMake(screen.bounds.size.width, screen.bounds.size.height);
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    orientation = [self FindOrientation];
    [self SetContentViews];
}

-(BOOL)shouldAutorotate
{
    return true;
}

-(void)SetContentViews
{
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"Landscape");
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 20, screenSize.height, 30)];
        content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenSize.height, screenSize.width - 50)];
    }
    else
    {
        NSLog(@"Portrait");
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 20, screenSize.width, 30)];
        content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenSize.width, screenSize.height - 50)];
    }
    NSLog(@"Header Size: x: %.0f y:%.0f width: %.0f height: %.0f", header.frame.origin.x, header.frame.origin.y, header.frame.size.width, header.frame.size.height);
    NSLog(@"Content Size: x: %.0f y:%.0f width: %.0f height: %.0f", content.frame.origin.x, content.frame.origin.y, content.frame.size.width, content.frame.size.height);
    contentWidth = content.frame.size.width;
    contentHeight = content.frame.size.height;
    
    [header setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    homeButton = [[Button alloc]initWithFrame:CGRectMake(5, 5, 50, 20)];
    [homeButton setTitle:@"Casa" forState:UIControlStateNormal];
    [homeButton setTag:0];
    [homeButton addTarget:self action:@selector(HeaderButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:homeButton];
    
    helpButton = [[Button alloc]initWithFrame:CGRectMake(header.frame.size.width - 25, 5, 20, 20)];
    //Set ? image here for help Button
    //[helpButton setImage:<#(UIImage *)#> forState:UIControlStateNormal];
    [helpButton setTag:1];
    [header addSubview:helpButton];
    
    actionButton1 = [[Button alloc]initWithFrame:CGRectMake(header.frame.size.width - 60, 5, 30, 20)];
    [actionButton1 setTag:2];
    [actionButton1 addTarget:self action:@selector(ActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton1 setHidden:true];
    [header addSubview:actionButton1];
    
    actionButton2 = [[Button alloc]initWithFrame:CGRectMake(header.frame.size.width - 95, 5, 30, 20)];
    [actionButton2 setTag:3];
    [actionButton2 addTarget:self action:@selector(ActionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton2 setHidden:true];
    [header addSubview:actionButton2];
    
    [content setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [self.view addSubview:header];
    //[self SetGrid];
    [self.view addSubview:content];
}

-(void)ActionButtonPressed:(Button*)button{}
-(void)HeaderButtonPressed:(Button*)button
{
    Home *home;
    switch (button.tag)
    {
        case 0:
            NSLog(@"Home Button Pressed");
            [actionButton1 setHidden:true];
            [actionButton2 setHidden:true];
            [[Database GetInstance] setActiveWord:nil];
            home = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
            [self presentViewController:home animated:false completion:nil];
            break;
            
        case 1:
            NSLog(@"Help Button Pressed");
            break;
            
        default:
            break;
    }
}

-(void)SetActionButton:(int)button Title:(NSString*)title
{
    if (button == 1)
    {
        [actionButton1 setTitle:title forState:UIControlStateNormal];
        [actionButton1 setHidden:false];
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:20.0f] forKey:NSFontAttributeName]];
        [actionButton1 setFrame:CGRectMake(helpButton.frame.origin.x - (size.width + 5), actionButton1.frame.origin.y, size.width, actionButton1.frame.size.height)];
    }
    else
    {
        [actionButton2 setTitle:title forState:UIControlStateNormal];
        [actionButton2 setHidden:false];
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:20.0f] forKey:NSFontAttributeName]];
        [actionButton2 setFrame:CGRectMake(actionButton1.frame.origin.x - (size.width + 5), actionButton2.frame.origin.y, size.width, actionButton2.frame.size.height)];
    }
}

-(void)KeyboardInView:(NSNotification*)aNote
{
    NSLog(@"Keyboard in View");
    NSDictionary *info = [aNote userInfo];
    //keyboard rect does not take into consideration the landscape view
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    //this is the location of the textfield
    CGPoint aLocation; //still needs defined
    //this creates an adjusted rect of the content view to take into consideration the position of the keyboard
    CGRect aRect = CGRectMake(0, 0, content.frame.size.width, content.frame.size.height - keyboardRect.size.width);
    //determines if the textfield is hidden by the keyboard then moves the content up
    if (!CGRectContainsPoint(aRect, aLocation))
    {
        CGPoint scrollPoint = CGPointMake(0, aLocation.y - aRect.size.height);
        [content setContentOffset:scrollPoint animated:true];
    }
}

-(void)KeyboardOffView:(NSNotification*)aNote
{
    NSLog(@"Keyboard Off View");
    [content setContentOffset:CGPointZero animated:true];
}

-(void)SetGrid
{
    grid = [[UIView alloc]initWithFrame:content.frame];
    
    for (int i = 0; i < contentWidth / 5; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + (i * 5), 0, 1, contentHeight)];
        [newLabel setBackgroundColor:[UIColor greenColor]];
        [grid addSubview:newLabel];
    }
    
    for (int i = 0; i < contentHeight / 5; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 +(i * 5), contentWidth, 1)];
        [newLabel setBackgroundColor:[UIColor greenColor]];
        [grid addSubview:newLabel];
    }
    
    for (int i = 0; i < 3; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(contentWidth * (.25 * (i + 1)), 0, 1, contentHeight)];
        [newLabel setBackgroundColor:[UIColor blueColor]];
        [grid addSubview:newLabel];
        
        UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, contentHeight * (.25 * (i + 1)), contentWidth, 1)];
        [aLabel setBackgroundColor:[UIColor blueColor]];
        [grid addSubview:aLabel];
    }
    
    for (int i = 0; i < 2; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(contentWidth * (.3334 * (i + 1)), 0, 1, contentHeight)];
        [newLabel setBackgroundColor:[UIColor redColor]];
        [grid addSubview:newLabel];
        
        UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, contentHeight * (.3334 * (i + 1)), contentWidth, 1)];
        [aLabel setBackgroundColor:[UIColor redColor]];
        [grid addSubview:aLabel];
    }
    
    [self.view addSubview:grid];
}

@end
