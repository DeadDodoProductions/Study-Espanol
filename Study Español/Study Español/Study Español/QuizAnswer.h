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
    ViewWord *viewWord;
    UICollectionViewFlowLayout *flow;
    NSArray *words;
    NSArray *answers;
    UICollectionView *wordCollectionView;
}
-(void)SetArrays:(NSArray*)_words Answers:(NSArray*)_answers;

@end
