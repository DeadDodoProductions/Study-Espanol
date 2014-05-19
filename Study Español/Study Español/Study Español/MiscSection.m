//
//  MiscSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "MiscSection.h"
#import "Switch.h"
#import "Database.h"

@implementation MiscSection
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    NSLog(@"Creating Misc Section");
    UILabel *vocabQuiz = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, view.frame.size.width * .7, 30)];
    [vocabQuiz setText:@"Vocab Quiz"];
    [view addSubview:vocabQuiz];
    
    //Creating Vocab Quiz Switch
    //Is Default
    Switch *vocabQuizSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, 6, 0, 0)];
    [vocabQuizSwitch setGroup:5];
    [vocabQuizSwitch setValue:[NSNumber numberWithInt:0]];
    [vocabQuizSwitch setOn:true];
    [[Database GetInstance] setQuizType:[NSNumber numberWithInt:0]];
    [view addSubview:vocabQuizSwitch];
    
    UILabel *conjugationQuiz = [[UILabel alloc]initWithFrame:CGRectMake(5, vocabQuizSwitch.frame.origin.y + vocabQuizSwitch.frame.size.height + 5, view.frame.size.width * .7, 30)];
    [conjugationQuiz setText:@"Conjugation Quiz"];
    [view addSubview:conjugationQuiz];
    
    //Creating Conjugation Quiz Switch
    Switch *conjugationQuizSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, vocabQuizSwitch.frame.origin.y + vocabQuizSwitch.frame.size.height + 5, 0, 0)];
    [conjugationQuizSwitch setGroup:5];
    [conjugationQuizSwitch setValue:[NSNumber numberWithInt:1]];
    [view addSubview:conjugationQuizSwitch];
    
    //Listeners don't allow both to be selected at the same time
    [vocabQuizSwitch addTarget:conjugationQuizSwitch action:@selector(TurnOff:) forControlEvents:UIControlEventAllEvents];
    [conjugationQuizSwitch addTarget:vocabQuizSwitch action:@selector(TurnOff:) forControlEvents:UIControlEventAllEvents];
    
    
    UILabel *translateSE = [[UILabel alloc]initWithFrame:CGRectMake(5, conjugationQuiz.frame.origin.y + conjugationQuiz.frame.size.height + 30, view.frame.size.width * .7, 30)];
    [translateSE setText:@"Español to English"];
    [view addSubview:translateSE];
    
    //Creating Spanish to English Translation Switch
    //Is Default
    Switch *translateSESwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, conjugationQuiz.frame.origin.y + conjugationQuiz.frame.size.height + 30, 0, 0)];
    [translateSESwitch setGroup:6];
    [translateSESwitch setValue:[NSNumber numberWithInt:0]];
    [translateSESwitch setOn:true];
    [[Database GetInstance] setTranslate:[NSNumber numberWithInt:0]];
    [view addSubview:translateSESwitch];
    
    UILabel *translateES = [[UILabel alloc]initWithFrame:CGRectMake(5, translateSE.frame.origin.y + translateSE.frame.size.height + 5, view.frame.size.width * .7, 30)];
    [translateES setText:@"English to Español"];
    [view addSubview:translateES];
    
    //Creating English to Spanish Translation Switch
    Switch *translateESSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, translateSE.frame.origin.y + translateSE.frame.size.height + 5, 0, 0)];
    [translateESSwitch setGroup:6];
    [translateESSwitch setValue:[NSNumber numberWithInt:1]];
    [view addSubview:translateESSwitch];
    
    //Listeners don't allow both to be selected at the same time
    [translateSESwitch addTarget:translateESSwitch action:@selector(TurnOff:) forControlEvents:UIControlEventAllEvents];
    [translateESSwitch addTarget:translateSESwitch action:@selector(TurnOff:) forControlEvents:UIControlEventAllEvents];
    
    
    UILabel *amount = [[UILabel alloc]initWithFrame:CGRectMake(5, translateES.frame.origin.y + translateES.frame.size.height + 30, view.frame.size.width * .7, 30)];
    int a = 0;
    [amount setText:[NSString stringWithFormat:@"Number of Words: %d", a]];
    [view addSubview:amount];
    
    UIStepper *amountStepper = [[UIStepper alloc] initWithFrame:CGRectMake(view.frame.size.width * .65, translateES.frame.origin.y + translateES.frame.size.height + 30, 0, 0)];
    [amountStepper setBackgroundColor:[UIColor whiteColor]];
    [amountStepper setStepValue:5];
    [amountStepper addTarget:superView action:@selector(StepperPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:amountStepper];
}

-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    NSLog(@"Creating Gender Section");
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .5, 30)];
    title.text = @"Gender";
    [view addSubview:title];
    
    NSArray *titles = [[NSArray alloc] initWithObjects:@"Masculine", @"Feminine", nil];
    for (int i = 0; i < 2; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 47 + (i * 37), 100, 30)];
        [newLabel setText:[NSString stringWithFormat:@"%@", titles[i]]];
        [newLabel setTag:0];
        [view addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, 47 + (i * 37), 0, 0)];
        [newSwitch setGroup:3];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [view addSubview:newSwitch];
    }
    int i = 2;
    while (i < 5)
    {
        int j = 2;
        while (j < 5)
        {
            if (i != j)
            {
                [view.subviews[j] addTarget:view.subviews[i] action:@selector(TurnOff:) forControlEvents:UIControlEventAllEvents];
            }
            j+=2;
        }
        i+=2;
    }
}

@end
