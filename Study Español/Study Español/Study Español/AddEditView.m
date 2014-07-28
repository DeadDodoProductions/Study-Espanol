//
//  AddEditView.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//  Displays and controls the AddEdit view
//  Allows the user to add new words or edit previous words

#import "AddEditView.h"
#import "BaseView.h"

#import "TextView.h"
#import "ConjugationView.h"

#import "WordTypeSectionView.h"
#import "VerbTypeSectionView.h"
#import "WordTagSectionView.h"
#import "ConjugationTypeSectionView.h"
#import "WordSectionView.h"
#import "MiscSectionView.h"

#import "Word.h"
#import "Tag.h"
#import "Conjugation.h"

#import "Button.h"
#import "SwitchController.h"

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
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self CreateGUI];
}
-(void)CreateGUI
{
    NSLog(@"AddEditView: CreateGUI");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    NSArray *sectionsArray;
    
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            layout = iPadPortrait;
            [self GUIforiPadPortrait:sectionsArray];
        }
        else
        {
            NSLog(@"iPad Landscape");
            layout = iPadLandscape;
            [self GUIforiPadLandscape:sectionsArray];
        }
    }
    else
    {
        NSLog(@"iPhone");
        layout = iPhone;
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
    NSLog(@"AddEditView: GUIforiPadPortrait");
    int startingY = 2;
    wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [wordSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordSectionView];
    startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
    
    wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
    [wordTagSectionView setDelegate:self];
    [content addSubview:wordTagSectionView];
    startingY = 2;
    
    wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:miscSectionView];
    startingY = miscSectionView.frame.origin.y + miscSectionView.frame.size.height + 2;

    conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight * .26) ParentView:self Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [conjugationTypeSectionView setContentSize:CGSizeMake(conjugationTypeSectionView.frame.size.width, [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].origin.y + [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].size.height + 2)];
    [content addSubview:conjugationTypeSectionView];
}
//if IPad in Landscape
-(void)GUIforiPadLandscape:(NSArray*)sectionArray
{
    NSLog(@"AddEditView: GUIforiPadLandscape");
     int startingY = 2;
     wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [wordSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:wordSectionView];
     startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
     
     wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self Layout:layout];
     [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
    [wordTagSectionView setDelegate:self];
     [content addSubview:wordTagSectionView];
     startingY = 2;
     
     wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:wordTypeSectionView];
     startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
     
     verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:verbTypeSectionView];
     startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
     
     miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [miscSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:miscSectionView];
     startingY = 2;
     
     conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .664), startingY, contentWidth * .332, contentHeight - 7) ParentView:self.view Layout:layout];
     [conjugationTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [conjugationTypeSectionView setContentSize:CGSizeMake(conjugationTypeSectionView.frame.size.width, [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].origin.y + [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].size.height + 2)];
     [content addSubview:conjugationTypeSectionView];
}
//if IPhone in Portrait
-(void)GUIforiPhone:(NSArray*)sectionArray
{
    NSLog(@"AddEditView: GUIforiPhone");
    int startingY = 2;
    wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [wordSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordSectionView];
    startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
    
    wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
    [wordTagSectionView setDelegate:self];
    [content addSubview:wordTagSectionView];
    startingY = wordTagSectionView.frame.origin.y + wordTagSectionView.frame.size.height + 2;
    
    wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:miscSectionView];
    startingY = miscSectionView.frame.origin.y + miscSectionView.frame.size.height + 2;
    
    conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight * .667) ParentView:self.view Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [conjugationTypeSectionView setContentSize:CGSizeMake(conjugationTypeSectionView.frame.size.width, [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].origin.y + [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].size.height + 2)];
    [content addSubview:conjugationTypeSectionView];
    startingY = conjugationTypeSectionView.frame.origin.y + conjugationTypeSectionView.frame.size.height + 2;
    [content setContentSize:CGSizeMake(content.frame.size.width, startingY)];
}


///Interaction Methods
//Pressed an Action Button
-(void)ActionButtonPressed:(Button*)button
{
    NSLog(@"AddEditView: ActionButtonPressed");
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
    NSLog(@"AdEditView: RetrieveInfoAndSave");
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
    if (![[[Database GetInstance] english]  isEqual: @""] && ![[[Database GetInstance] spanish]  isEqual: @""])
    {
        if (editingWord)
        {
            [[Database GetInstance] Edit];
            editingWord = false;
        }
        else
        {
            [[Database GetInstance] Save];
        }
    }
    else
    {
        //display alert about unable to save because of unanswered defaults
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Unable to Save" message:@"Not all required fields filled out." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        //set the required fields to red
        [[wordSectionView subviews][0] setTextColor:[UIColor redColor]];
        [[wordSectionView subviews][2] setTextColor:[UIColor redColor]];
    }
}
//Clears the Form
-(void)ClearAll
{
    NSLog(@"AdEditView: ClearAll");
    [[wordSectionView subviews][1] setText:@""];
    [[wordSectionView subviews][3] setText:@""];
    [[wordSectionView subviews][5] setText:@""];
    [[wordSectionView subviews][7] setText:@""];
    [tags removeAllObjects];
    [[wordTagSectionView subviews][5] reloadData];
    [[SwitchController GetInstance] TurnOffAll];
    for (int i = 0; i < 8; i++)
    {
        [[[conjugationTypeSectionView subviews][i] inputs][0] setText:@""];
        [[[conjugationTypeSectionView subviews][i] inputs][1] setText:@""];
        [[[conjugationTypeSectionView subviews][i] inputs][2] setText:@""];
        [[[conjugationTypeSectionView subviews][i] inputs][3] setText:@""];
        [[[conjugationTypeSectionView subviews][i] inputs][4] setText:@""];
        [[[conjugationTypeSectionView subviews][i] inputs][5] setText:@""];
    }
}


///Table Methods
//Add Items to the Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"AddEditView: TableViewNumberOfRowsInSection");
    return [tags count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"AdEditView: tableView cellForRowAtIndexPath");
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", tags[indexPath.row]]];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"AdEditView: tableView editingStyleForRowAtIndexPath");
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"AdEditView: tableView commitEditingStyle");
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIView *aView = content.subviews[1];
        UITableView *tagsTable = aView.subviews[5];
        [tags removeObjectAtIndex:indexPath.row];
        [tagsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


///Tag Methods
//Add and Remove Tags from the List
-(void)AddTag:(NSString *)tag
{
    NSLog(@"AdEditView: AddTag");
    if (![tag isEqual: @""])
    {
        [tags addObject:[tag lowercaseString]];
        [[[content subviews][1] subviews][5] reloadData];
        NSLog(@"New Tag: %@ -- %@", tag, tags[tags.count - 1]);
    }
}
-(void)RemoveTag
{
    NSLog(@"AdEditView: RemoveTag");
    UIView *aView = content.subviews[1];
    UITableView *tagsTable = aView.subviews[5];
    [tagsTable setEditing:!tagsTable.editing];
}
@end
