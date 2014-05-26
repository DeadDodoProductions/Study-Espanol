//
//  WordListCell.m
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This cell is used by the WordList class to display the word's basic information

#import "WordListCell.h"

@implementation WordListCell
@synthesize cellLabel;
//Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:cellLabel];
    }
    return self;
}

@end
