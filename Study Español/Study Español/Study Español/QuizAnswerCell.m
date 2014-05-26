//
//  QuizAnswerCell.m
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This cell is used in the QuizAnswers class to display the words answered incorrectly

#import "QuizAnswerCell.h"

@implementation QuizAnswerCell
@synthesize word, wordTitle, answer, answerTitle, correction, correctionTitle;
///Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        wordTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * .3334, frame.size.height * .3334)];
        [wordTitle setText:@"Word"];
        [wordTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:wordTitle];
        word = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height * .3334, frame.size.width * .3334, frame.size.height * .6667)];
        [word setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:word];
        
        answerTitle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .3334, 0, frame.size.width * .3334, frame.size.height * .3334)];
        [answerTitle setText:@"Answer"];
        [answerTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:answerTitle];
        answer = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .3334, frame.size.height * .3334, frame.size.width * .3334, frame.size.height * .6667)];
        [answer setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:answer];
        
        correctionTitle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .6667, 0, frame.size.width * .3334, frame.size.height * .3334)];
        [correctionTitle setText:@"Correction"];
        [correctionTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:correctionTitle];
        correction = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .6667, frame.size.height * .3334, frame.size.width * .3334, frame.size.height * .6667)];
        [correction setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:correction];
    }
    return self;
}

@end
