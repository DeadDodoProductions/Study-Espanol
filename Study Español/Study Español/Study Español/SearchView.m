//
//  SearchView.m
//  Study Español
//
//  Created by Evan on 4/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This subview creates and interface to input search criteria for a search of the Database

#import "SearchView.h"
#import "Home.h"

#import "TextView.h"

#import "WordTypeSection.h"
#import "VerbTypeSection.h"
#import "WordTagSection.h"
#import "ConjugationTypeSection.h"
#import "MiscSection.h"

#import "Button.h"

#import "Utilities.h"
#import "Database.h"

@implementation SearchView
///Initialization
- (id)initWithFrame:(CGRect)frame Home:(Home *)home
{
    if (self = [super initWithFrame:frame])
    {
        [self CreateGUI];
        superHome = home;
    }
    return self;
}


///User Interface
//Create Interface
-(void)CreateGUI
{
    //Getting Device and Orientation Information
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    NSArray *sectionsArray; //used to define the order each section is created and where it is located on screen
    
    WordTypeSection *wordTypeSection = [[WordTypeSection alloc]init];
    VerbTypeSection *verbTypeSection = [[VerbTypeSection alloc]init];
    WordTagSection *wordTagSection = [[WordTagSection alloc]init];
    ConjugationTypeSection *conjugationTypeSection = [[ConjugationTypeSection alloc]init];
    MiscSection *miscSection = [[MiscSection alloc]init];
    tags = [[NSMutableArray alloc]init];
    startRect = self.frame;
    
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"Device: iPad Portrait");
            layout = 0;
            sectionsArray = [[NSArray alloc]initWithObjects:wordTypeSection, wordTagSection, conjugationTypeSection, verbTypeSection, miscSection, nil];
            [self setFrame:CGRectMake(startRect.origin.x, startRect.origin.y + 39, startRect.size.width, startRect.size.height - 87)];
            [self GUIforiPadPortrait:sectionsArray];
        }
        else
        {
            NSLog(@"Device: iPad Landscape");
            layout = 1;
            sectionsArray = [[NSArray alloc]initWithObjects:wordTypeSection, verbTypeSection, conjugationTypeSection, miscSection, wordTagSection, nil];
            [self setFrame:CGRectMake(startRect.origin.x, startRect.origin.y + 44, startRect.size.width, startRect.size.height - 90)];
            [self GUIforiPadLandscape:sectionsArray];
        }
    }
    else
    {
        NSLog(@"Device: iPhone");
        layout = 2;
        sectionsArray = [[NSArray alloc]initWithObjects:wordTypeSection, verbTypeSection, conjugationTypeSection, wordTagSection, miscSection, nil];
        [self GUIforiPhone:sectionsArray];
    }
    NSLog(@"Search View Created");
}
-(void)GUIforiPadPortrait:(NSArray*)sectionArray
{
    NSLog(@"Creating User Interface for iPad Portrait");
    int a = 0;
    for (int i = 0; i < 2; i++)
    {
        NSLog(@"i: %d", i);
        float startPoint = 1;
        for (int j = 0; j < 3; j++)
        {
            NSLog(@"j: %d", j);
            if (i == 0 && j == 2)
            {
                break;
            }
            UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * .5 - 2, 0)];
            
            [sectionArray[a] CreateSearchSection:newView SuperView:self Layout:layout];
            float viewHeight = [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 5;
            
            [newView setFrame:CGRectMake(1 + (i * (self.frame.size.width * .5)), startPoint, self.frame.size.width * .5 - 2, viewHeight)];
            [newView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
            startPoint = newView.frame.origin.y + newView.frame.size.height + 2;
            [self addSubview:newView];
            
            NSLog(@"x: %f y: %f width: %f height: %f", newView.frame.origin.x, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height);
            NSLog(@"New View Created");
            a++;
        }
    }
}
-(void)GUIforiPadLandscape:(NSArray*)sectionArray
{
    NSLog(@"Creating User Interface for iPad Landscape");
    int a = 0;
    for (int i = 0; i < 3; i++)
    {
        float startPoint = 1;
        for (int j = 0; j < 2; j++)
        {
            if (a != 5)
            {
                UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * .3334 - 2, 0)];
            
                [sectionArray[a] CreateSearchSection:newView SuperView:self Layout:layout];
                float viewHeight = [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 5;
            
                [newView setFrame:CGRectMake(1 + ((self.frame.size.width * .3334) * i), startPoint, self.frame.size.width * .3334 - 2, viewHeight)];
                [newView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
                startPoint = newView.frame.origin.y + newView.frame.size.height + 2;
                [self addSubview:newView];
                NSLog(@"x: %f y: %f width: %f height: %f", newView.frame.origin.x, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height);
                NSLog(@"New View Created");
                a++;
            }
        }
    }
}
-(void)GUIforiPhone:(NSArray*)sectionArray
{
    NSLog(@"Creating User Interface for iPhone/iPod");
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    NSLog(@"ScrollView Height: %f", scrollView.frame.size.height);
    float startPoint = 0;
    for (int i = 0; i < 5; i++)
    {
        UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, startPoint, self.frame.size.width, 0)];
        
        [sectionArray[i] CreateSearchSection:newView SuperView:self Layout:layout];
        
        float viewHeight = [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 5;
        [newView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
        [newView setFrame:CGRectMake(0, startPoint, self.frame.size.width, viewHeight)];
        startPoint = newView.frame.origin.y + newView.frame.size.height + 2;
        [scrollView addSubview:newView];
        NSLog(@"x: %f y: %f width: %f height: %f", newView.frame.origin.x, newView.frame.origin.y, newView.frame.size.width, newView.frame.size.height);
        NSLog(@"New View Created");
    }
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, startPoint)];
    NSLog(@"Scroll Content Size: %f", scrollView.contentSize.height);
    [self addSubview:scrollView];
}


