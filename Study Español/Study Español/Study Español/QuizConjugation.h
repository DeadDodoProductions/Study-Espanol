//
//  QuizConjugation.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@interface QuizConjugation : BaseView <UITextViewDelegate>
{
    int wordNumber; //used to determine the currently active word
    int total; //holds the total amount of possible answers
    NSMutableArray *answers; //holds the data entered by the user
    NSMutableArray *words; //holds the correct answers
    NSMutableArray *tenses; //holds strings of each possible conjugation tense
    UILabel *wordLabel; //signifies the word being conjugated
    ConjugationView *conjugationView; //subview displaying the input fields
}

@end
