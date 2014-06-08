//
//  ConjugationTypeSearchView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "ConjugationTypeSectionView.h"
#import "Database.h"
#import "ConjugationView.h"
#import "Conjugation.h"
#import "Word.h"
#import "Switch.h"
#import "SwitchController.h"

@implementation ConjugationTypeSectionView

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIViewController*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
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
                        ConjugationView *newView = [[ConjugationView alloc]initWithFrame:CGRectMake(2 + ((self.frame.size.width * .5) * i), 2 + (141 * j), (self.frame.size.width * .5) - 3 - (i * 1), 139) Title:titles[j + (i * 4)] ParentView:self];
                        [newView setBackgroundColor:[UIColor whiteColor]];
                        [self addSubview:newView];
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
                    ConjugationView *newView = [[ConjugationView alloc]initWithFrame:CGRectMake(2, 2 + (141 * i), self.frame.size.width - 4, 139) Title:titles[i] ParentView:self];
                    [newView setBackgroundColor:[UIColor whiteColor]];
                    [self addSubview:newView];
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
    return self;
}

- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Conjugation Type Section");
        [SwitchController GetInstance].ctSwitches = [[NSMutableArray alloc]init];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .5, 30)];
        title.text = @"Conjugation Type";
        [self addSubview:title];
        
        NSArray *titles = [[NSArray alloc]initWithObjects:@"Present", @"Past Imperfect", @"Past Preterite", @"Future", @"Conditional", @"Imperative", @"Present Subjunctive", @"Imperfect Subjunctive", nil];
        for (int i = 0; i < 8; i++)
        {
            NSLog(@"Creating: %@", titles[i]);
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40 + (i * 35), self.frame.size.width * .7, 30)];
            newLabel.text = titles[i];
            [self addSubview:newLabel];
            
            Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, 40 + (i * 35), 0, 0)];
            [newSwitch setGroup:4];
            [newSwitch setValue:[NSNumber numberWithInt:i]];
            [[[SwitchController GetInstance] ctSwitches] addObject:newSwitch];
            [self addSubview:newSwitch];
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newLabel.frame.origin.y + newLabel.frame.size.height + 5)];
        }
    }
    return self;
}
@end
