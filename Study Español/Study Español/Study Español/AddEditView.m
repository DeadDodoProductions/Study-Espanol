//
//  AddEditView.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//  Displays and controls the AddEdit view
//  Allows the user to add new words or edit previous words

#import "AddEditView.h"

#import "TextView.h"
#import "ConjugationView.h"

#import "WordTypeSection.h"
#import "VerbTypeSection.h"
#import "WordTagSection.h"
#import "ConjugationTypeSection.h"
#import "WordSection.h"
#import "MiscSection.h"

#import "Word.h"
#import "Tag.h"
#import "Conjugation.h"

#import "Button.h"

#import "Database.h"
#import "Utilities.h"

@interface AddEditView ()

@end

@implementation AddEditView
@synthesize editingWord;

//Initializtion
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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Add/Edit View Loading...");
    tags = [[NSMutableArray alloc] init];
    [self SetActionButton:1 Title:@"Save"];
    [self SetActionButton:2 Title:@"Clear"];
    [self CreateGUI];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///User Interface Methods
//Create User Interfaces
-(void)CreateGUI
{
    NSLog(@"Creating GUI for Add/Edit View");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    WordTypeSection *wordTypeSection = [[WordTypeSection alloc]init];
    VerbTypeSection *verbTypeSection = [[VerbTypeSection alloc]init];
    WordTagSection *tagSection = [[WordTagSection alloc]init];
    WordSection *wordSection = [[WordSection alloc]init];
    MiscSection *genderSection = [[MiscSection alloc]init];
    ConjugationTypeSection *conjugationSection = [[ConjugationTypeSection alloc]init];
    NSArray *sectionsArray;
    
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            layout = 0;
            sectionsArray = [[NSArray alloc]initWithObjects:wordSection, tagSection, wordTypeSection, verbTypeSection, genderSection, conjugationSection, nil];
            [self GUIforiPadPortrait:sectionsArray];
        }
        else
        {
            NSLog(@"iPad Landscape");
            layout = 1;
            sectionsArray = [[NSArray alloc]initWithObjects:wordSection, tagSection, wordTypeSection, verbTypeSection, genderSection, conjugationSection, nil];
            [self GUIforiPadLandscape:sectionsArray];
        }
    }
    else
    {
        NSLog(@"iPhone");
        layout = 2;
        sectionsArray = [[NSArray alloc]initWithObjects:wordSection, tagSection, wordTypeSection, verbTypeSection, genderSection, conjugationSection, nil];
        [self GUIforiPhone:sectionsArray];
    }
    
    if ([[Database GetInstance] activeWord] != nil)
    {
        for (Tag *a in [[[Database GetInstance]activeWord]tags])
        {
            [tags addObject:a.tag];
        }
    }
    NSLog(@"Add/Edit GUI Created");
}
//if IPad in Portrait
-(void)GUIforiPadPortrait:(NSArray*)sectionArray
{
    int a = 2;
    int b = 0;
    int startingPoint = 2;
    for (int i = 0; i < 2; i++)
    {
        startingPoint = 2;
        for (int j = 0; j < a; j++)
        {
            UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(2, 2, contentWidth * .5, contentHeight)];
            [newView setBackgroundColor:[UIColor grayColor]];
            [sectionArray[b] CreateAddEditSection:newView SuperView:self Layout:layout];
            [newView setFrame:CGRectMake(2 + (((contentWidth - 3) * .5) * i) + (i * 1), startingPoint, ((contentWidth - 3) * .5) - 1 -  + (i * 1), [newView.subviews[newView.subviews.count -1] frame].origin.y + [newView.subviews[newView.subviews.count -1] frame].size.height + 5)];
            [content addSubview:newView];
            startingPoint = [content.subviews[content.subviews.count -1] frame].origin.y + [content.subviews[content.subviews.count -1] frame].size.height + 2;
            b++;
        }
        a++;
    }
    UIScrollView *newView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, startingPoint, contentWidth - 4, contentHeight - startingPoint - 2)];
    [newView setBackgroundColor:[UIColor grayColor]];
    [sectionArray[5] CreateAddEditSection:newView SuperView:self Layout:layout];
    [newView setContentSize:CGSizeMake(newView.frame.size.width, [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 2)];
    [content addSubview:newView];
}
//if IPad in Landscape
-(void)GUIforiPadLandscape:(NSArray*)sectionArray
{
    int a = 2;
    int b = 0;
    for (int i = 0; i < 2; i++)
    {
        int startingPoint = 2;
        for (int j = 0; j < a; j++)
        {
            UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(2 + (((contentWidth - 3) * .3334) * i), 2, (contentWidth - 3) * .3334 - 2, contentHeight)];
            [newView setBackgroundColor:[UIColor grayColor]];
            [sectionArray[b] CreateAddEditSection:newView SuperView:self Layout:layout];
            [newView setFrame:CGRectMake(2 + (((contentWidth - 3) * .3334) * i),startingPoint, (contentWidth - 3) * .3334 - 2, [newView.subviews[newView.subviews.count -1] frame].origin.y + [newView.subviews[newView.subviews.count -1] frame].size.height + 5)];
            [content addSubview:newView];
            startingPoint = [content.subviews[content.subviews.count -1] frame].origin.y + [content.subviews[content.subviews.count -1] frame].size.height + 2;
            b++;
        }
        a++;
    }
    UIScrollView *newView = [[UIScrollView alloc]initWithFrame:CGRectMake(2 + (((contentWidth - 3) * .3334) * 2), 2, (contentWidth - 3) * .3334 - 2, contentHeight - 4)];
    [newView setBackgroundColor:[UIColor grayColor]];
    [sectionArray[5] CreateAddEditSection:newView SuperView:self Layout:layout];
    [newView setContentSize:CGSizeMake(newView.frame.size.width, [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 2)];
    [content addSubview:newView];
}
//if IPhone in Portrait
-(void)GUIforiPhone:(NSArray*)sectionArray
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    int startingPoint = 2;
    for (int i = 0; i < 5; i++)
    {
        UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(2, 2, contentWidth - 4, contentHeight)];
        [newView setBackgroundColor:[UIColor grayColor]];
        [sectionArray[i] CreateAddEditSection:newView SuperView:self Layout:layout];
        [newView setFrame:CGRectMake(2, startingPoint, contentWidth - 4, [newView.subviews[newView.subviews.count -1] frame].origin.y + [newView.subviews[newView.subviews.count -1] frame].size.height + 5)];
        [scrollView addSubview:newView];
        startingPoint = [scrollView.subviews[scrollView.subviews.count -1] frame].origin.y + [scrollView.subviews[scrollView.subviews.count -1] frame].size.height + 2;
    }
    UIScrollView *newView = [[UIScrollView alloc]initWithFrame:CGRectMake(2, startingPoint, contentWidth - 4, 300)];
    [newView setBackgroundColor:[UIColor grayColor]];
    [sectionArray[5] CreateAddEditSection:newView SuperView:self Layout:layout];
    [newView setContentSize:CGSizeMake(newView.frame.size.width, [newView.subviews[newView.subviews.count - 1] frame].origin.y + [newView.subviews[newView.subviews.count - 1] frame].size.height + 2)];
    [scrollView addSubview:newView];
    startingPoint = [scrollView.subviews[scrollView.subviews.count -1] frame].origin.y + [scrollView.subviews[scrollView.subviews.count -1] frame].size.height + 2;
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, startingPoint)];
    NSLog(@"Scroll Content Size: %f", scrollView.contentSize.height);
    [content addSubview:scrollView];
}


