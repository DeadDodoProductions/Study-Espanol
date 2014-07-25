//
//  WordList.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"
#import "ViewWord.h"

@interface WordList : BaseView <ViewWordDelagate, UIScrollViewDelegate>
{
    UICollectionView *wordCollectionView;
    UICollectionViewFlowLayout *flow;
    ViewWord *viewWord;
    int offsetX;
}

@end
