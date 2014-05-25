//
//  FlashCards.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "FlashCards.h"
#import "Utilities.h"
#import "Button.h"
#import "Database.h"
#import "Word.h"

@interface FlashCards ()

@end

@implementation FlashCards

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
    currentWord = 0;
    [self CreateGUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



///User Interface Methods
//Creates the GUI
-(void)CreateGUI
{
    NSLog(@"Creating GUI for Flashcards View");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    
    prevButton = [[Button alloc]init];
    [prevButton setTitle:@"Previous" forState:UIControlStateNormal];
    [prevButton setBackgroundColor:[UIColor grayColor]];
    [prevButton addTarget:self action:@selector(PrevWord:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:prevButton];
    
    nextButton = [[Button alloc]init];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setBackgroundColor:[UIColor grayColor]];
    [nextButton addTarget:self action:@selector(NextWord:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:nextButton];
    
    answerButton = [[Button alloc]init];
    [answerButton setTitle:@"Answer" forState:UIControlStateNormal];
    [answerButton setBackgroundColor:[UIColor grayColor]];
    [answerButton addTarget:self action:@selector(Answer:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:answerButton];
    
    viewWordButton = [[Button alloc]init];
    [content addSubview:viewWordButton];
    
    wordLabel = [[UILabel alloc]init];
    [wordLabel setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordLabel];
    
    answerLabel = [[UILabel alloc]init];
    [answerLabel setBackgroundColor:[UIColor grayColor]];
    [content addSubview:answerLabel];
    
    int buttonheight = contentHeight * .062;
    int wordheight = contentHeight * .3;
    int spacing = contentHeight * .02;
    [prevButton setFrame:CGRectMake(0, contentHeight - buttonheight, contentWidth * .3334, buttonheight)];
    [nextButton setFrame:CGRectMake(contentWidth * .6667, contentHeight - buttonheight, contentWidth * .3334, buttonheight)];
    [answerButton setFrame:CGRectMake((contentWidth * .3334) + 1, contentHeight - buttonheight, (contentWidth * .3334) - 2, buttonheight)];
    [viewWordButton setFrame:CGRectMake(0, 0, 0, 0)];
    
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        NSLog(@"Portrait");
        [wordLabel setFrame:CGRectMake(contentWidth * .25, ((contentHeight - buttonheight) * .5) - (wordheight + spacing), contentWidth * .5, wordheight)];
        [answerLabel setFrame:CGRectMake(contentWidth * .25, ((contentHeight - buttonheight) * .5) + spacing, contentWidth * .5, wordheight)];
    }
    else
    {
        NSLog(@"Landscape");
        [wordLabel setFrame:CGRectMake(contentWidth * .35, ((contentHeight - buttonheight) * .5) - (wordheight + spacing), contentWidth * .3, wordheight)];
        [answerLabel setFrame:CGRectMake(contentWidth * .35, ((contentHeight - buttonheight) * .5) + spacing, contentWidth * .3, wordheight)];
    }
}


-(void)NextWord:(Button*)button
{
    currentWord++;
    if (currentWord >= [[[Database GetInstance] words] count])
    {
        currentWord = 0;
    }
    [answerLabel setText:[NSString stringWithFormat:@""]];
    Word *word = [[Database GetInstance] words][currentWord];
    [wordLabel setText:[NSString stringWithFormat:@"%@", [word spanish]]];
}
-(void)PrevWord:(Button*)button
{
    currentWord--;
    if (currentWord < 0)
    {
        currentWord = (int)[[[Database GetInstance] words] count] - 1;
    }
    Word *word = [[Database GetInstance] words][currentWord];
    [wordLabel setText:[NSString stringWithFormat:@"%@", [word spanish]]];
}
-(void)Answer:(Button*)button
{
    
}

@end
