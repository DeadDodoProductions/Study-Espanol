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
-(void)CreateGUI
{
    NSLog(@"Creating GUI for Add/Edit View");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    NSArray *sectionsArray;
    
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            layout = 0;
            [self GUIforiPadPortrait:sectionsArray];
        }
        else
        {
            NSLog(@"iPad Landscape");
            layout = 1;
            [self GUIforiPadLandscape:sectionsArray];
        }
    }
    else
    {
        NSLog(@"iPhone");
        layout = 2;
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
    int startingY = 2;
    WordSectionView *wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [wordSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordSectionView];
    startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
    
    WordTagSectionView *wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTagSectionView];
    startingY = 2;
    
    WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    MiscSectionView *miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .5), startingY, ((contentWidth - 3) * .5) - 1, contentHeight * .3) ParentView:self.view Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:miscSectionView];
    startingY = miscSectionView.frame.origin.y + miscSectionView.frame.size.height + 2;

    ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight * .26) ParentView:self.view Layout:layout];
    [conjugationTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [conjugationTypeSectionView setContentSize:CGSizeMake(conjugationTypeSectionView.frame.size.width, [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].origin.y + [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].size.height + 2)];
    [content addSubview:conjugationTypeSectionView];
}
//if IPad in Landscape
-(void)GUIforiPadLandscape:(NSArray*)sectionArray
{
     int startingY = 2;
     WordSectionView *wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [wordSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:wordSectionView];
     startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
     
     WordTagSectionView *wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self Layout:layout];
     [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:wordTagSectionView];
     startingY = 2;
     
     WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:wordTypeSectionView];
     startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
     
     VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:verbTypeSectionView];
     startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
     
     MiscSectionView *miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .332), startingY, ((contentWidth - 3) * .332) - 1, contentHeight) ParentView:self.view Layout:layout];
     [miscSectionView setBackgroundColor:[UIColor grayColor]];
     [content addSubview:miscSectionView];
     startingY = 2;
     
     ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2 + (contentWidth * .664), startingY, contentWidth * .332, contentHeight - 7) ParentView:self.view Layout:layout];
     [conjugationTypeSectionView setBackgroundColor:[UIColor grayColor]];
     [conjugationTypeSectionView setContentSize:CGSizeMake(conjugationTypeSectionView.frame.size.width, [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].origin.y + [conjugationTypeSectionView.subviews[conjugationTypeSectionView.subviews.count - 1] frame].size.height + 2)];
     [content addSubview:conjugationTypeSectionView];
}
//if IPhone in Portrait
-(void)GUIforiPhone:(NSArray*)sectionArray
{    
    int startingY = 2;
    WordSectionView *wordSectionView = [[WordSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [wordSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordSectionView];
    startingY = wordSectionView.frame.origin.y + wordSectionView.frame.size.height + 2;
    
    WordTagSectionView *wordTagSectionView = [[WordTagSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self Layout:layout];
    [wordTagSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTagSectionView];
    startingY = wordTagSectionView.frame.origin.y + wordTagSectionView.frame.size.height + 2;
    
    WordTypeSectionView *wordTypeSectionView = [[WordTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [wordTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordTypeSectionView];
    startingY = wordTypeSectionView.frame.origin.y + wordTypeSectionView.frame.size.height + 2;
    
    VerbTypeSectionView *verbTypeSectionView = [[VerbTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [verbTypeSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:verbTypeSectionView];
    startingY = verbTypeSectionView.frame.origin.y + verbTypeSectionView.frame.size.height + 2;
    
    MiscSectionView *miscSectionView = [[MiscSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight) ParentView:self.view Layout:layout];
    [miscSectionView setBackgroundColor:[UIColor grayColor]];
    [content addSubview:miscSectionView];
    startingY = miscSectionView.frame.origin.y + miscSectionView.frame.size.height + 2;
    
    ConjugationTypeSectionView *conjugationTypeSectionView = [[ConjugationTypeSectionView alloc]initAddEditWithFrame:CGRectMake(2, startingY, contentWidth - 4, contentHeight * .667) ParentView:self.view Layout:layout];
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
    [[SwitchController GetInstance] TurnOffAll];
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
    NSLog(@"AddEditView: TableViewNumberOfRowsInSection: Tags Count: %lu", (unsigned long)[tags count]);
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [BaseView SetTextViewPosition:CGPointMake(textView.frame.origin.x + content.frame.origin.x, textView.frame.origin.y + content.frame.origin.y)];
}
@end
