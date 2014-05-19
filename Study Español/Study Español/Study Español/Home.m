//
//  Home.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "Home.h"
#import "Button.h"
#import "AddEditView.h"
#import "SearchView.h"
#import "WordList.h"
#import "QuizVocab.h"
#import "QuizConjugation.h"
#import "FlashCards.h"
#import "Database.h"

@interface Home ()

@end

@implementation Home

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
    [super shouldAutorotate];
    [self GUIOrientation];
    searching = false;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Home");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ran at startup initializes of program
-(void)Startup
{
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self GUIOrientation];
    if (searching == true)
    {
        [self CreateSearch];
    }
}

-(void)GUIOrientation
{
    float topPadding;
    float sidePadding;
    float spacing;
    float size;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        topPadding = 0.156f;
        sidePadding = 0.039f;
        spacing = 0.475f;
        size = 0.45f;
        if (screenSize.height > 500)
        {
            topPadding = 0.215f;
        }
        if (screenSize.height > 1000)
        {
            topPadding = 0.1351f;
        }
    }
    else
    {
        topPadding = 0.025f;
        sidePadding = 0.234f;
        spacing = 0.275f;
        size = 0.26f;
        if (screenSize.height > 500)
        {
            topPadding = 0.0105f;
            sidePadding = 0.2687f;
            spacing = 0.235f;
            size = 0.23f;
        }
        if (screenSize.height > 1000)
        {
            topPadding = 0.095f;
            sidePadding = 0.216f;
            spacing = 0.29f;
            size = 0.28f;
        }
    }
    [self CreateGUI:sidePadding TopPadding:topPadding Spacing:spacing Size:size];
}

//displays GUI
-(void)CreateGUI:(float)leftPadding TopPadding:(float)topPadding Spacing:(float)spacing Size:(float)size
{
    NSLog(@"Create GUI");
    NSArray *titles = [[NSArray alloc] initWithObjects:@"Add Word", @"Quiz", @"Word List", @"Flashcards", nil];
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            //creates the four home screen buttons
            Button *newButton = [[Button alloc] initWithFrame:CGRectMake(contentWidth * leftPadding + (i * contentWidth * spacing), contentHeight * topPadding + (j * contentWidth * spacing), contentWidth * size, contentWidth * size)];
            [newButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
            [newButton setTitle:titles[(i * 2) + j] forState:UIControlStateNormal];
            [newButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [newButton setTag:(i * 2) + j];
            [content addSubview:newButton];
            NSLog(@"x: %f y: %f width: %f height: %f", newButton.frame.origin.x, newButton.frame.origin.y, newButton.frame.size.width, newButton.frame.size.height);
            NSLog(@"New Home Button Created");
        }
    }
    NSLog(@"Subviews: %d", content.subviews.count);
}

//called when a button is pressed
-(void)ButtonPressed:(Button*)button
{
    NSLog(@"Button Pressed: %d", button.tag);
    if (button.tag == 0)
    {
        AddEditView *addEditView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditView"];
        [self presentViewController:addEditView animated:false completion:nil];
    }
    else
    {
        selected = button.tag;
        //disables the buttons while Search View is on screen
        for (int i = 0; i < content.subviews.count; i++)
        {
            //[content.subviews[i] setEnabled:false];
            NSLog(@"Button%d disabled", i);
        }
        background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
        [background setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
        [content addSubview:background];
        [self CreateSearch];
    }
}

//brings up the Search GUI
-(void)CreateSearch
{
    searching = true;
    //create a view, with Search and Cancel at the bottom, add a scroll view that fits inside the view
    NSLog(@"Create Search View");
    searchView = [[SearchView alloc]initWithFrame:CGRectMake(contentWidth * .05, contentHeight * .05, contentWidth * .9, contentHeight * .9) Home:self];
    NSLog(@"start: %f height: %f totalH: %d", searchView.frame.origin.y, searchView.frame.size.height, contentHeight);
    [searchView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.2]];
    
    [super SetActionButton:1 Title:@"Search"];
    [super SetActionButton:2 Title:@"Cancel"];
    
    [content addSubview:searchView];
}

//exits the search
-(void)ExitSearch
{
    searching = false;
    [background setFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)ActionButtonPressed:(Button*)button
{
    [searchView setHidden:true];
    [actionButton1 setHidden:true];
    [actionButton2 setHidden:true];
    searching = false;
    [background setFrame:CGRectMake(0, 0, 0, 0)];
    if (button.tag == 2)
    {
        NSLog(@"Search(Action1) Button Pressed");
        [[Database GetInstance] Search];
        [self GoToNewView];
    }
    else
    {
        NSLog(@"Cancel(Action2) Button Pressed");
    }
}

-(void)GoToNewView
{
    WordList *wordList;
    FlashCards *flashCards;
    QuizConjugation *quizCon;
    QuizVocab *quizVocab;
    switch (selected)
    {
        case 1:
            NSLog(@"%@", [Database GetInstance].quizType);
            if ([[Database GetInstance].quizType isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                quizCon = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizConjugation"];
                [self presentViewController:quizCon animated:false completion:nil];
            }
            else
            {
                quizVocab = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizVocab"];
                [self presentViewController:quizVocab animated:false completion:nil];
            }
            break;
            
        case 2:
            wordList = [self.storyboard instantiateViewControllerWithIdentifier:@"WordList"];
            [self presentViewController:wordList animated:false completion:nil];
            break;
            
        case 3:
            flashCards = [self.storyboard instantiateViewControllerWithIdentifier:@"FlashCards"];
            [self presentViewController:flashCards animated:false completion:nil];
            break;
    }
}

@end
