//
//  QuizVocab.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"
#import "QuizVocabCell.h"

@interface QuizVocab : BaseView <QuizVocabCellDelagate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *textFields;
    UICollectionView *vocabCollectionView;
    UICollectionViewFlowLayout *flow;
}

@end
