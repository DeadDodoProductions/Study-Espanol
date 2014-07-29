//
//  MiscSectionView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "MiscSectionView.h"
#import "Switch.h"
#import "SwitchController.h"
#import "Database.h"
#import "Word.h"

@implementation MiscSectionView

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Gender Section");
        [SwitchController GetInstance].gSwitches = [[NSMutableArray alloc]init];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .5, 30)];
        title.text = @"Gender";
        [self addSubview:title];
        
        NSArray *titles = [[NSArray alloc] initWithObjects:@"Masculine", @"Feminine", nil];
        for (int i = 0; i < 2; i++)
        {
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 47 + (i * 37), 100, 30)];
            [newLabel setText:[NSString stringWithFormat:@"%@", titles[i]]];
            [newLabel setTag:0];
            [self addSubview:newLabel];
            
            Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, 47 + (i * 37), 0, 0)];
            [newSwitch setGroup:3];
            [newSwitch setValue:[NSNumber numberWithInt:i]];
            [newSwitch setTag:1];
            [[[SwitchController GetInstance] gSwitches] addObject:newSwitch];
            [self addSubview:newSwitch];
            if ([[Database GetInstance] activeWord] != nil)
            {
                if ([[[[Database GetInstance] activeWord] gender] isEqualToNumber:[NSNumber numberWithInt:i]])
                {
                    [newSwitch setOn:true animated:true];
                    [[Database GetInstance] setGender:[NSNumber numberWithInt:i]];
                }
            }
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newLabel.frame.origin.y + newLabel.frame.size.height + 6)];
        }
    }
    return self;
}

- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Misc Section");
        [SwitchController GetInstance].qSwitches = [[NSMutableArray alloc]init];
        [SwitchController GetInstance].tSwitches = [[NSMutableArray alloc]init];
        UILabel *vocabQuiz = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, self.frame.size.width * .7, 30)];
        [vocabQuiz setText:@"Vocab Quiz"];
        [self addSubview:vocabQuiz];
        
        //Creating Vocab Quiz Switch
        //Is Default
        Switch *vocabQuizSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, 6, 0, 0)];
        [vocabQuizSwitch setGroup:5];
        [vocabQuizSwitch setValue:[NSNumber numberWithInt:0]];
        [vocabQuizSwitch setOn:true];
        [[[SwitchController GetInstance] qSwitches] addObject:vocabQuizSwitch];
        [[Database GetInstance] setQuizType:[NSNumber numberWithInt:0]];
        [self addSubview:vocabQuizSwitch];
        
        UILabel *conjugationQuiz = [[UILabel alloc]initWithFrame:CGRectMake(5, vocabQuizSwitch.frame.origin.y + vocabQuizSwitch.frame.size.height + 5, self.frame.size.width * .7, 30)];
        [conjugationQuiz setText:@"Conjugation Quiz"];
        [self addSubview:conjugationQuiz];
        
        //Creating Conjugation Quiz Switch
        Switch *conjugationQuizSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, vocabQuizSwitch.frame.origin.y + vocabQuizSwitch.frame.size.height + 5, 0, 0)];
        [conjugationQuizSwitch setGroup:5];
        [conjugationQuizSwitch setValue:[NSNumber numberWithInt:1]];
        [[[SwitchController GetInstance] qSwitches] addObject:conjugationQuizSwitch];
        [self addSubview:conjugationQuizSwitch];
        
        
        UILabel *translateSE = [[UILabel alloc]initWithFrame:CGRectMake(5, conjugationQuiz.frame.origin.y + conjugationQuiz.frame.size.height + 30, self.frame.size.width * .7, 30)];
        [translateSE setText:@"Español to English"];
        [self addSubview:translateSE];
        
        //Creating Spanish to English Translation Switch
        //Is Default
        Switch *translateSESwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, conjugationQuiz.frame.origin.y + conjugationQuiz.frame.size.height + 30, 0, 0)];
        [translateSESwitch setGroup:6];
        [translateSESwitch setValue:[NSNumber numberWithInt:0]];
        [translateSESwitch setOn:true];
        [[[SwitchController GetInstance] tSwitches] addObject:translateSESwitch];
        [[Database GetInstance] setTranslate:[NSNumber numberWithInt:0]];
        [self addSubview:translateSESwitch];
        
        UILabel *translateES = [[UILabel alloc]initWithFrame:CGRectMake(5, translateSE.frame.origin.y + translateSE.frame.size.height + 5, self.frame.size.width * .7, 30)];
        [translateES setText:@"English to Español"];
        [self addSubview:translateES];
        
        //Creating English to Spanish Translation Switch
        Switch *translateESSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, translateSE.frame.origin.y + translateSE.frame.size.height + 5, 0, 0)];
        [translateESSwitch setGroup:6];
        [translateESSwitch setValue:[NSNumber numberWithInt:1]];
        [[[SwitchController GetInstance] tSwitches] addObject:translateESSwitch];
        [self addSubview:translateESSwitch];
        
        
        UILabel *amount = [[UILabel alloc]initWithFrame:CGRectMake(5, translateES.frame.origin.y + translateES.frame.size.height + 30, self.frame.size.width * .7, 30)];
        int a = 0;
        [amount setText:[NSString stringWithFormat:@"Number of Words: %d", a]];
        [self addSubview:amount];
        
        UIStepper *amountStepper = [[UIStepper alloc] initWithFrame:CGRectMake(self.frame.size.width * .65, translateES.frame.origin.y + translateES.frame.size.height + 30, 0, 0)];
        [amountStepper setBackgroundColor:[UIColor whiteColor]];
        [amountStepper setStepValue:5];
        [amountStepper addTarget:parentView action:@selector(StepperPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:amountStepper];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, amount.frame.origin.y + amount.frame.size.height + 4)];
    }
    return self;
}

@end
