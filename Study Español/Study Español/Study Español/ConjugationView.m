//
//  ConjugationView.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "ConjugationView.h"
#import "TextView.h"

@implementation ConjugationView
@synthesize labels, inputs, background;
- (id)initWithFrame:(CGRect)frame Title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Creating Conjugation View: %@", title);
        labels = [[NSMutableArray alloc]init];
        inputs = [[NSMutableArray alloc]init];
        background = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:background];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 200, 30)];
        [titleLabel setText:[NSString stringWithFormat:@"%@", title]];
        [labels addObject:titleLabel];
        [self addSubview:titleLabel];
        
        NSArray *pronouns = [[NSArray alloc]initWithObjects:@"yo", @"tu", @"el", @"nos", @"vos", @"ellos", nil];
        
        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                NSLog(@"Creating Label: %@", pronouns[j + (i * 3)]);
                UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + (i * (self.frame.size.width * .5)), 35 + (j * 35), 40, 30)];
                [newLabel setText:[NSString stringWithFormat:@"%@", pronouns[j + (i * 3)]]];
                [self addSubview:newLabel];
                
                TextView *newTextView = [[TextView alloc]initWithFrame:CGRectMake(45 + (i * (self.frame.size.width * .5)), 35 + (j * 35), (self.frame.size.width * .35), 30)];
                [inputs addObject:newTextView];
                [self addSubview:newTextView];
            }
        }
    }
    return self;
}
@end
