//
//  QuizConjugation.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@interface QuizConjugation : BaseView
{
    NSMutableArray *answers;
    NSMutableArray *words;
    int currentConjugation;
    int layout;
}

@end