///Interaction Methods
//Pressed an Action Button
-(void)ActionButtonPressed:(Button*)button
{
    if (button.tag == 2)
    {
        NSLog(@"Search(Action1) Button Pressed");
        [self RetrieveInfoAndSave];
    }
    NSLog(@"Clear(Action2) Button Pressed");
    [self ClearAll];
    [[Database GetInstance] setActiveWord:nil];
}
//Saves the Item
-(void)RetrieveInfoAndSave
{
    NSLog(@"Sending Word Data to Database.m");
    [[Database GetInstance] setEnglish:[[[content subviews][0] subviews][1] text]];
    NSLog(@"English: %@", [Database GetInstance].english);
    [[Database GetInstance] setSpanish:[[[content subviews][0] subviews][3] text]];
    NSLog(@"Spanish: %@", [Database GetInstance].spanish);
    [[Database GetInstance] setPronunciation:[[[content subviews][0] subviews][5] text]];
    NSLog(@"Pronunciation: %@", [Database GetInstance].pronunciation);
    [[Database GetInstance] setDefinition:[[[content subviews][0] subviews][7] text]];
    NSLog(@"Definition: %@", [Database GetInstance].definition);
    [[Database GetInstance] setTags:tags];
    NSMutableArray *a = [[NSMutableArray alloc]init];
    for (int i = 0; i < 8; i++)
    {
        ConjugationView *new = [[content subviews][5] subviews][i];
        [a addObject:[[new labels][0] text]];
        [a addObject:[[new inputs][0] text]];
        [a addObject:[[new inputs][1] text]];
        [a addObject:[[new inputs][2] text]];
        [a addObject:[[new inputs][3] text]];
        [a addObject:[[new inputs][4] text]];
        [a addObject:[[new inputs][5] text]];
        NSLog(@"%@: %@, %@, %@, %@, %@, %@", [[new labels][0] text], [[new inputs][0] text], [[new inputs][1] text], [[new inputs][2] text], [[new inputs][3] text], [[new inputs][4] text], [[new inputs][5] text]);
    }
    [[Database GetInstance] setConjugations:a];
    if (editingWord)
    {
        [[Database GetInstance] Edit];
    }
    else
    {
        [[Database GetInstance] Save];
    }
}
//Clears the Form
-(void)ClearAll
{
    NSLog(@"Clearing Form");
    [[[content subviews][0] subviews][1] setText:@""];
    [[[content subviews][0] subviews][3] setText:@""];
    [[[content subviews][0] subviews][5] setText:@""];
    [[[content subviews][0] subviews][7] setText:@""];
    [tags removeAllObjects];
    [[[content subviews][1] subviews][4] reloadData];
    for (int i = 0; i < [[[content subviews][2] subviews] count] - 1; i++)
    {
        @try {
            [[[content subviews][2] subviews][i] setOn:false animated:true];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    for (int i = 0; i < [[[content subviews][3] subviews] count] - 1 ; i++)
    {
        @try {
            [[[content subviews][3] subviews][i] setOn:false animated:true];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    for (int i = 0; i < [[[content subviews][4] subviews] count] - 2 ; i++)
    {
        @try {
            [[[content subviews][4] subviews][i] setOn:false animated:true];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    for (int i = 0; i < 8; i++)
    {
        [[[[content subviews][5] subviews][i] inputs][0] setText:@""];
        [[[[content subviews][5] subviews][i] inputs][1] setText:@""];
        [[[[content subviews][5] subviews][i] inputs][2] setText:@""];
        [[[[content subviews][5] subviews][i] inputs][3] setText:@""];
        [[[[content subviews][5] subviews][i] inputs][4] setText:@""];
        [[[[content subviews][5] subviews][i] inputs][5] setText:@""];
    }
}


///Table Methods
//Add Items to the Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tags count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        UIView *aView = content.subviews[1];
        UITableView *tagsTable = aView.subviews[4];
        [tags removeObjectAtIndex:indexPath.row];
        [tagsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


///Tag Methods
//Add and Remove Tags from the List
-(void)NewTag
{
    for (int i = 0; i < content.subviews.count; i++)
    {
        NSLog(@"%d: %@", i, [content.subviews[i] description]);
    }
    [tags addObject:[[[[content subviews][1] subviews][1] text]lowercaseString]];
    [[[content subviews][1] subviews][4] reloadData];
    NSLog(@"New Tag: %@ -- %@", [[[content subviews][1] subviews][1] text], tags[tags.count - 1]);
    [[[content subviews][1] subviews][1] setText:@""];
}
-(void)RemoveTag
{
    UIView *aView = content.subviews[1];
    UITableView *tagsTable = aView.subviews[4];
    [tagsTable setEditing:!tagsTable.editing];
}


@end
