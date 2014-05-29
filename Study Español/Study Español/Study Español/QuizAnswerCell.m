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
@synthesize wordLabel, wordTitle, answerLabel, answerTitle, correctionLabel, correctionTitle, tenseLabel;
///Initalization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int labelHeight = frame.size.height * .25;
        
        wordTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, frame.size.width * .3334, labelHeight)];
        [wordTitle setText:@"Word"];
        [wordTitle setTextAlignment:NSTextAlignmentCenter];
        [wordTitle setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:wordTitle];
        
        answerTitle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .3334, 1, frame.size.width * .3334, labelHeight)];
        [answerTitle setText:@"Answer"];
        [answerTitle setTextAlignment:NSTextAlignmentCenter];
        [answerTitle setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:answerTitle];
        
        
        correctionTitle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width * .6667, 1, frame.size.width * .3334, labelHeight)];
        [correctionTitle setText:@"Correction"];
        [correctionTitle setTextAlignment:NSTextAlignmentCenter];
        [correctionTitle setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:correctionTitle];
        
    }
    return self;
}

-(void)CreateCell:(NSString*)word Answer:(NSString*)answer Correction:(NSString*)correction
{
    int y = self.frame.size.height * .30;
    int width = self.frame.size.width * .32;
    int height = self.frame.size.height * .70;
    
    wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, y, width, height)];
    [wordLabel setTextAlignment:NSTextAlignmentCenter];
    [wordLabel setText:word];
    [wordLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:wordLabel];
    
    answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .3334, y, width, height)];
    [answerLabel setTextAlignment:NSTextAlignmentCenter];
    [answerLabel setText:answer];
    [answerLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:answerLabel];
    
    correctionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .6667, y, width, height)];
    [correctionLabel setTextAlignment:NSTextAlignmentCenter];
    [correctionLabel setText:correction];
    [correctionLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:correctionLabel];
}

-(void)CreateCell:(NSString*)word Tense:(NSString*)tense Answer:(NSString*)answer Correction:(NSString*)correction
{
    int width = self.frame.size.width * .3;
    
    tenseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * .30, width, self.frame.size.height * .25)];
    [tenseLabel setTextAlignment:NSTextAlignmentCenter];
    [tenseLabel setText:tense];
    [tenseLabel setFont:[UIFont systemFontOfSize:15]];
    [tenseLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:tenseLabel];
    
    wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * .59, width, self.frame.size.height * .35)];
    [wordLabel setTextAlignment:NSTextAlignmentCenter];
    [wordLabel setText:word];
    [wordLabel setFont:[UIFont systemFontOfSize:17]];
    [wordLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:wordLabel];
    
    answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .34, self.frame.size.height * .25, width, self.frame.size.height * .6667)];
    [answerLabel setTextAlignment:NSTextAlignmentCenter];
    [answerLabel setText:answer];
    [answerLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:answerLabel];
    
    correctionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * .68, self.frame.size.height * .25, width, self.frame.size.height * .6667)];
    [correctionLabel setTextAlignment:NSTextAlignmentCenter];
    [correctionLabel setText:correction];
    [correctionLabel setBackgroundColor:[UIColor grayColor]];
    [self addSubview:correctionLabel];
}

@end
