//
//  WordTypeSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordTypeSection.h"
#import "Switch.h"
#import "SwitchController.h"
#import "AddEditView.h"
#import "Database.h"
#import "Word.h"

@implementation WordTypeSection
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    switchSpace = 35;
    titleSpace = 40;
   [self CreateSection:view SuperView:superView Layout:layout];
}

-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    switchSpace = 37;
    titleSpace = 47;
    [self CreateSection:view SuperView:superView.view Layout:layout];
}

-(void)CreateSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    NSLog(@"Creating Word Type Section");
    [SwitchController GetInstance].wtSwitches = [[NSMutableArray alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .5, 30)];
    title.text = @"Word Type";
    [view addSubview:title];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"Noun", @"Verb", @"Adjective", @"Adverb", @"Pronoun", @"Conjunction", @"Preposition", @"Number", nil];
    for (int i = 0; i < 8; i++)
    {
        NSLog(@"Creating: %@", array[i]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace + (i * switchSpace), view.frame.size.width * .7, 30)];
        newLabel.text = array[i];
        [newLabel setTag:0];
        [view addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, titleSpace + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:0];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] wtSwitches] addObject:newSwitch];
        [view addSubview:newSwitch];

        if ([[Database GetInstance] activeWord] != nil)
        {
            if ([[[[Database GetInstance] activeWord] wordType] isEqualToNumber:[NSNumber numberWithInt:i]])
            {
                NSLog(@"It Worked!!");
                [newSwitch setOn:true animated:true];
            }
        }
    }
}


@end
