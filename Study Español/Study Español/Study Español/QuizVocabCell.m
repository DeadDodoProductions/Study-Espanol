//
//  QuizVocabCell.m
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This cell is used in the QuizVocab class to display the word to be answered, and the textbox it need to be answered in

#import "QuizVocabCell.h"
#import "TextView.h"

@implementation QuizVocabCell
@synthesize wordField, wordLabel, theDelagate;
///Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, (frame.size.width * .5) - 2, frame.size.height - 4)];
        wordField = [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width * .5, (frame.size.height * .5) - 15, (frame.size.width * .5) - 3, 30)];
        [wordField setBackgroundColor:[UIColor whiteColor]];
        [wordField setDelegate:self];
        [self addSubview:wordLabel];
        [self addSubview:wordField];
    }
    return self;
}

//UITextView Delagate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [theDelagate OnFinishAnsweringWord:textField];
}
@end
