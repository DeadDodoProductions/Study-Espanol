//
//  QuizConjugation.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  Displays and controls the QuizConjugation view.
//  This class allows the user to create a randomized conjugation quiz based on criteria entered.

#import "QuizConjugation.h"
#import "QuizAnswer.h"
#import "AppDelegate.h"
#import "BaseView.h"

#import "ConjugationView.h"

#import "Conjugation.h"
#import "Word.h"

#import "Button.h"

#import "Database.h"
#import "Utilities.h"

@interface QuizConjugation ()

@end

@implementation QuizConjugation
///Initialization
//Constructor
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

    wordNumber = 0;
    
    [self CreateConjugationLists];
    [self CreateGUI];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//Sets the answers and words array as well as the total amount
-(void)CreateConjugationLists
{
    answers = [[NSMutableArray alloc]init];
    words = [[NSMutableArray alloc]init];
    NSArray *titles = [[NSArray alloc]initWithObjects:@"Present", @"Past Imperfect", @"Past Preterite", @"Future", @"Conditional", @"Imperative", @"Present Subjunctive", @"Imperfect Subjunctive", nil];
    
    NSLog(@"Number of Conjugation Types: %lu", (unsigned long)[[[Database GetInstance]conjugationType]count]);
    //For each conjugationType selected, for each word found, and for each non-empty Conjugation that matches the conjugationType add the conjugation
    for (NSNumber *type in [[Database GetInstance]conjugationType])
    {
        int a = [type intValue];
        NSLog(@"Type: %d: %@ %d", [type intValue], titles[a], a);
        for (Word *word in [[Database GetInstance] words])
        {
            NSLog(@"Word: %@ -- %@", word.english, word.spanish);
            for (Conjugation *conjugation in word.conjugations)
            {
                NSLog(@"Tense: %@", conjugation.tense);
                if ([titles[a] isEqualToString:conjugation.tense])
                {
                    NSLog(@"Adding Conjugation");
                    //gets context from AppDelagate in order to properly create the Conjugation
                    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
                    NSManagedObjectContext *context = appDelegate.managedObjectContext;
                    Conjugation *newConjugation = [NSEntityDescription insertNewObjectForEntityForName:@"Conjugation" inManagedObjectContext:context];
                    [newConjugation setWord:[conjugation word]];
                    [newConjugation setTense:[conjugation tense]];
                    //sets the conjugation fields to an empty field so they will not be nil
                    //being nil caused problems at a later point
                    [newConjugation setYo:@""];
                    [newConjugation setTu:@""];
                    [newConjugation setEl:@""];
                    [newConjugation setNosotros:@""];
                    [newConjugation setVosotros:@""];
                    [newConjugation setEllos:@""];
                    [answers addObject:newConjugation];
                    [words addObject:conjugation];
                    total += 6;
                    break;
                }
            }
        }
    }
}


///User Interface
//Creates the User Interface
-(void)CreateGUI
{
    NSLog(@"Creating ConjugationQuiz");
    //fields for defining size and placement of interface elements
    int buttonheight = contentHeight * .062;
    int conjugationWidth = contentWidth;
    int conjugationHeight = contentHeight;
    int conjugationX = 0;
    int conjugationY = 0;
    //gets device and orientation information
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    
    //sets the fields based on device and orientation
    if ([string isEqualToString:@"iPad"])
    {
        NSLog(@"Device: iPad");
        conjugationWidth = 500;
        conjugationHeight = 200;
        conjugationX = (contentWidth * .5) - (conjugationWidth * .5);
        conjugationY = ((contentHeight - buttonheight) * .5) - (conjugationHeight * .5);
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"Device: iPhone Portraite");
            layout = 3;
            conjugationWidth = contentWidth - 2;
            conjugationHeight = 150;
            conjugationX = 1;
            conjugationY = ((contentHeight - buttonheight) * .5) - (conjugationHeight * .5);
        }
        else
        {
            NSLog(@"Device: iPhone Landscape");
            layout = 4;
            buttonheight = contentHeight * .124;
            conjugationWidth = 400;
            conjugationHeight = 150;
            conjugationX = (contentWidth * .5) - (conjugationWidth * .5);
            conjugationY = ((contentHeight - buttonheight) * .5) - (conjugationHeight * .5);
        }
    }
    
    //Creates the Next Button used to transfer to the next word
    //located at the bottom right of the device
    Button *nextButton = [[Button alloc]initWithFrame:CGRectMake(contentWidth * .5, contentHeight - buttonheight, contentWidth * .5, buttonheight)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTag:0];
    [nextButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:nextButton];
    NSLog(@"Next Button Created");
    
    //Creates the Previous Button used to transfer the user to the previous word
    //located at the bottom left of the device
    Button *prevButton = [[Button alloc]initWithFrame:CGRectMake(0, contentHeight - buttonheight, contentWidth * .5 - 1, buttonheight)];
    [prevButton setTitle:@"Previous" forState:UIControlStateNormal];
    [prevButton setTag:1];
    [prevButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:prevButton];
    NSLog(@"Previous Button Created");
    
    //Creates the ConjugationView displaying the input fields
    //located at the center of the device
    conjugationView = [[ConjugationView alloc]initWithFrame:CGRectMake(conjugationX, conjugationY, conjugationWidth, conjugationHeight) Title:[words[0] tense] ParentView:self.view];
    [[conjugationView background] setBackgroundColor:[UIColor grayColor]];
    [content addSubview:conjugationView];
    
    //Creates the UILabel displaying the word being tested
    //located directly above the ConjugationView
    wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(conjugationX, conjugationView.frame.origin.y - 30, conjugationView.frame.size.width, 30)];
    [wordLabel setText:[words[0] word].spanish];
    [wordLabel setTextAlignment:NSTextAlignmentCenter];
    [wordLabel setBackgroundColor:[UIColor grayColor]];
    [content addSubview:wordLabel];
    NSLog(@"Conjugation View Created");
    
    //Creates the Done button used to tell the app to grade the test
    [self SetActionButton:1 Title:@"Done"];
    NSLog(@"ConjugationQuiz Created");
}

