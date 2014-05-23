//
//  VerbTypeSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "VerbTypeSection.h"
#import "Switch.h"
#import "SwitchController.h"
#import "Database.h"
#import "Word.h"

@implementation VerbTypeSection
-(void)CreateSearchSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    switchSpace = 35;
    titleSpace = 40;
    titleSpace2 = 160;
    [self CreateSection:view SuperView:superView Layout:layout];
}

-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    switchSpace = 37;
    titleSpace = 47;
    titleSpace2 = 175;
    [self CreateSection:view SuperView:superView.view Layout:layout];
}

-(void)CreateSection:(UIView*)view SuperView:(UIView*)superView Layout:(int)layout
{
    NSLog(@"Creating Verb Type Section");
    [SwitchController GetInstance].veSwitches = [[NSMutableArray alloc]init];
    [SwitchController GetInstance].vrSwitches = [[NSMutableArray alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, view.frame.size.width * .5, 30)];
    title.text = @"Verb Type";
    [view addSubview:title];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"AR", @"ER", @"IR", @"Regular", @"Irregular", nil];
    for (int i = 0; i < 3; i++)
    {
        NSLog(@"Creating: %@", array[i]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace + (i * switchSpace), view.frame.size.width * .7, 30)];
        newLabel.text = array[i];
        [newLabel setTag:0];
        [view addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, titleSpace + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:1];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] veSwitches] addObject:newSwitch];
        [view addSubview:newSwitch];
        if ([[Database GetInstance] activeWord] != nil)
        {
            if ([[[[Database GetInstance] activeWord] verbEnding] isEqualToNumber:[NSNumber numberWithInt:i]])
            {
                NSLog(@"It Worked!!");
                [newSwitch setOn:true animated:true];
            }
        }
    }
    for (int i = 0; i < 2; i++)
    {
        NSLog(@"Creating: %@", array[i + 3]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace2 + (i * switchSpace), view.frame.size.width * .7, 30)];
        newLabel.text = array[i + 3];
        [newLabel setTag:0];
        [view addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(view.frame.size.width * .7 + 5, titleSpace2 + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:2];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] vrSwitches] addObject:newSwitch];
        [view addSubview:newSwitch];
        if ([[Database GetInstance] activeWord] != nil)
        {
            if ([[[[Database GetInstance] activeWord] verbType] isEqualToNumber:[NSNumber numberWithInt:i]])
            {
                NSLog(@"It Worked!!");
                [newSwitch setOn:true animated:true];
            }
        }
    }
}

@end
