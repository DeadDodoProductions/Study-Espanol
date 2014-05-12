//
//  WordTypeSection.m
//  Study Español
//
//  Created by Evan on 4/20/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordTypeSection.h"
#import "Switch.h"

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
        [view addSubview:newSwitch];
    }
    int i = 2;
    while (i < 17)
    {
        int j = 2;
        while (j < 17)
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