///User Interactions
//Called when the user is done with the test and pressed the 'Done' action button
-(void)ActionButtonPressed:(Button*)button
{
    NSLog(@"Action Button 'Done' was pressed");
    //Saves any entries that were not already saved
    [self SaveAnswers];
    
    //allocates arrays to be passed to QuizAnswers
    NSMutableArray *_tenses = [[NSMutableArray alloc]init];
    NSMutableArray *_words = [[NSMutableArray alloc]init];
    NSMutableArray *_correct = [[NSMutableArray alloc]init];
    NSMutableArray *_answers = [[NSMutableArray alloc]init];
    
    //determines all of the correct and incorrect answers
    //if the answer is incorrect it adds the spanish word, tense, answer provide, and correct answer
    //into their designated array at the same postion in each array
    for (int i = 0; i < words.count; i++)
    {
        if ([words[i] yo] != [answers[i] yo])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ yo", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] yo]];
            [_answers addObject:[answers[i] yo]];
        }
        if ([words[i] tu] != [answers[i] tu])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ tu", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] tu]];
            [_answers addObject:[answers[i] tu]];
        }
        if ([words[i] el] != [answers[i] el])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ el", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] el]];
            [_answers addObject:[answers[i] el]];
        }
        if ([words[i] nosotros] != [answers[i] nosotros])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ nos", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] nosotros]];
            [_answers addObject:[answers[i] nosotros]];
        }
        if ([words[i] vosotros] != [answers[i] vosotros])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ vos", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] vosotros]];
            [_answers addObject:[answers[i] vosotros]];
        }
        if ([words[i] ellos] != [answers[i] ellos])
        {
            [_tenses addObject:[NSString stringWithFormat:@"%@ ellos", [words[i] tense]]];
            [_words addObject:[words[i] word].spanish];
            [_correct addObject:[words[i] ellos]];
            [_answers addObject:[answers[i] ellos]];
        }
    }
    
    //Creates and instance of QuizAnswers
    //SetArraysForConjugation passes the arrays, and total number of questions, into the new instance of QuizAnswers
    QuizAnswer *quizAnswer;
    quizAnswer = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizAnswer"];
    [quizAnswer SetArraysForConjugation:_words Tense:_tenses Correct:_correct Answers:_answers Total:total];
    [self presentViewController:quizAnswer animated:false completion:nil];
}
//Called when the user pressed the Previous or Next buttons
-(void)ButtonPressed:(Button*)button
{
    //saves the recently entered answers for the current conjugation
    [self SaveAnswers];
    
    //increments and decrements wordNumber, and wraps the number if it goes beyond the possible range
    if (button.tag == 0)
    {
        NSLog(@"Next Button Pressed");
        wordNumber++;
        if (wordNumber > [words count] - 1)
        {
            wordNumber = 0;
        }
    }
    else
    {
        NSLog(@"Previous Button Pressed");
        wordNumber--;
        if (wordNumber < 0)
        {
            wordNumber = (int)([words count] - 1);
        }
    }
    
    //resets the text in the ConjugationView UITextViews and wordLabel UILabel
    [wordLabel setText:[words[wordNumber] word].spanish];
    [[conjugationView titleLabel] setText:[words[wordNumber] tense]];
    [[conjugationView inputs][0] setText:[answers[wordNumber] yo]];
    [[conjugationView inputs][1] setText:[answers[wordNumber] tu]];
    [[conjugationView inputs][2] setText:[answers[wordNumber] el]];
    [[conjugationView inputs][3] setText:[answers[wordNumber] nosotros]];
    [[conjugationView inputs][4] setText:[answers[wordNumber] vosotros]];
    [[conjugationView inputs][5] setText:[answers[wordNumber] ellos]];
}
//Saves the answers
-(void)SaveAnswers
{
    //saves the entered fields
    [answers[wordNumber] setYo:[[conjugationView inputs][0] text]];
    [answers[wordNumber] setTu:[[conjugationView inputs][1] text]];
    [answers[wordNumber] setEl:[[conjugationView inputs][2] text]];
    [answers[wordNumber] setNosotros:[[conjugationView inputs][3] text]];
    [answers[wordNumber] setVosotros:[[conjugationView inputs][4] text]];
    [answers[wordNumber] setEllos:[[conjugationView inputs][5] text]];
    NSLog(@"Saved: wordNumber:%d yo:%@ tu:%@ el:%@ nos:%@ vos:%@ ellos:%@", wordNumber, [answers[wordNumber] yo], [answers[wordNumber] tu],[answers[wordNumber] el],[answers[wordNumber] nosotros],[answers[wordNumber] vosotros],[answers[wordNumber] ellos]);
}


///TextView Delegate Methods
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [BaseView SetTextViewPosition:CGPointMake(0, contentHeight)];
}
@end
