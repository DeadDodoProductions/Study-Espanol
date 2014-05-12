//
//  QuizVocabCell.m
//  Study Español
//
//  Created by Evan on 4/29/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "QuizVocabCell.h"
#import "TextView.h"

@implementation QuizVocabCell
@synthesize wordField, wordLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, (frame.size.width * .5) - 2, frame.size.height - 4)];
        wordField = [[TextView alloc]initWithFrame:CGRectMake(frame.size.width * .5, (frame.size.height * .5) - 15, (frame.size.width * .5) - 3, 30)];
        [self addSubview:wordLabel];
        [self addSubview:wordField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
