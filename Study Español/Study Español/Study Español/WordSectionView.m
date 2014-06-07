//
//  WordSectionView.m
//  Study Español
//
//  Created by Evan Combs on 6/6/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "WordSectionView.h"
#import "TextView.h"
#import "Database.h"
#import "Word.h"

@implementation WordSectionView

- (id)initAddEditWithFrame:(CGRect)frame ParentView:(UIView*)parentView Layout:(int)layout
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"Creating Word Section");
        truePosition = CGPointMake(parentView.frame.origin.x + self.frame.origin.x, parentView.frame.origin.y + self.frame.origin.y);
        NSArray *titles = [[NSArray alloc]initWithObjects:@"English", @"Español", @"Pronunciation", @"Definition", nil];
        for (int i = 0; i < 4; i++)
        {
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 47 * i + 5, 110, 40)];
            [newLabel setText:[NSString stringWithFormat:@"%@", titles[i]]];
            [self addSubview:newLabel];
            
            TextView *newTextView = [[TextView alloc]initWithFrame:CGRectMake(newLabel.frame.size.width + 10, 47 * i + 5, self.frame.size.width - (newLabel.frame.size.width + 14), 40)];
            if (i == 3)
            {
                [newTextView setFrame:CGRectMake(newTextView.frame.origin.x, newTextView.frame.origin.y, newTextView.frame.size.width, newTextView.frame.size.height * 4)];
            }
            [newTextView setDelegate:self];
            [self addSubview:newTextView];
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
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newTextView.frame.origin.y + newTextView.frame.size.height + 5)];
        }
    }
    return self;
}
@end
