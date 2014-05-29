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

@implementation ConjugationView
@synthesize labels, inputs, background, titleLabel;
///Initalization
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Creating Conjugation View: %@", title);
        labels = [[NSMutableArray alloc]init];
        inputs = [[NSMutableArray alloc]init];
        background = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:background];
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 200, 30)];
        [titleLabel setText:[NSString stringWithFormat:@"%@", title]];
        [labels addObject:titleLabel];
        [self addSubview:titleLabel];
        int spacing = self.frame.size.height * .25;
        
        NSArray *pronouns = [[NSArray alloc]initWithObjects:@"yo", @"tu", @"el", @"nos", @"vos", @"ellos", nil];
        
        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                NSLog(@"Creating Label: %@", pronouns[j + (i * 3)]);
                UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + (i * (self.frame.size.width * .5)), 35 + (j * spacing), 40, 30)];
                [newLabel setText:[NSString stringWithFormat:@"%@", pronouns[j + (i * 3)]]];
                [self addSubview:newLabel];
                
                TextView *newTextView = [[TextView alloc]initWithFrame:CGRectMake(45 + (i * (self.frame.size.width * .5)), 35 + (j * spacing), (self.frame.size.width * .35), 30)];
                [newTextView setTag:j + (i * 3)];
                [inputs addObject:newTextView];
                [self addSubview:newTextView];
            }
        }
    }
    return self;
}
@end
