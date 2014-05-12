//
//  ViewWord.m
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//
//  This needs to be a singleton

#import "ViewWord.h"
#import "Word.h"

@implementation ViewWord

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)CreateWordView:(Word*)word
{
    UILabel *english = [[UILabel alloc]init];
    [english setText:[NSString stringWithFormat:@"English: %@", word.english]];
    [self addSubview:english];
    
    UILabel *spanish = [[UILabel alloc]init];
    [spanish setText:[NSString stringWithFormat:@"Spanish: %@", word.spanish]];
    [self addSubview:spanish];
    
    if (word.pronunciation.length != 0)
    {
        UILabel *pronunciation = [[UILabel alloc]init];
        [pronunciation setText:[NSString stringWithFormat:@"Pronunciation: %@", word.pronunciation]];
        [self addSubview:pronunciation];
    }
    if (word.definition.length != 0)
    {
        UILabel *definition = [[UILabel alloc]init];
        [definition setText:[NSString stringWithFormat:@"Definition: %@", word.definition]];
        [self addSubview:definition];
    }
    
    UILabel *wordType = [[UILabel alloc]init];
    NSArray *wordTypes = [[NSArray alloc]initWithObjects:@"Noun", @"Verb", @"Adjective", @"Adverb", @"Pronoun", @"Conjunction", @"Preposition", @"Number", nil];
    [wordType setText:[NSString stringWithFormat:@"Word Type: %@", wordTypes[(int)word.wordType]]];
    [self addSubview:wordType];
    
    if (word.gender != 0)
    {
        UILabel *gender = [[UILabel alloc]init];
        NSString *genderString = [[NSString alloc]init];
        if (word.gender == 1)
        {
            genderString = @"Masculine";
        }
        else
        {
            genderString = @"Feminine";
        }
        [gender setText:[NSString stringWithFormat:@"Gender: %@", genderString]];
        [self addSubview:gender];
    }
    if (word.wordType == 1)
    {
        NSArray *verbTypes = [[NSArray alloc]initWithObjects:@"AR", @"ER", @"IR", @"Regular", @"Irregular", nil];
        UILabel *verbType = [[UILabel alloc]init];
        [verbType setText:[NSString stringWithFormat:@"Verb Type: %@, %@", verbTypes[(int)word.verbEnding], verbTypes[(int)word.verbType + 3]]];
        [self addSubview:verbType];
        UIScrollView *conjugations = [[UIScrollView alloc]init];
    }
}
@end
