//
//  WordSection.m
//  Study Español
//
//  Created by Evan on 4/22/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordSection.h"
#import "TextView.h"

@implementation WordSection
-(void)CreateAddEditSection:(UIView*)view SuperView:(UIViewController*)superView Layout:(int)layout
{
    NSLog(@"Creating Word Section");
    NSArray *titles = [[NSArray alloc]initWithObjects:@"English", @"Español", @"Pronunciation", @"Definition", nil];
    for (int i = 0; i < 4; i++)
    {
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 47 * i + 5, 110, 40)];
        [newLabel setText:[NSString stringWithFormat:@"%@", titles[i]]];
        [view addSubview:newLabel];
        
        TextView *newTextView = [[TextView alloc]initWithFrame:CGRectMake(newLabel.frame.size.width + 10, 47 * i + 5, view.frame.size.width - (newLabel.frame.size.width + 14), 40)];
        if (i == 3)
        {
            [newTextView setFrame:CGRectMake(newTextView.frame.origin.x, newTextView.frame.origin.y, newTextView.frame.size.width, newTextView.frame.size.height * 4)];
        }
        [view addSubview:newTextView];
    }
}

@end
