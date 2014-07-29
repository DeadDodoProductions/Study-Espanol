//
//  WordTypeSectionView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordTypeSectionView.h"
#import "SwitchController.h"
#import "Switch.h"
#import "Database.h"
#import "Word.h"

@implementation WordTypeSectionView

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        switchSpace = 37;
        titleSpace = 47;
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
        [self CreateSectionWithParentView:parentView Layout:layout];
    }
    return self;
}

-(void)CreateSectionWithParentView:(UIView*)parentView Layout:(int)layout
{
    NSLog(@"Creating Word Type Section");
    [SwitchController GetInstance].wtSwitches = [[NSMutableArray alloc]init];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width * .5, 30)];
    [title setText:@"Word Type"];
    [self addSubview:title];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"Noun", @"Verb", @"Adjective", @"Adverb", @"Pronoun", @"Conjunction", @"Preposition", @"Number", nil];
    for (int i = 0; i < 8; i++)
    {
        NSLog(@"Creating: %@", array[i]);
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, titleSpace + (i * switchSpace), self.frame.size.width * .7, 30)];
        newLabel.text = array[i];
        [newLabel setTag:0];
        [self addSubview:newLabel];
        
        Switch *newSwitch = [[Switch alloc]initWithFrame:CGRectMake(self.frame.size.width * .7 + 5, titleSpace + (i * switchSpace), 0, 0)];
        [newSwitch setGroup:0];
        [newSwitch setValue:[NSNumber numberWithInt:i]];
        [newSwitch setTag:1];
        [[[SwitchController GetInstance] wtSwitches] addObject:newSwitch];
        [self addSubview:newSwitch];
        
        if ([[Database GetInstance] activeWord] != nil)
        {
            if ([[[[Database GetInstance] activeWord] wordType] isEqualToNumber:[NSNumber numberWithInt:i]])
            {
                NSLog(@"It Worked!!");
                [newSwitch setOn:true animated:true];
                [[Database GetInstance] setWordType:[NSNumber numberWithInt:i]];
            }
        }
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newLabel.frame.origin.y + newLabel.frame.size.height + 6)];
    }
}
@end
