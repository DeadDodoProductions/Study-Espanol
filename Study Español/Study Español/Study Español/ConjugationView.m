//
//  ConjugationView.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This subview displays an interface allowing the user to input the verb's conjugations

#import "ConjugationView.h"
#import "TextView.h"
#import "BaseView.h"

@implementation ConjugationView
@synthesize labels, inputs, background, titleLabel;
///Initalization
-(id)initWithFrame:(CGRect)frame Title:(NSString*)title ParentViewFrame:(CGRect)parentViewFrame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Conjugation View: %@", title);
        truePosition = CGPointMake(parentViewFrame.origin.x + frame.origin.x, parentViewFrame.origin.y + frame.origin.y);
        labels = [[NSMutableArray alloc]init];
        inputs = [[NSMutableArray alloc]init];
        
        //sets the background color
        background = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:background];
        
        //Creating Title Label that displays the Tense
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 200, 30)];
        [titleLabel setText:[NSString stringWithFormat:@"%@", title]];
        [labels addObject:titleLabel];
        [self addSubview:titleLabel];
        
        //controls the margin between two items vertically
        int spacing = self.frame.size.height * .25;
        int height = 30;
        
        NSArray *pronouns = [[NSArray alloc]initWithObjects:@"yo", @"tu", @"el", @"nos", @"vos", @"ellos", nil];
        
        for (int i = 0; i < 2; i++)
        {
            NSLog(@"i: %d", i);
            for (int j = 0; j < 3; j++)
            {
                NSLog(@"j: %d", j);
                NSLog(@"Creating Label: %@", pronouns[j + (i * 3)]);
                //the label indicates which conjugation form is being used
                UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + (i * (self.frame.size.width * .5)), 35 + (j * spacing), 40, height)];
                [newLabel setText:[NSString stringWithFormat:@"%@", pronouns[j + (i * 3)]]];
                [self addSubview:newLabel];
                
                //the words conjugation form is entered here
                TextView *newTextView = [[TextView alloc]initWithFrame:CGRectMake(45 + (i * (self.frame.size.width * .5)), 35 + (j * spacing), (self.frame.size.width * .35), height)];
                //[newTextView setDelegate:self];
                [newTextView setTag:j + (i * 3)];
                [inputs addObject:newTextView];
                [self addSubview:newTextView];
            }
        }
    }
    return self;
}
@end