///User Interactions
//Actions
//Section objects inherit from NSObject not UIView they cannot be used to find the desired subview more easily
//???I am not sure NewTag and RemoveTag are still needed???
-(void)NewTag
{
    NSLog(@"Adding New Tag");
    UIView *aView;
    //depending on the device and orientation the wanted section could be locatd at 3 different positions within its super view
    switch (layout)
    {
        case 0:
            aView = self.subviews[1];
            break;
            
        case 1:
            aView = self.subviews[4];
            break;
            
        case 2:
            aView = scrollView.subviews[3];
            break;
            
        default:
            break;
    }
    [tags addObject:[[[aView subviews][3] text] lowercaseString]];
    [aView.subviews[6] reloadData];
    NSLog(@"New Tag: %@ -- %@", [[aView subviews][3] text], tags[tags.count - 1]);
    [[aView subviews][3] setText:@""];
    //syncs master tags list with tags
    [Database GetInstance].tags = tags;
}
-(void)RemoveTag
{
    NSLog(@"Removing Tag");
    UIView *aView;
    //depending on the device and orientation the wanted section could be locatd at 3 different positions within its super view
    switch (layout)
    {
        case 0:
            aView = self.subviews[1];
            break;
            
        case 1:
            aView = self.subviews[4];
            break;
            
        case 2:
            aView = scrollView.subviews[3];
            break;
            
        default:
            break;
    }
    UITableView *tagsTable = aView.subviews[6];
    [tagsTable setEditing:!tagsTable.editing];
    //syncs master tags list with tags
    [Database GetInstance].tags = tags;
}
-(void)StepperPressed:(UIStepper*)stepper
{
    NSLog(@"Stepper Pressed: %f", stepper.value);
    [Database GetInstance].wordMax = (int)stepper.value;
    //displays value in a the UILabel next to the stepper
    if (layout == 1)
    {
        [[[self subviews][3] subviews][8] setText:[NSString stringWithFormat:@"Number of Words: %d", [Database GetInstance].wordMax]];
    }
    else
    {
        [[[self subviews][4] subviews][8] setText:[NSString stringWithFormat:@"Number of Words: %d", [Database GetInstance].wordMax]];
    }
}


///UITableView Delagates
//Add Items to Table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //returns the amount of objects to be in the table
    return [tags count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Creating Cell for Object: %ld", (long)indexPath.row);
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", tags[indexPath.row]]];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIView *aView;
        switch (layout)
        {
            case 0:
                aView = self.subviews[1];
                break;
                
            case 1:
                aView = self.subviews[4];
                break;
                
            case 2:
                aView = scrollView.subviews[3];
                break;
                
            default:
                break;
        }
        UITableView *tagsTable = aView.subviews[6];
        [tags removeObjectAtIndex:indexPath.row];
        [tagsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


///TextView Delegate Functions
//When a TextView loses focus this is called, and saves the inputted data
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"TextView %@ Lost Focus", textView);
    switch (layout)
    {
        case 0:
            [Database GetInstance].wordString = [[[self subviews][1] subviews][1] text];
            break;
            
        case 1:
            [Database GetInstance].wordString = [[[self subviews][4] subviews][1] text];
            break;
            
        case 2:
            [Database GetInstance].wordString = [[[self subviews][3] subviews][1] text];
            break;
            
        default:
            break;
    }
    NSLog(@"Word String: %@", [Database GetInstance].wordString);
}

@end
