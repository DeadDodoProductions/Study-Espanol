//
//  AddEditView.h
//  Study Español
//
//  Created by Evan on 4/1/14.
//  Copyright (c) 2014 Evan Combs. All rights reserved.
//

#import "BaseView.h"
#import "WordTagSectionView.h"

@class WordSectionView, WordTagSectionView, WordTypeSectionView, VerbTypeSectionView, MiscSectionView, ConjugationTypeSectionView;

@interface AddEditView : BaseView <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, WordTagSectionDelagate>
{
    CGRect startRect;
    NSMutableArray *tags;
    WordSectionView *wordSectionView;
    WordTagSectionView *wordTagSectionView;
    WordTypeSectionView *wordTypeSectionView;
    VerbTypeSectionView *verbTypeSectionView;
    MiscSectionView *miscSectionView;
    ConjugationTypeSectionView *conjugationTypeSectionView;
}
@property (nonatomic, readwrite) bool editingWord;
- (void)isEditingWord;
-(void)NewTag;

@end
