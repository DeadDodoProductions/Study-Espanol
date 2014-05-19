//
//  QuizConjugation.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "QuizConjugation.h"
#import "ConjugationView.h"
#import "Conjugation.h"
#import "Word.h"
#import "Button.h"
#import "Database.h"
#import "Utilities.h"
#import "QuizAnswer.h"

@interface QuizConjugation ()

@end

@implementation QuizConjugation

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

    currentConjugation = 0;
    
    [self CreateConjugationLists];
    [self CreateGUI];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)CreateConjugationLists
{
    answers = [[NSMutableArray alloc]init];
    words = [[NSMutableArray alloc]init];
    NSArray *titles = [[NSArray alloc]initWithObjects:@"Present", @"Past Imperfect", @"Past Preterite", @"Future", @"Conditional", @"Imperative", @"Present Subjunctive", @"Imperfect Subjunctive", nil];
    
    for (NSNumber *type in [[Database GetInstance]conjugationType])
    {
        int a = [type intValue];
        NSLog(@"%d: %@ %d", [type intValue], titles[a], a);
        for (Word *word in [[Database GetInstance] words])
        {
            NSLog(@"Word: %@ -- %@", word.english, word.spanish);
            for (Conjugation *conjugation in word.conjugations)
            {
                NSLog(@"Tense: %@", conjugation.tense);
                if ([titles[a] isEqualToString:conjugation.tense])
                {
                    Conjugation *newConjugation = [[Conjugation alloc]init];
                    [answers addObject:newConjugation];
                    [words addObject:conjugation];
                    break;
                }
            }
        }
    }
}
-(void)CreateGUI
{
    NSLog(@"Creating ConjugationQuiz");
    [self SetActionButton:1 Title:@"Done"];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSString *string = [Utilities GetDevice];
    if ([string isEqualToString:@"iPad"])
    {
        if (UIInterfaceOrientationIsPortrait(orientation))
        {
            NSLog(@"iPad Portrait");
            layout = 0;
            [self GUIforiPadPortrait];
        }
        else
        {
            NSLog(@"iPad Landscape");
            layout = 1;
            [self GUIforiPadLandscape];
        }
    }
    else
    {
        NSLog(@"iPhone");
        layout = 2;
        [self GUIforiPhone];
    }
    NSLog(@"ConjugationQuiz Created");
}
- (void)GUIforiPadPortrait
{
    Button *nextButton = [[Button alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    [nextButton setTag:0];
    [nextButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    Button *prevButton = [[Button alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    [prevButton setTag:1];
    [prevButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prevButton];
    
    ConjugationView *conjugationView = [[ConjugationView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) Title:@"Title"];
    [[conjugationView background] setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:conjugationView];
}
- (void)GUIforiPadLandscape
{
    Button *nextButton = [[Button alloc]initWithFrame:CGRectMake(contentWidth - 200, contentHeight * .5 - 15, 100, 30)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTag:0];
    [nextButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    Button *prevButton = [[Button alloc]initWithFrame:CGRectMake(100, contentHeight * .5 - 15, 100, 30)];
    [prevButton setTitle:@"Previous" forState:UIControlStateNormal];
    [prevButton setTag:1];
    [prevButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prevButton];
    
    NSString *aString = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@ - %@", [words[0] word].english, [words[0] tense]]];
    ConjugationView *conjugationView = [[ConjugationView alloc]initWithFrame:CGRectMake(contentWidth * .5 - 200, contentHeight * .5 - 75, 400, 150) Title:aString];
    [[conjugationView background] setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:conjugationView];
}
- (void)GUIforiPhone
{
    Button *nextButton = [[Button alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    [nextButton setTag:0];
    [nextButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    Button *prevButton = [[Button alloc]initWithFrame:CGRectMake(0, 0, 100, 10)];
    [prevButton setTag:1];
    [prevButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prevButton];
    
    ConjugationView *conjugationView = [[ConjugationView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) Title:@"Title"];
    [[conjugationView background] setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:conjugationView];
}


-(void)CompareAnswers
{
    
}

-(void)ButtonPressed:(Button*)button
{
    if (button.tag == 0)
    {
        
    }
    else
    {
        
    }
}

-(void)ActionButtonPressed:(Button*)button
{
    QuizAnswer *quizAnswer;
    quizAnswer = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizAnswer"];
    [self presentViewController:quizAnswer animated:false completion:nil];
}

@end
