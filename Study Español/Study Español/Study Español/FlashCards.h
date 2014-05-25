//
//  FlashCards.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@interface FlashCards : BaseView
{
    Button *prevButton;
    Button *nextButton;
    Button *answerButton;
    Button *viewWordButton;
    UILabel *wordLabel;
    UILabel *answerLabel;
    ViewWord *viewWord;
    int currentWord;
}

@end
