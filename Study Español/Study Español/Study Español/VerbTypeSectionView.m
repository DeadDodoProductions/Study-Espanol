//
//  VerbTypeSectionView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "VerbTypeSectionView.h"
#import "SwitchController.h"
#import "Switch.h"
#import "Database.h"
#import "Word.h"

@implementation VerbTypeSectionView

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        switchSpace = 37;
        titleSpace = 47;
        titleSpace2 = 175;
        [self CreateSectionWithParentView:parentView Layout:layout];
    }
    return self;
}

- (id)initSearchWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        switchSpace = 35;
        titleSpace = 40;
        titleSpace2 = 160;
        [self CreateSectionWithParentView:parentView Layout:layout];
    }
    return self;
}

-(void)CreateSectionWithParentView:(UIView*)parentView Layout:(int)layout
{
    NSLog(@"Creating Verb Type Section");
    [SwitchController GetInstance].veSwitches = [[NSMutableArray alloc]init];
    [SwitchController GetInstance].vrSwitches = [[NSMutableArray alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .5, 30)];
    title.text = @"Verb Type";
    [self addSubview:title];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"AR", @"ER", @"IR", @"Regular", @"Irregular", nil];
    for (int i = 0; i < 3; i++)
    {
        NSLog(@"Creating: %@", array[i]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace + (i * switchSpace), self.frame.size.width * .7, 30)];
        newLabel.text = array[i];
        [newLabel setTag:0];
        [self addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, titleSpace + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:1];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] veSwitches] addObject:newSwitch];
        [self addSubview:newSwitch];
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
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace2 + (i * switchSpace), self.frame.size.width * .7, 30)];
        newLabel.text = array[i + 3];
        [newLabel setTag:0];
        [self addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, titleSpace2 + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:2];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] vrSwitches] addObject:newSwitch];
        [self addSubview:newSwitch];
        if ([[Database GetInstance] activeWord] != nil)
        {
            if ([[[[Database GetInstance] activeWord] verbType] isEqualToNumber:[NSNumber numberWithInt:i]])
            {
                NSLog(@"It Worked!!");
                [newSwitch setOn:true animated:true];
            }
        }
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newLabel.frame.origin.y + newLabel.frame.size.height + 5)];
    }
}

@end
