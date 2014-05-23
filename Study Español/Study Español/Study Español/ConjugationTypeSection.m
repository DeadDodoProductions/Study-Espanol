//
//  ConjugationTypeSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "ConjugationTypeSection.h"
#import "Switch.h"
#import "ConjugationView.h"
#import "SwitchController.h"
#import "Conjugation.h"
#import "Word.h"
#import "Database.h"

@implementation ConjugationTypeSection
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    NSLog(@"Creating Conjugation Type Section");
    [SwitchController GetInstance].ctSwitches = [[NSMutableArray alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .5, 30)];
    title.text = @"Conjugation Type";
    [view addSubview:title];
    
    NSArray *titles = [[NSArray alloc]initWithObjects:@"Present", @"Past Imperfect", @"Past Preterite", @"Future", @"Conditional", @"Imperative", @"Present Subjunctive", @"Imperfect Subjunctive", nil];
    for (int i = 0; i < 8; i++)
    {
        NSLog(@"Creating: %@", titles[i]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40 + (i * 35), view.frame.size.width * .7, 30)];
        newLabel.text = titles[i];
        [view addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, 40 + (i * 35), 0, 0)];
        [newSwitch setGroup:4];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [[[SwitchController GetInstance] ctSwitches] addObject:newSwitch];
        [view addSubview:newSwitch];
    }
}

-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    NSLog(@"Creating Conjugation Type Section");
    NSArray *titles = [[NSArray alloc]initWithObjects:@"Present", @"Past Imperfect", @"Past Preterite", @"Future", @"Conditional", @"Imperative", @"Present Subjunctive", @"Imperfect Subjunctive", nil];
    bool editingWord = false;
    if ([[Database GetInstance] activeWord] != nil)
    {
        editingWord = true;
    }
    switch (layout)
    {
        case 0:
            for (int i = 0; i < 2; i++)
            {
                for (int j = 0; j < 4; j++)
                {
                    ConjugationView *newView = [[ConjugationView alloc]initWithFrame:CGRectMake(2 + ((view.frame.size.width * .5) * i), 2 + (141 * j), (view.frame.size.width * .5) - 3 - (i * 1), 139) Title:titles[j + (i * 4)]];
                    [newView setBackgroundColor:[UIColor whiteColor]];
                    [view addSubview:newView];
                    if (editingWord)
                    {
                        for (Conjugation *a in [[[Database GetInstance] activeWord] conjugations])
                        {
                            if ([[[a tense] uppercaseString] isEqualToString:[NSString stringWithFormat:@"%@",[titles[j + (i * 4)] uppercaseString]]])
                            {
                                [[newView inputs][0] setText:[a yo]];
                                [[newView inputs][1] setText:[a tu]];
                                [[newView inputs][2] setText:[a el]];
                                [[newView inputs][3] setText:[a nosotros]];
                                [[newView inputs][4] setText:[a vosotros]];
                                [[newView inputs][5] setText:[a ellos]];
                                break;
                            }
                        }
                    }
                }
            }
            break;
            
        case 1:
        case 2:
            for (int i = 0; i < 8; i++)
            {
                ConjugationView *newView = [[ConjugationView alloc]initWithFrame:CGRectMake(2, 2 + (141 * i), view.frame.size.width - 4, 139) Title:titles[i]];
                [newView setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:newView];
                if (editingWord)
                {
                    for (Conjugation *a in [[[Database GetInstance] activeWord] conjugations])
                    {
                        if ([[[a tense] uppercaseString] isEqualToString:[NSString stringWithFormat:@"%@",[titles[i] uppercaseString]]])
                        {
                            [[newView inputs][0] setText:[a yo]];
                            [[newView inputs][1] setText:[a tu]];
                            [[newView inputs][2] setText:[a el]];
                            [[newView inputs][3] setText:[a nosotros]];
                            [[newView inputs][4] setText:[a vosotros]];
                            [[newView inputs][5] setText:[a ellos]];
                            break;
                        }
                    }
                }
            }
            break;
    
        default:
            break;
    }
}

@end
