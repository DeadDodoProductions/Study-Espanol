//
//  QuizAnswer.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"
#import "ViewWord.h"

@interface QuizAnswer : BaseView <ViewWordDelagate>
{
    int total;
    NSArray *words;
    NSArray *answers;
    NSArray *tenses;
    NSArray *corrections;
    UICollectionView *wordCollectionView;
    UICollectionViewFlowLayout *flow;
    ViewWord *viewWord;
}
-(void)SetArraysForVocab:(NSArray*)_words Answers:(NSArray*)_answers;
-(void)SetArraysForConjugation:(NSArray*)_words Tense:(NSArray*)_tense Correct:(NSArray*)_correct Answers:(NSArray*)_answers Total:(int)_total;

@end
