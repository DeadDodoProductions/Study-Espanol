//
//  WordList.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"

@interface WordList : BaseView
{
    UICollectionView *collectionView;
    ViewWord *viewWord;
    UICollectionViewFlowLayout *layout;
}

@end
