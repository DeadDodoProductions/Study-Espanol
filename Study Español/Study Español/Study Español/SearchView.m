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

#import "WordTypeSectionView.h"
#import "VerbTypeSectionView.h"
#import "WordTagSectionView.h"
#import "ConjugationTypeSectionView.h"
#import "MiscSectionView.h"

#import "Button.h"

#import "Utilities.h"
#import "Database.h"

@implementation SearchView
///Initialization
- (id)initWithFrame:(CGRect)frame Home:(Home *)home
{
    if (self = [super initWithFrame:frame])
    {
        allTags = [[Database GetInstance] SearchForTags];
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

    [[Database GetInstance] setTranslate:[NSNumber numberWithInt:0]];
    tags = [[NSMutableArray alloc]init];
    startRect = self.frame;
    
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"Device: iPad Portrait");
            layout = 0;
            [self setFrame:CGRectMake(startRect.origin.x, startRect.origin.y + 39, startRect.size.width, startRect.size.height - 87)];
            [self GUIforiPadPortrait:sectionsArray];
        }
        else
        {
            NSLog(@"Device: iPad Landscape");
            layout = 1;
            [self setFrame:CGRectMake(startRect.origin.x, startRect.origin.y + 44, startRect.size.width, startRect.size.height - 90)];
            [self GUIforiPadLandscape:sectionsArray];
        }
    }
    else
    {
        NSLog(@"Device: iPhone");
        layout = 2;
        [self GUIforiPhone:sectionsArray];
    }
    NSLog(@"Search View Created");
}
-(void)GUIforiPadPortrait:(NSArray*)sectionArray
{
    //sectionsArray = [[NSArray alloc]initWithObjects:wordTypeSection, wordTagSection, conjugationTypeSection, verbTypeSection, miscSection, nil];
    NSLog(@"Creating User Interface for iPad Portrait");
    int startingY = 2;
    
    WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, (self.frame.size.width - 4) * .5 - 1, 0) ParentView:self Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    wordTagSectionView = [[WordTagSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, (self.frame.size.width - 4) * .5 - 1, self.frame.size.height - wordTypeSectionView.frame.size.height - 6) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTagSectionView];
    startingY = 2;
    
    ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initSearchWithFrame:CGRectMake(1 + (self.frame.size.width * .5), startingY, (self.frame.size.width - 4) * .5 - 1, 0) ParentView:self Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:conjugationTypeSectionView];
    startingY = conjugationTypeSectionView.frame.origin.y + conjugationTypeSectionView.frame.size.height + 2;
    
    VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initSearchWithFrame:CGRectMake(1 + (self.frame.size.width * .5), startingY, (self.frame.size.width - 4) * .5 - 1, 0) ParentView:self Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    MiscSectionView *miscSectionView = [[MiscSectionView alloc]initSearchWithFrame:CGRectMake(2 + (self.frame.size.width * .5), startingY, (self.frame.size.width - 4) * .5, 0) ParentView:self Layout:layout];
    [miscSectionView setFrame:CGRectMake(miscSectionView.frame.origin.x - 1, miscSectionView.frame.origin.y, miscSectionView.frame.size.width - 1, miscSectionView.frame.size.height)];
    [miscSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:miscSectionView];
}
-(void)GUIforiPadLandscape:(NSArray*)sectionArray
{
    NSLog(@"Creating User Interface for iPad Landscape");
    int startingY = 2;
    
    WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, (self.frame.size.width - 4) * .334, 0) ParentView:self Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, (self.frame.size.width - 4) * .334, 0) ParentView:self Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:verbTypeSectionView];
    startingY = 2;
    
    ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initSearchWithFrame:CGRectMake(2 + (self.frame.size.width * .334), startingY, (self.frame.size.width - 4) * .334, 0) ParentView:self Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:conjugationTypeSectionView];
    startingY = conjugationTypeSectionView.frame.origin.y + conjugationTypeSectionView.frame.size.height + 2;
    
    MiscSectionView *miscSectionView = [[MiscSectionView alloc]initSearchWithFrame:CGRectMake(2 + (self.frame.size.width * .334), startingY, (self.frame.size.width - 4) * .334, 0) ParentView:self Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:miscSectionView];
    startingY = 2;
    
    wordTagSectionView = [[WordTagSectionView alloc]initSearchWithFrame:CGRectMake(3 + (self.frame.size.width * .667), startingY, ((self.frame.size.width - 4) * .334) - 4, self.frame.size.height - 4) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTagSectionView];
}
-(void)GUIforiPhone:(NSArray*)sectionArray
{
    NSLog(@"Creating User Interface for iPhone/iPod");
    //scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setDelegate:self];
    NSLog(@"ScrollView Height: %f", self.frame.size.height);
    int startingY = 2;
    
    WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, self.frame.size.width - 4, 0) ParentView:self Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, self.frame.size.width - 4, 0) ParentView:self Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, self.frame.size.width - 4, 0) ParentView:self Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:conjugationTypeSectionView];
    startingY = conjugationTypeSectionView.frame.origin.y + conjugationTypeSectionView.frame.size.height + 2;
    
    wordTagSectionView = [[WordTagSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, self.frame.size.width - 4, 375) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:wordTagSectionView];
    startingY = wordTagSectionView.frame.origin.y + wordTagSectionView.frame.size.height + 2;
    
    MiscSectionView *miscSectionView = [[MiscSectionView alloc]initSearchWithFrame:CGRectMake(2, startingY, self.frame.size.width - 4, 0) ParentView:self Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:miscSectionView];
    startingY = miscSectionView.frame.origin.y + miscSectionView.frame.size.height + 2;
    
    [self setContentSize:CGSizeMake(self.frame.size.width, startingY)];
    NSLog(@"Scroll Content Size: %f", self.contentSize.height);
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
            aView = self.subviews[3];
            break;
            
        default:
            break;
    }
    if (![[[aView subviews][3] text]  isEqual: @""])
    {
        [tags addObject:[[[aView subviews][3] text] lowercaseString]];
        [aView.subviews[6] reloadData];
        NSLog(@"New Tag: %@ -- %@", [[aView subviews][3] text], tags[tags.count - 1]);
        [[aView subviews][3] setText:@""];
        //syncs master tags list with tags
        [Database GetInstance].tags = tags;
    }
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
            aView = self.subviews[3];
            break;
            
        default:
            break;
    }
    UITableView *tagsTable = aView.subviews[7];
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
                aView = self.subviews[3];
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
    [Database GetInstance].wordString = textView.text;
    NSLog(@"Word String: %@", [Database GetInstance].wordString);
}

///UIScrollView Delegate Functions
//resets the TruePosition of the WordTagSectionView so Content scrolls correctly when the keyboard is on screen
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [wordTagSectionView setTruePosition:CGPointMake(wordTagSectionView.frame.origin.x, wordTagSectionView.frame.origin.y - scrollView.contentOffset.y + 10)];
}
@end
