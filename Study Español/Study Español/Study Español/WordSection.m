//
//  WordSection.m
//  Study Español
//
//  Created by Evan on 4/22/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This section is used by the AddEditView class.
//  Creates an interface for inputing the words english form, spanish form, pronunciation in spanish, and definition in spanish

#import "WordSection.h"
#import "Word.h"
#import "TextView.h"
#import "Database.h"


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
        if ([[Database GetInstance] activeWord] != nil)
        {
            switch (i)
            {
                case 0:
                    [newTextView setText:[[[Database GetInstance]activeWord] english]];
                    break;
                    
                case 1:
                    [newTextView setText:[[[Database GetInstance]activeWord] spanish]];
                    break;
                    
                case 2:
                    [newTextView setText:[[[Database GetInstance]activeWord] pronunciation]];
                    break;
                    
                case 3:
                    [newTextView setText:[[[Database GetInstance]activeWord] definition]];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end
