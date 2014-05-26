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
    int currentConjugation;
    NSMutableArray *answers;
    NSMutableArray *words;
}

@end
